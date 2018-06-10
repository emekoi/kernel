#  Copyright (c) 2018 emekoi
#
#  This library is free software; you can redistribute it and/or modify it
#  under the terms of the MIT license. See LICENSE for details.
#

import boot
import vga

type ok = object
  u: int

proc main() {.exportc.} =
  vga.init()
  writeLine("this is a test")
  writeLine("of a kernel in nim")
  let g = ok(u: 3)
