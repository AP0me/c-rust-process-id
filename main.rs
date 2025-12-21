use std::process;

#[no_mangle]
pub extern "C" fn my_process_id() -> u32 {
    return process::id();
}