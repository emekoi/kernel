//  Copyright (c) 2018 emekoi
//
//  This library is free software; you can redistribute it and/or modify it
//  under the terms of the MIT license. See LICENSE for details.
//

#include "vga.c"

void main() {
  vga_init();
  char letter = 'A';
  while (letter <= 'Z') {
      vga_writeLine(&letter);
      letter++;
  }
}
