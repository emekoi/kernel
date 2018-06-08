{.push stack_trace: off, profiler:off.}
import vga

proc rawoutput(s: string) =
  vga.writeLine s

proc panic(s: string) =
  let
    row = vga.getRow()
    col = vga.getColumn()
    (fg, bg) = vga.getColor()

  vga.setRow(vga.HEIGHT - 1)
  vga.setColumn(0)
  vga.setColor(Color.RED, Color.WHITE)
  vga.clear()

  rawoutput s

  vga.setRow(row)
  vga.setColumn(col)
  vga.setColor(fg, bg)


{.pop.}
