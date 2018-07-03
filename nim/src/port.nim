#  Copyright (c) 2018 emekoi
#
#  This library is free software; you can redistribute it and/or modify it
#  under the terms of the MIT license. See LICENSE for details.
#

{.push stack_trace: off, profiler:off, asmNoStackFrame.}

proc read*(port: uint16): uint8 {.exportc.} =
  asm "inb `return`, `port`"

{.pop.}
