#!/bin/bash

script_dir=$(dirname $(readlink -f "$0"))

sudo apt install -y vim

# install vim config
rm ${HOME}/.vimrc
ln -sv ${script_dir}/vimrc ${HOME}/.vimrc
