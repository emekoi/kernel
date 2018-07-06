#  Copyright (c) 2018 emekoi
#
#  This library is free software; you can redistribute it and/or modify it
#  under the terms of the MIT license. See LICENSE for details.
#

{.push exportc, stackTrace: off, profiler: off.}

import port

const
  IDT_SIZE* = 256

type Entry* = object
  lo: uint16
  selector: uint16
  zero: uint8
  type_attr: uint8
  hi: uint16

{.pop.}
