type
  Color* {.pure, size: 1.} = enum
    BLACK = 0,
    BLUE = 1,
    GREEN = 2,
    CYAN = 3,
    RED = 4,
    MAGENTA = 5,
    BROWN = 6,
    LIGHT_GREY = 7,
    DARK_GREY = 8,
    LIGHT_BLUE = 9,
    LIGHT_GREEN = 10,
    LIGHT_CYAN = 11,
    LIGHT_RED = 12,
    LIGHT_MAGENTA = 13,
    LIGHT_BROWN = 14,
    WHITE = 15

const
  WIDTH* = 80
  HEIGHT* = 25

var
  terminalBuffer {.volatile.}: ptr UncheckedArray[uint16]
  terminalRow: range[0..(HEIGHT - 1)]
  terminalColumn: range[0..(WIDTH - 1)]
  terminalForeGround: Color
  terminalBackGround: Color
  terminalColor: uint8

proc entryColor(fg, bg: Color): uint8 =
  return fg.uint8 or (bg.uint8 shl 4)

proc entry(uc: char, color: uint8): uint16 =
  return uc.uint16 or (color.uint16 shl 8)

proc clear*() =
  var idx = 0
  while idx < HEIGHT * WIDTH:
    terminalBuffer[idx] = entry(' ', terminalColor)
    inc idx

proc init*() =
  terminalRow = 0
  terminalColumn = 0
  terminalForeGround = Color.LIGHT_GREY
  terminalBackGround = Color.DARK_GREY
  terminalColor = entryColor(terminalForeGround, terminalBackGround)
  terminalBuffer = cast[ptr UncheckedArray[uint16]](0xB8000)
  clear()

proc setForeGround*(color: Color) =
  terminalForeGround = color
  terminalColor = entryColor(terminalForeGround, terminalBackGround)

proc setBackGround*(color: Color) =
  terminalBackGround = color
  terminalColor = entryColor(terminalForeGround, terminalBackGround)

proc setColor*(fg, bg: Color) =
  terminalForeGround = fg
  terminalBackGround = bg
  terminalColor = entryColor(terminalForeGround, terminalBackGround)

proc setRow*(row: range[0..(HEIGHT - 1)]) =
  terminalRow = row

proc setColumn*(col: range[0..(WIDTH - 1)]) =
  terminalColumn = col

proc getForeGround*(): Color =
  terminalForeGround

proc getBackGround*(): Color =
  terminalBackGround

proc getColor*(): (Color, Color) =
  (
    terminalForeGround,
    terminalBackGround
  )

proc getRow*(): range[0..(HEIGHT - 1)] =
  terminalRow

proc getColumn*(): range[0..(WIDTH - 1)] =
  terminalColumn

proc putEntryAt(c: char, x, y: int) =
  let idx = y * WIDTH + x
  terminalBuffer[idx] = entry(c, terminalColor)

proc putChar*(c: char) =
  putEntryAt(c, terminalColumn, terminalRow)
  terminalColumn.inc
  if terminalColumn == WIDTH:
    terminalColumn = 0
    if terminalRow == HEIGHT:
      terminalRow = 0

proc write*(data: string) =
  var i = 0
  while i < data.len:
    putChar(data[i])
    inc i

proc writeLine*(data: string) =
  write(data)
  terminalRow.inc
  terminalColumn = 0
