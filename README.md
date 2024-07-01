# rhel9-spack-config
RHEL9 spack configuration files

## add a new simmetrix-simmodsuite version

```
./downloadSimModSuite.sh <user> <pass> <version> 64 <dev=yes|no>
./getSimModSuiteChecksums.py <version> <version>/ off  #the 2nd arg needs the trailing '/'
#copy the output to a buffer
spack edit simmetrix-simmodsuite
#paste the buffer at the top of the RELEASE list
spack config edit
#add the new version
spack concretize
cd <version> #spack needs to be in the dir with the tarballs + zips
spack install
spack module lmod refresh
```

