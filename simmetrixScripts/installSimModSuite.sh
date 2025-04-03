#!/bin/bash
pass=$1
version=$2
dev=$3

doesDownloadExist() {
  version=$1
  [ -d $version ] && echo 1
  [ ! -d $version ] && echo 0
}

checkDownloadExists() {
  version=$1
  [ ! -d $version ] && "ERROR: download failed" && exit 1
}

checkChecksumNotEmpty() {
  file=$1
  [ ! -s $file ] && echo "ERROR: checksum file is empty" && exit 1
}

checkSpackExists() {
  which spack
  [ $? == 1 ] && echo "ERROR: spack command not available" && exit 1
}

isVersionChecksumListed() {
  version=$1
  pkg=$2
  grep -q $version $pkg
  [ $? == 0 ] && echo 1 #exists
  [ $? == 1 ] && echo 0 #does not exist
}

doesDownloadExist $version
[ $? == 0 ] && ./downloadSimModSuite.sh sci001 $pass $version 64 $dev
checkDownloadExists $version

checksumFile=`mktemp`
echo $checksumFile
./getSimModSuiteChecksums.py $version $version/ off  > $checksumFile #the 2nd arg needs the trailing '/'
checkChecksumNotEmpty $checksumFile

checkSpackExists
#copy the output to a buffer
pkg=`spack location --package-dir simmetrix-simmodsuite`/package.py
[ ! -e $pkg ] && exit 1

cp $pkg sim.bk
sed "/RELEASES = / r $checksumFile" $pkg > modifiedPkg
isVersionChecksumListed $version $pkg
[ $? == 0 ] && cp modifiedPkg $pkg

spec="pumi@develop %gcc@12.3.0 +shared simmodsuite=full ~simmodsuite_version_check +zoltan ^zoltan+parmetis~fortran ^simmetrix-simmodsuite@${version}"
spack add $spec # spack will not add the package if it already exists
spack concretize
pushd $version
spack install # spack will not install a package that is already installed
popd

spack module lmod refresh -y

./fixSimmodsuiteDocs.sh $(spack location -i simmetrix-simmodsuite@$version)/html
./updateSimmodsuiteDocs.sh $(spack location -i simmetrix-simmodsuite@$version) $version 1
