#!/bin/bash

export SINGULARITY_VERSION="3.6.4"
cd build || exit 1
git clone https://github.com/sylabs/singularity.git
cd singularity || exit 1
git checkout "$SINGULARITY_VERSION"
git fetch --all
./mconfig
make -C ./builddir
sudo make -C ./builddir install
