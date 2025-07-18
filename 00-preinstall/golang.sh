#!/bin/bash

sudo apt install -y golang

# autoupdates for "go install" binaries
go install github.com/nao1215/gup@latest

# linting and building
go install github.com/golangci/golangci-lint/v2/cmd/golangci-lint@latest
go install github.com/goreleaser/goreleaser/v2@latest
