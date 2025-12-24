#[no_mangle]
pub extern "C" fn std_process_id() -> u32 {
    return std::process::id();
}