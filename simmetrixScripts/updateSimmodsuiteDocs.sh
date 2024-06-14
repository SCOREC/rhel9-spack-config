#!/bin/bash -ex
[ $# -ne 3 ] && echo "Usage: $0 </path/to/install> <version string> <setToLatest=1|0>" && exit 1
path=$1
version=$2
makelatest=$3
cp -r $path/html /net/web/public/cwsmith/SCOREC/SimModSuite_$version
cd /net/web/public/cwsmith/SCOREC/
if [ $makelatest -eq 1 ]; then
  echo latest
  rm SimModSuite_latest
  ln -s SimModSuite_$version SimModSuite_latest
  cd -
fi
