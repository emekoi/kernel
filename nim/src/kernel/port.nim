#  Copyright (c) 2018 emekoi
#
#  This library is free software; you can redistribute it and/or modify it
#  under the terms of the MIT license. See LICENSE for details.
#

{.push stackTrace: off, profiler: off, #[asmNoStackFrame]#.}

proc read*(port: uint16): uint8 {.exportc.} =
  asm """inb %1, %0
    :"=a"(`result`)
    :"Nd"(`port`)
  """

proc write*(port: uint16, value: uint8) {.exportc.} =
  asm """outb %0, %1
    : :"a"(`value`), "Nd"(`port`)
  """

{.pop.}
