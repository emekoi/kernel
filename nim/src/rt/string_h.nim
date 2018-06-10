#  Copyright (c) 2018 emekoi
#
#  This library is free software; you can redistribute it and/or modify it
#  under the terms of the MIT license. See LICENSE for details.
#

# proc memset*(str: pointer, c: cint, n: csize): pointer {.exportc, cdecl.}

proc memset*(str: pointer, c: cint, n: csize): pointer {.exportc, cdecl.} =
  let str = cast[ptr UncheckedArray[cuchar]](str)
  for idx in 0..n:
    str[idx] = cast[cuchar](c)
