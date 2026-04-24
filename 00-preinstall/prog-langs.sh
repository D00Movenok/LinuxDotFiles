#!/bin/bash

##
# python
##
sudo apt install -y python3
sudo apt install -y python-is-python3
# Python3 (pip + venv)
sudo apt install -y python3-pip
sudo apt install -y python3-venv
# Pipx
sudo apt install -y pipx
pipx ensurepath
# poetry
sudo apt install -y python3-poetry
# bpython
sudo apt install -y bpython

##
# golang
##
sudo apt install -y golang
# autoupdates for "go install" binaries
go install github.com/nao1215/gup@latest
# linting and building
go install github.com/golangci/golangci-lint/v2/cmd/golangci-lint@latest
go install github.com/goreleaser/goreleaser/v2@latest

##
# node
##
sudo apt install -y nodejs
sudo npm install -g pnpm
sudo npm install -g yarn

##
# rust
##
sudo apt install -y rustup
rustup default stable

##
# php
##
sudo apt install -y php
