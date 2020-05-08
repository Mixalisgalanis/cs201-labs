#include <stdio.h>
#include <stdlib.h>
#define TABLE_SIZE 10

int var1 = 30; 
int var2 = -5;

int main(void) {
   
    int A[10], i; /* A = array of 10 ints, i = scalar int variable */ 
    int * p; /* p is a scalar variable that points to an int */
    
    for(i = 0; i < TABLE_SIZE; i++) { 
        A[i] = 10*i; 
        printf("Element A[%d] = %d is stored in address : %#010x\n", i, A[i], &A[i]);
    }
    
    p = &var1; 
    printf("Var addresses (hex): %#010x, %#010x\n&p=%#010x, p=%#010x, *p=%d\n", &var1, &var2, &p, p, *p); 
   
    printf("Var values 1: var1=%5d (%#010x), var2=%5d (%#010x)\n", var1, var1, var2, var2); 
    
    *p = 0xfffff; 
    printf("Var values 2: var1=%5d (%#010x), var2=%5d (%#010x)\n", var1, var1, var2, var2); 
    
    *(p+1) = 1000; 
    printf("Var values 3: var1=%5d (%#010x), var2=%5d (%#010x)\n", var1, var1, var2, var2); 
    
    //Extension Number 1
    printf("A : (%#010x) %5d\n", A,A);
    printf("A+2 : (%#010x) %5d\n", A+2,A+2);
    printf("(int)A + 2 : (%#010x) %5d\n", (int)A + 2,(int)A + 2);
    printf("A: (%#010x) %5d\n", &A[2],&A[2]);
    
    int elementSize = sizeof(int);
    printf("The size of one integer is %d bytes.\n", elementSize);
    
    int tableSize = (elementSize * TABLE_SIZE);
    printf("The size of the table is %d bytes.\n", tableSize);
    
    return 0;
} 

