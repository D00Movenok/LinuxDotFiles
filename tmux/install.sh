#!/bin/bash

script_dir=$(dirname $(readlink -f "$0"))

# install tmux config
rm -rf ${HOME}/.tmux.conf
ln -sv ${script_dir}/tmux.conf ${HOME}/.tmux.conf
