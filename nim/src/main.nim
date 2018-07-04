#  Copyright (c) 2018 emekoi
#
#  This library is free software; you can redistribute it and/or modify it
#  under the terms of the MIT license. See LICENSE for details.
#

import kernel/[
  boot,
  port,
  vga
]

proc main() {.exportc.} =
  # vga.init()
  echo "this is a test\n"
  echo "of a kernel in nim"
