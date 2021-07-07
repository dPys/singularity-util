#!/bin/bash

export SINGULARITY_VERSION="2.6.1"
cd build || exit 1
git clone https://github.com/sylabs/singularity.git
cd singularity || exit 1
git checkout "$SINGULARITY_VERSION"
git fetch --all
./autogen.sh
./configure
make
make install
make clean
