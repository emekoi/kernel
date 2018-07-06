#  Copyright (c) 2018 emekoi
#
#  This library is free software; you can redistribute it and/or modify it
#  under the terms of the MIT license. See LICENSE for details.
#

import nake
import os

const
  CC = "i686-elf-gcc"

task "clean", "removes build files.":
  removeDir("src/nimcache")
  removeDir("nimcache")
  removeDir("bin")

task "setup", "creates build directories.":
  runTask "clean"
  createDir "bin"

task "build", "build the kernel.":
  runTask "setup"
  direShell "nim c -d:release src/main.nim"
  direShell CC, " -T linker.ld -o bin/main.bin -m32 -std=gnu99 -ffreestanding -fno-stack-protector -nostdinc -nostdlib src/nimcache/*.o"

task "buildv", "build the kernel in verbose mode.":
  runTask "setup"
  direShell "nim c -d:release --verbosity:3 src/main.nim"
  direShell CC, " -T linker.ld -o bin/main.bin -m32 -std=gnu99 -ffreestanding -fno-stack-protector -nostdinc -nostdlib src/nimcache/*.o"

task "run", "run the kernel using QEMU.":
  if not existsFile("bin/main.bin"): runTask("build")
  direShell "qemu-system-i386 -kernel bin/main.bin"
