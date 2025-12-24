// main.c
#include <stdio.h>
#include "rust_std.h"

int main() {
    printf("%d", std_process_id());
    return 0;
}