//  Copyright (c) 2018 emekoi
//
//  This library is free software; you can redistribute it and/or modify it
//  under the terms of the MIT license. See LICENSE for details.
//

#include <stdint.h>
#include <stddef.h>

#define VGA_ADDRESS 0xB8000

typedef int32_t i32;
typedef uint8_t u8;
typedef uint16_t u16;

typedef enum {
  VGA_COLOR_BLACK = 0,
  VGA_COLOR_BLUE = 1,
  VGA_COLOR_GREEN = 2,
  VGA_COLOR_CYAN = 3,
  VGA_COLOR_RED = 4,
  VGA_COLOR_MAGENTA = 5,
  VGA_COLOR_BROWN = 6,
  VGA_COLOR_LIGHT_GREY = 7,
  VGA_COLOR_DARK_GREY = 8,
  VGA_COLOR_LIGHT_BLUE = 9,
  VGA_COLOR_LIGHT_GREEN = 10,
  VGA_COLOR_LIGHT_CYAN = 11,
  VGA_COLOR_LIGHT_RED = 12,
  VGA_COLOR_LIGHT_MAGENTA = 13,
  VGA_COLOR_YELLOW = 14,
  VGA_COLOR_WHITE = 15
} Color;

const i32 VGA_WIDTH = 80;
const i32 VGA_HEIGHT = 25;

static volatile u16* terminalBuffer;
static i32 terminalRow;
static i32 terminalColumn;
static Color terminalForeGround;
static Color terminalBackGround;
static u8 terminalColor;

void vga_init();
void vga_panic(char*);
void vga_clear();
void vga_setForeGround(Color);
void vga_setBackGround(Color);
void vga_setColor(Color, Color);
void vga_setRow(i32);
void vga_setColumn(i32);
Color vga_getForeGround();
Color vga_getBackGround();
void vga_getColor(Color*);
i32 vga_getRow();
i32 vga_getColumn();
void vga_putChar(char);
void vga_write(char*);
void vga_writeLine(char*);

static void memcpy(char *src, char *dst, i32 len) {
  while (len > 0) {
    *dst = *src;
    len--;
  }
}

static u8 entryColor(Color fg, Color bg) {
  return (u8)fg | ((u8)bg << 4);
}

static u16 entry(u8 uc, u8 color) {
  return (u16)uc | ((u16)color << 8);
}

void vga_init() {
  terminalRow = 0;
  terminalColumn = 0;
  terminalForeGround = VGA_COLOR_LIGHT_GREY;
  terminalBackGround = VGA_COLOR_DARK_GREY;
  terminalColor = entryColor(terminalForeGround, terminalBackGround);
  terminalBuffer = (u16*)(VGA_ADDRESS);
  vga_clear();
}

void vga_panic(char *msg) {
  i32 row = vga_getRow();
  i32 col = vga_getColumn();
  Color color[2];
  vga_getColor(color);

  vga_setRow(VGA_HEIGHT - 1);
  vga_setColumn(0);
  vga_setColor(VGA_COLOR_RED, VGA_COLOR_WHITE);

  vga_write(msg);

  vga_setRow(row);
  vga_setColumn(col);
  vga_setColor(color[0], color[1]);
}

void vga_clear() {
  i32 idx = 0;
  while (idx < (VGA_HEIGHT * VGA_WIDTH)) {
    terminalBuffer[idx] = entry(' ', terminalColor);
    idx++;
  }
}

void vga_setForeGround(Color color) {
  terminalForeGround = color;
  terminalColor = entryColor(terminalForeGround, terminalBackGround);
}

void vga_setBackGround(Color color) {
  terminalBackGround = color;
  terminalColor = entryColor(terminalForeGround, terminalBackGround);
}

void vga_setColor(Color fg, Color bg) {
  terminalForeGround = fg;
  terminalBackGround = bg;
  terminalColor = entryColor(terminalForeGround, terminalBackGround);
}

void vga_setRow(i32 row) {
  if (row > VGA_HEIGHT) {
    vga_panic("ERROR: invalid row index");
    return;
  }
  terminalRow = row;
}

void vga_setColumn(i32 col) {
  if (col > VGA_WIDTH) {
    vga_panic("ERROR: invalid column index");
    return;
  }
  terminalColumn = col;
}

Color vga_getForeGround() {
  return terminalForeGround;
}

Color vga_getBackGround() {
  return terminalBackGround;
}

void vga_getColor(Color *result) {
    result[0] = terminalForeGround;
    result[1] = terminalBackGround;
}

i32 vga_getRow() {
  return terminalRow;
}

i32 vga_getColumn() {
  return terminalColumn;
}

void putEntryAt(char c, i32 x, i32 y) {
  i32 idx = y * VGA_WIDTH + x;
  terminalBuffer[idx] = entry(c, terminalColor);
}

void vga_putChar(char c) {
  putEntryAt(c, terminalColumn, terminalRow);
  terminalColumn++;
  if (c == '\n') {
    terminalRow++;
    terminalColumn = 0;;
  }
  if (terminalRow == VGA_HEIGHT) {
    terminalRow = 0;
    // char *src = (char *)(terminalBuffer + VGA_WIDTH);
    // char *dst = (char *)(terminalBuffer);
    // i32 len = (VGA_WIDTH) * VGA_HEIGHT;
    // memcpy(src, dst, len * sizeof(char));
  }
  if (terminalColumn == VGA_WIDTH) {
    terminalColumn = 0;
  }
}

void vga_write(char *data) {
  char *c = data;
  while (*c != '\0') {
    vga_putChar(*c);
    c++;
  }
}

void vga_writeLine(char *data) {
  vga_write(data);
  terminalRow++;
  terminalColumn = 0;
}
