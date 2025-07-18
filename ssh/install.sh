#!/bin/bash

script_dir=$(dirname $(readlink -f "$0"))

# by default .ssh does not exist
mkdir -m 700 -p ${HOME}/.ssh

# controllmasters dir to increase ssh speed
mkdir -m 700 -p ${HOME}/.ssh/controlmasters

# install ssh config
rm -rf ${HOME}/.ssh/config
ln -sv ${script_dir}/config ${HOME}/.ssh/config
