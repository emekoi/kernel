//  Copyright (c) 2018 emekoi
//
//  This library is free software; you can redistribute it and/or modify it
//  under the terms of the MIT license. See LICENSE for details.
//

use core::panic::PanicInfo;

#[panic_implementation]
#[no_mangle]
pub fn panic(_info: &PanicInfo) -> ! {
    loop {}
}
