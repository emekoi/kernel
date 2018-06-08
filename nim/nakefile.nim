import nake
import os

const
  CC = "i686-elf-gcc"
  AC = "i686-elf-as"
  NB = "$(cat $HOME/.choosenim/current)/c_code"

task "clean", "removes build files.":
  removeDir("nimcache")
  removeDir("bin")

task "build", "build the kernel.":
  runTask("clean")
  createDir "bin"
  direShell "nim c -d:release main.nim"
  direShell CC, "-T linker.ld -o bin/main.bin -ffreestanding -O2 -nostdlib nimcache/*.o"

task "run", "run the kernel using QEMU.":
  if not existsFile("bin/main.bin"): runTask("build")
  direShell "qemu-system-i386 -kernel bin/main.bin"
