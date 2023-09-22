#!/bin/bash
coreGcc="gcc@7.4.0"
spack add $coreGcc +binutils %gcc@11.3.1_rhel9
spack concretize
spack install --fail-fast
spack compiler add $(spack location -i $coreGcc)
spack add gcc@13.1.0 %${coreGcc}
spack concretize
spack install --fail-fast
spack compiler add $(spack location -i gcc@13.1.0)
spack add llvm@16.0.2 +clang %${coreGcc}
spack concretize
spack install --fail-fast
spack compiler add $(spack location -i clang@16.0.2)
