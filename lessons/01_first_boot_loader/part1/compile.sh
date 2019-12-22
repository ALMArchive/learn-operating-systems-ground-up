#!/bin/bash
if [ -d dist ]
then
  rm -rd dist
fi

NAME=boot1

mkdir dist
nasm $NAME.asm -f bin -o dist/$NAME.bin
chmod +x dist/$NAME.bin
