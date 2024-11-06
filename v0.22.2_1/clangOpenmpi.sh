#!/bin/bash
spack add openmpi %clang@18.1.3
spack concretize
spack install --fail-fast
