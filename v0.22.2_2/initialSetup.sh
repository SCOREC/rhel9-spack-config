#!/bin/bash
coreGcc="gcc@11.4.1"
latestGcc="gcc@13.2.0"
latestLlvm="llvm@18.1.3"

spack add ${latestGcc} %${coreGcc}
spack concretize
spack install --fail-fast
spack compiler add $(spack location -i ${latestGcc})
spack add mpich %${latestGcc}
spack concretize
spack install --fail-fast

spack add ${latestLlvm} +clang %${coreGcc}
spack concretize
spack install --fail-fast
spack compiler add $(spack location -i ${latestLlvm})

gcc12="gcc@12.4.0"
spack add ${gcc12} %${coreGcc}
spack concretize
spack install --fail-fast
spack compiler add $(spack location -i ${gcc12})
spack add mpich %${gcc12}
spack concretize
spack install --fail-fast
