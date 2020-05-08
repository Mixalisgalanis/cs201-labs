#include <stdio.h>
#include <stdlib.h>

int global = 5;

int main(void) {
   
    int local = 10;
    
    void *ptr = malloc(5);
    
    printf("Main adddress: %#010x\n", &main);
    printf("Global variable address: %#010x\n", &global);
    printf("Local variable address: %#010x\n", &local);
    printf("Malloc return address: %p\n", ptr);
    
    free(ptr);
    
    return 0;
} 