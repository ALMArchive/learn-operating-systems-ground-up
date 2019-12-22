#!/bin/bash
if [ -d dist ]
then
  rm -rd dist
fi

NAME=boot4

mkdir dist
nasm -f elf32 $NAME.asm -o dist/$NAME.o
g++ -m32 kmain.cpp dist/$NAME.o -o dist/kernel.bin -nostdlib -ffreestanding -std=c++11 -mno-red-zone -fno-exceptions -fno-pie -nostdlib -fno-rtti -Wall -Wextra -Werror -T linker.ld
chmod +x dist/kernel.bin
