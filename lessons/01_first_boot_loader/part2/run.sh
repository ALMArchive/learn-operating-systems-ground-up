#!/bin/bash
if [ ! `command -v qemu-system-x86_64` ]
then
  printf "Install qemu\n"
  exit 1
fi

NAME=boot2

if [ -f dist/$NAME.bin ]
then
  rm dist/$NAME.bin
fi

./compile.sh
qemu-system-x86_64 -fda dist/$NAME.bin
