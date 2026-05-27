#!/bin/bash

script_dir=$(dirname $(readlink -f "$0"))

# install direnv
sudo apt install -y direnv

# install direnv.toml
direnv_dir=${HOME}/.config/direnv
rm -rf ${direnv_dir}
mkdir -p ${direnv_dir}
ln -sv ${script_dir}/direnv.toml ${direnv_dir}/direnv.toml
