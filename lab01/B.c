#include <stdio.h>
#include <stdlib.h>

long double var1 = 124858568854866353; 
char var2 = 'b';
int var3 = 67;

int main(void) {
   
    printf("Address of var1: %5d\n", &var1);
    printf("Address of var2: %5d\n", &var2);
    printf("Address of var3: %5d\n", &var3);
    
    return 0;
} 