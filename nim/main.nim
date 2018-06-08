import boot
import vga

proc main() {.exportc.} =
  vga.init()
  writeLine("this is a test")
  writeLine("of a kernel in nim")
