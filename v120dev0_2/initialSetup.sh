#!/bin/bash
coreGcc="gcc@11.5.0"
latestGcc="gcc@15.2.0"
latestLlvm="llvm@22.1.3"

#still need to install the compiler first it seems
spack add ${latestGcc} %${coreGcc}
spack concretize
spack install --fail-fast
spack add mpich %${latestGcc}
#probably a better way to force cuda to use latestGcc for dependencies... my other
# attempts failed: %${latestGcc}, cc,cxx=${latestGcc}, etc.
spack add cuda@13.1.1 ^coreutils %${latestGcc} 
spack add cmake@4.2.3 %${latestGcc} 
spack add ninja %${latestGcc} 
spack concretize
spack install --fail-fast

## HAVEN'T RAN THE FOLLOWING YET
#spack add ${latestLlvm} +clang %${coreGcc}
#spack concretize
#spack install --fail-fast
#spack compiler add $(spack location -i ${latestLlvm})
