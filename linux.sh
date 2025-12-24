#!/bin/bash
mkdir -p temp

# 1. Rust to LLVM-IR
rustc +1.81 --emit=llvm-ir --crate-type=staticlib \
    -C lto=fat -C embed-bitcode=yes \
    main.rs -o temp/rd_main.ll --target=x86_64-unknown-linux-gnu

# 2. C to LLVM-IR
# Ensure you have the linux headers available if cross-compiling
clang -S -emit-llvm main.c -o temp/c_main.ll --target=x86_64-unknown-linux-gnu

# 3. Link IR
llvm-link temp/c_main.ll temp/rd_main.ll -S -o temp/merged.ll

# 4. Final Compile & Link
clang temp/merged.ll -o my_app --target=x86_64-unknown-linux-gnu