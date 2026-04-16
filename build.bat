@echo off
setlocal
rmdir /s /q tree-sitter-python
REM Clone the repository
git clone --depth=1 https://github.com/tree-sitter/tree-sitter-python
if errorlevel 1 exit /b 1

cd tree-sitter-python

REM Build parser.dll into parent directory
gcc -shared -o ../parser.dll src/parser.c src/scanner.c -I src -O2 -std=c11 -Wl,--out-implib,libparser.a

if errorlevel 1 (
    cd ..
    rmdir /s /q tree-sitter-python
    exit /b 1
)

cd ..

REM Create queries directory if it doesn't exist
if not exist queries mkdir queries

REM Copy highlights.scm
copy tree-sitter-python\queries\highlights.scm queries\highlights.scm

REM Delete cloned directory
rmdir /s /q tree-sitter-python

echo Build complete.
endlocal