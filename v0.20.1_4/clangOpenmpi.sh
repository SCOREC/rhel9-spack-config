#!/bin/bash
spack add openmpi %clang@16.0.2
spack concretize
spack install --fail-fast
