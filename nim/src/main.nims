switch("cc", "gcc")
switch("lib", "src/runtime")
switch("cpu", "i386")
switch("boundChecks", "on")
switch("noLinking")
switch("os", "standalone")
switch("gc", "none")
switch("deadCodeElim", "on")
switch("noMain")
switch("i386.standalone.gcc.exe", "i686-elf-gcc")
switch("i386.standalone.gcc.linkerexe", "i686-elf-ld")
switch("passC", "-m32 -std=gnu99 -ffreestanding -O2 -Wall -Wextra")
