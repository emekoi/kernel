//  Copyright (c) 2018 emekoi
//
//  This library is free software; you can redistribute it and/or modify it
//  under the terms of the MIT license. See LICENSE for details.
//

/*

const i32 VGA_WIDTH = 80;
const i32 VGA_HEIGHT = 25;

static volatile u16* terminalBuffer;
static i32 terminalRow;
static i32 terminalColumn;
static Color terminalForeGround;
static Color terminalBackGround;
static u8 terminalColor;
*/

pub enum Color {
    Black = 0,
    Blue = 1,
    Green = 2,
    Cyan = 3,
    Red = 4,
    Magenta = 5,
    Brown = 6,
    LightGrey = 7,
    DarkGrey = 8,
    LightBlue = 9,
    LightGreen = 10,
    LightCyan = 11,
    LightRed = 12,
    LightMagenta = 13,
    Yellow = 14,
    White = 15,
}

pub struct VGA {
    pub width: i32,
    pub height: i32,
    row: i32,
    col: i32,
    fg: Color,
    bg: Color,
    color: u8,
}
