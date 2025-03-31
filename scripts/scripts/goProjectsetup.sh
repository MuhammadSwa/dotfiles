#!/bin/bash env

## name of the project
mkdir ~/goProjects/"$1"
cd ~/goProjects/"$1"
go mod init "$1"
git init
