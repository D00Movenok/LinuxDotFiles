#!/bin/bash

script_dir=$(dirname $(readlink -f "$0"))

# install tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ${script_dir}/tmux/plugins/tpm
rm -rf ${HOME}/.tmux
ln -sv ${script_dir}/tmux ${HOME}/.tmux

# install tmux config
rm -rf ${HOME}/.tmux.conf
ln -sv ${script_dir}/tmux.conf ${HOME}/.tmux.conf

# install plugins
${script_dir}/tmux/plugins/tpm/bin/install_plugins
