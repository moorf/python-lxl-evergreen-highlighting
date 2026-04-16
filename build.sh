#!/usr/bin/env bash
set -e

git clone --depth=1 https://github.com/tree-sitter/tree-sitter-python

cd tree-sitter-python

cc -shared -fPIC src/parser.c src/scanner.c -I src -o ../parser.dll

cd ..

mkdir -p queries
cp tree-sitter-python/queries/highlights.scm queries/highlights.scm

rm -rf tree-sitter-python

echo "Build complete."
