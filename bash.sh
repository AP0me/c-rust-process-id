# 1. Create the directory if it doesn't exist
mkdir -p temp

# 2. Compile Rust to LLVM-IR in /temp
rustc +1.81 --emit=llvm-ir --crate-type=staticlib -C lto=fat -C embed-bitcode=yes main.rs -o temp/rd_main.ll

# 3. Compile C to LLVM-IR in /temp
clang -S -emit-llvm main.c -o temp/c_main.ll

# 4. Link the IR files into a merged IR file in /temp
llvm-link temp/c_main.ll temp/rd_main.ll -S -o temp/merged.ll

# 5. Compile the final merged IR into the executable
clang temp/merged.ll -o my_app