#!/bin/bash

script_dir=$(dirname $(readlink -f "$0"))

go install github.com/asdf-vm/asdf/cmd/asdf@latest

# managed languages
asdf plugin add nodejs
asdf plugin add python
asdf plugin add php

# TODO: replace with just php when
# https://github.com/asdf-community/asdf-php/pull/172
# will be merged
asdf plugin add php https://github.com/pmysiak/asdf-php
asdf plugin update php patch-1

# python dependencies
# https://github.com/pyenv/pyenv/wiki#suggested-build-environment
sudo apt install -y make build-essential libssl-dev zlib1g-dev \
    libbz2-dev libreadline-dev libsqlite3-dev curl git \
    libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev \
    libffi-dev liblzma-dev

# install default tools
rm ${HOME}/.tool-versions
ln -sv ${script_dir}/tool-versions ${HOME}/.tool-versions

# install config
rm ${HOME}/.asdfrc
ln -sv ${script_dir}/asdfrc ${HOME}/.asdfrc
