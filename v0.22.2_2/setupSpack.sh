export SPACK_ROOT=/opt/scorec/spack/rhel9/spack0.22.2
export PATH=$SPACK_ROOT/bin:$PATH
source $SPACK_ROOT/share/spack/setup-env.sh
envDir=$SPACK_ROOT/v0222_2 #already exists and contains spack.yaml
export SPACK_DISABLE_LOCAL_CONFIG=true #disable use of user and system config files
export SPACK_USER_CACHE_PATH=$envDir
spack env activate $envDir
spack env status
