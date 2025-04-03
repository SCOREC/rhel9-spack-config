# rhel9-spack-config
RHEL9 spack configuration files

## install a new spack stack

see `v0.20.1_4/README.admin`

## add a new simmetrix-simmodsuite version

Run the following script from within a spack environment to install the
specified version of SimModSuite:

```
./simmetrixScripts/installSimModSuite.sh <simmetrix password> <simmodsuite version> <dev=yes|no>
```

