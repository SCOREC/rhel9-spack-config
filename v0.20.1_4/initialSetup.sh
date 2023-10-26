#!/bin/bash
coreGcc="gcc@7.4.0"
spack add $coreGcc +binutils %gcc@11.3.1_rhel9
spack concretize
spack install --fail-fast
spack compiler add $(spack location -i $coreGcc)

spack add gcc@10.4.0 %${coreGcc}
spack concretize
spack install --fail-fast
spack compiler add $(spack location -i gcc@10.4.0)
spack add cuda@11.7.1%gcc@10.4.0
spack concretize
spack install --fail-fast

spack add gcc@12.3.0 %${coreGcc}
spack concretize
spack install --fail-fast
spack compiler add $(spack location -i gcc@12.3.0)
spack add cuda@12.1.1 %gcc@12.3.0
spack concretize
spack install --fail-fast
spack add mpich %gcc@12.3.0
spack concretize
spack install --fail-fast

spack add gcc@13.1.0 %${coreGcc}
spack concretize
spack install --fail-fast
spack compiler add $(spack location -i gcc@13.1.0)
spack add mpich %gcc@13.1.0
spack concretize
spack install --fail-fast

spack add llvm@16.0.2 +clang %${coreGcc}
spack concretize
spack install --fail-fast
spack compiler add $(spack location -i llvm@16.0.2)
