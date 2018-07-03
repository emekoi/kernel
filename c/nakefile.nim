#  Copyright (c) 2018 emekoi
#
#  This library is free software; you can redistribute it and/or modify it
#  under the terms of the MIT license. See LICENSE for details.
#

import nake
import os, strutils

const
  CC = "i686-elf-gcc"
  AS = "i686-elf-as"

task "clean", "removes build files.":
  removeDir "nimcache"
  removeDir "bin"

task "setup", "creates build directories.":
  runTask "clean"
  createDir "bin"

task "build", "build the kernel.":
  runTask "setup"
  direShell AS, r" src/boot.s -o bin/boot.o"
  direShell CC, r" -T linker.ld -o bin/main.bin -ffreestanding -O2 -nostdlib -Wall -Wextra bin/*.o src/main.c"

task "run", "run the kernel using QEMU.":
  if not existsFile("bin/main.bin"): runTask("build")
  direShell "qemu-system-i386 -kernel bin/main.bin"
