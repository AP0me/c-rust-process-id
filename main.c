// main.c
#include <stdio.h>
int my_process_id(void); // Declare the function exists elsewhere

int main() {
    printf("%d", my_process_id());
    return 0;
}