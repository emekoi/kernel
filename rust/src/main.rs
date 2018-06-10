//  Copyright (c) 2018 emekoi
//
//  This library is free software; you can redistribute it and/or modify it
//  under the terms of the MIT license. See LICENSE for details.
//

#![no_std]
#![no_main]
#![feature(panic_implementation)]

mod std;
mod vga;

#[cfg(target_os = "linux")]
#[no_mangle]
pub extern "C" fn _start() -> ! {
    loop {}
}

#[cfg(target_os = "windows")]
#[no_mangle]
pub extern "C" fn mainCRTStartup() -> ! {
    main();
}

#[cfg(target_os = "windows")]
#[no_mangle]
pub extern "C" fn main() -> ! {
    loop {}
}

#[cfg(target_os = "macos")]
#[no_mangle]
pub extern "C" fn main() -> ! {
    loop {}
}
