#!/bin/bash

script_dir=$(dirname $(readlink -f "$0"))

# git-lfs for large binary files
sudo apt install -y git-lfs
git lfs install

# git-delta for better diff preview
sudo apt install -y git-delta

# install .gitconfig
rm ${HOME}/.gitconfig
ln -sv ${script_dir}/gitconfig ${HOME}/.gitconfig
