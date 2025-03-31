#!/bin/bash

# This script is used to create a new Go project
# Usage: ./goproject.sh <project_name>

# Check if the project name is provided
if [ -z "$1" ]; then
    echo "Please provide a project name"
    exit 1
fi

# Create the project directory
mkdir ~/goProjects/$1

# Create the main.go file
touch ~/goProjects/$1/main.go

# Create the go.mod file
cd ~/goProjects/$1
go mod init $1

# Create the .gitignore file
touch ~/goProjects/$1/.gitignore

# Add the .gitignore file contents
echo "bin/" >> ~/goProjects/$1/.gitignore
echo "pkg/" >> ~/goProjects/$1/.gitignore
echo "vendor/" >> ~/goProjects/$1/.gitignore

# Create the README.md file
touch ~/goProjects/$1/README.md

# Add the README.md file contents
echo "# $1" >> ~/goProjects/$1/README.md

# Create the LICENSE file
touch ~/goProjects/$1/LICENSE

# Add the LICENSE file contents
echo "MIT License" >> ~/goProjects/$1/LICENSE

# Create the .travis.yml file
touch ~/goProjects/$1/.travis.yml

# Add the .travis.yml file contents
echo "language: go" >> ~/goProjects/$1/.travis.yml
echo "go:" >> ~/goProjects/$1/.travis.yml
echo "  - 1.11.x" >> ~/goProjects/$1/.travis.yml
echo "  - 1.12.x" >> ~/goProjects/$1/.travis.yml
echo "  - tip" >> ~/goProjects/$1/.travis.yml
echo "matrix:" >> ~/goProjects/$1/.travis.yml
echo "  allow_failures:" >> ~/goProjects/$1/.travis.yml
echo "    - go: tip" >> ~/goProjects/$1/.travis.yml
echo "script:" >> ~/goProjects/$1/.travis.yml
echo "  - go test -v ./..." >> ~/goProjects/$1/.travis.yml

# Create the .github/workflows/go.yml file
mkdir ~/goProjects/$1/.github
mkdir ~/goProjects/$1/.github/workflows
touch ~/goProjects/$1/.github/workflows/go.yml

# Create the Makefile
touch ~/goProjects/$1/Makefile

# Add the .github/workflows/go.yml file contents
echo "name: Go" >> ~/goProjects/$1/.github/workflows/go.yml
echo "on:" >> ~/goProjects/$1/.github/workflows/go.yml
echo "  push:" >> ~/goProjects/$1/.github/workflows/go.yml
echo "    branches:" >> ~/goProjects/$1/.github/workflows/go.yml
echo "      - master" >> ~/goProjects/$1/.github/workflows/go.yml
echo "      - develop" >> ~/goProjects/$1/.github/workflows/go.yml
echo "  pull_request:" >> ~/goProjects/$1/.github/workflows/go.yml
echo "    branches:" >> ~/goProjects/$1/.github/workflows/go.yml
echo "      - master" >> ~/goProjects/$1/.github/workflows/go.yml
echo "      - develop" >> ~/goProjects/$1/.github/workflows/go.yml
echo "jobs:" >> ~/goProjects/$1/.github/workflows/go.yml
echo "  build:" >> ~/goProjects/$1/.github/workflows/go.yml
echo "    runs-on: ubuntu-latest" >> ~/goProjects/$1/.github/workflows/go.yml
echo "    strategy:" >> ~/goProjects/$1/.github/workflows/go.yml
echo "      matrix:" >> ~/goProjects/$1/.github/workflows/go.yml
echo "        go-version: [1.11.x, 1.12.x, tip]" >> ~/goProjects/$1/.github/workflows/go.yml
echo "    steps:" >> ~/goProjects/$1/.github/workflows/go.yml
echo "      - uses: actions/checkout@v1" >> ~/goProjects/$1/.github/workflows/go.yml
echo "      - name: Set up Go \${{ matrix.go-version }}" >> ~/goProjects/$1/.github/workflows/go.yml
echo "        uses: actions/setup-go@v1" >> ~/goProjects/$1/.github/workflows/go.yml
echo "        with:" >> ~/goProjects/$1/.github/workflows/go.yml
echo "          go-version: \${{ matrix.go-version }}" >> ~/goProjects/$1/.github/workflows/go.yml
echo "      - name: Run tests" >> ~/goProjects/$1/.github/workflows/go.yml
echo "        run: go test -v ./..." >> ~/goProjects/$1/.github/workflows/go.yml

# Create the .gitattributes file
touch ~/goProjects/$1/.gitattributes

# Add the .gitattributes file contents
echo "*.go linguist-language=Go" >> ~/goProjects/$1/.gitattributes


git init
git branch -m main
git add .
git commit -m "Initial commit"
git remote add origin
git push -u origin main

# Open the project in Neovim
nvim ~/goProjects/$1/main.go

