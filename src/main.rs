#![no_std]
#![no_main]
#![feature(custom_test_frameworks)]
#![test_runner(brewos::test_runner)]
#![reexport_test_harness_main = "test_main"]

use brewos::println;
use core::panic::PanicInfo;

#[no_mangle]
pub extern "C" fn _start() -> ! {
    println!("Hello World!");

    brewos::init();

    #[cfg(test)]
    test_main();

    println!("It did not crash!");
    brewos::hlt_loop();
}

#[cfg(not(test))]
#[panic_handler]
fn panic(info: &PanicInfo) -> ! {
    println!("{}", info);
    brewos::hlt_loop();
}

#[cfg(test)]
#[panic_handler]
fn panic(info: &PanicInfo) -> ! {
    brewos::test_panic_handler(info)
}
