#include <stdio.h>
#include <stdlib.h>

int main(void) {
   
    struct A { //Should be 6 bytes
        char X; //1 byte
        int C;  //4 bytes
        char Y; //1 byte
    };
    
    struct B { //Should be 6 bytes
        char X; //1 byte
        char Y; //1 byte
        int C;  //4 bytes
    };
    
    printf("Size of struct A (2 characters and 1 integer): %d bytes.\n", sizeof(struct A));
    printf("Size of struct B (2 characters and 1 integer): %d bytes.\n", sizeof(struct B));
    
    return 0;
} 