use std::process;

#[no_mangle]
pub extern "C" fn my_process_id() {
    println!("My pid is {}", process::id());
}