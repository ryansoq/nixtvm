#!/bin/sh
# This file is intended to be sourced from Docker container's interactive shell

export CWD=`pwd`

# User Aliasing
case $USER in
  grwlf) USER=mironov ;;
  *) ;;
esac

export TVM=$CWD/src/$USER/tvm
export PYTHONPATH="$CWD/src/$USER:$TVM/python:$TVM/topi/python:$TVM/nnvm/python:$TVM/nnvm/tests/python:$PYTHONPATH"
export LD_LIBRARY_PATH="$TVM/build-docker:$LD_LIBRARY_PATH"
export C_INCLUDE_PATH="$TVM/include:$TVM/dmlc-core/include:$TVM/HalideIR/src:$TVM/dlpack/include:$TVM/topi/include:$TVM/nnvm/include:$TVM/3rdparty/dlpack/include:$TVM/3rdparty/dmlc-core/include:$TVM/3rdparty/HalideIR/src"
export CPLUS_INCLUDE_PATH="$C_INCLUDE_PATH"
export LIBRARY_PATH=$TVM/build-docker

cdtvm() { cd $TVM ; }
cdex() { cd $TVM/nnvm/examples; }

dclean() {(
  cdtvm
  cd build-docker
  make clean
  rm CMakeCache.txt
  rm -rf CMakeFiles
)}

dmake() {(
  cdtvm
  mkdir build-docker 2>/dev/null
  cp $TVM/cmake/config.cmake $TVM/build-docker/config.cmake
  sed -i 's/USE_LLVM OFF/USE_LLVM ON/g' $TVM/build-docker/config.cmake
  ./tests/scripts/task_build.sh build-docker "$@" -j6
  ln -f -s build-docker build # FIXME: Python uses 'build' name
)}

alias build="dmake"

dtest() {(
  cdtvm
  ./tests/scripts/task_python_nnvm.sh
)}

djupyter() {(
  jupyter-notebook --ip 0.0.0.0 --port 8888 --NotebookApp.token='' --NotebookApp.password='' "$@" --no-browser
)}

dtensorboard() {(
  mkdir $CWD/_logs 2>/dev/null
  tensorboard --logdir=$CWD/_logs "$@"
)}

cdc() {(
  cd $CWD
)}


