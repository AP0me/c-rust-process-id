#!/bin/bash
mkdir -p temp

# 1. Rust to LLVM-IR
rustc +1.81 --emit=llvm-ir --crate-type=staticlib \
    -C lto=fat -C embed-bitcode=yes \
    main.rs -o temp/rd_main.ll --target=x86_64-pc-windows-gnu

cbindgen --lang c main.rs -o rust_std.h

# 2. C to LLVM-IR
clang -S -emit-llvm main.c -o temp/c_main.ll --target=x86_64-pc-windows-gnu

# 3. Link IR
llvm-link temp/c_main.ll temp/rd_main.ll -S -o temp/merged.ll

# 4. Final Compile & Link
# Note: We include common Windows libs required by the Rust runtime
clang temp/merged.ll -o my_app.exe --target=x86_64-pc-windows-gnu -lntdll -lsynchronization -luser32