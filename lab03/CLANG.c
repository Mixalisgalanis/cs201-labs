
/* 
 * File:   main.c
 * Author: mgala
 *
 * Created on October 18, 2017, 1:37 AM
 */

#include <stdio.h>
#include <stdlib.h>

int R0 = 0, R1,R2,R3,R4,R5,R6,R7,R8,R9,R10,R11,R12,R13,R14,R15,R16,R17,R18,R19;
int arrayIn[5], arrayOut[5];

int function_1(int R4);
int function_2(int R4);
int function_3(int R4, int R5);

int main() {

    printf("Welcome to LAB03!");
    int action;
    action = R0;
    
    While_label:
        if (action == 4) goto after_loop;
        
        printf("\n\nMAIN MENU");
        printf("\n============================================");
        printf("\n1. Function 1");
        printf("\n--------------------------------------------");
        printf("\n2. Function 2");
        printf("\n--------------------------------------------");
        printf("\n3. Function 3");
        printf("\n--------------------------------------------");
        printf("\n4. Exit");
        printf("\n============================================");
        printf("\nPlease Select Action: ");
        scanf("%d", &R1);
        action = R1;
        
        int N, result;
        if (R1!=1) goto else_label_1; //First if
        
        printf("Please Enter an Integer (N): ");
        scanf("%d", &R3);
        N = R3;
        R2 = function_1(R3);
        result = R2;
        printf("\nTotal Numbers printed: %d", R2);
        
        goto after_cond;
        else_label_1:
        if (R1!=2) goto else_label_2; //Second if
        
        printf("Please Enter an Integer (N): ");
        scanf("%d", &R3);
        N = R3;
        R2 = function_2(R3);
        result = R2;
        if (R2 != 0) goto else_label_se;
        printf("%d is Even (Zigos)!", R3);
        goto after_cond_se;
        else_label_se:
        printf("%d is Odd (Monos)!", R3);
        after_cond_se:
        
        goto after_cond;
        else_label_2:
        if (R1!=3) goto else_label_3; //Third if
        
        int *arrayOutAddress;
        int i;
        R9 = 1;
        i = R9;
        Label_loop_1: //For Loop 1
        if (R9 > 5) goto after_loop_1;
        printf("Please Enter Integer %d: ", R9);
        scanf("%d", &arrayIn[R9-1]);
        R9 = R9 + 1;
        goto Label_loop_1;
        after_loop_1:
        R10 = (long) arrayIn;
        R11 = (long) arrayOut;
        R12 = (long) function_3(R10, R11);
        arrayOutAddress = (int*) R12;
        printf("\nOld Array of Integers: ");
        
        int j;
        R13 = 1;
        i = R13;
        Label_loop_2: //For Loop 2
        if (R13 > 5) goto after_loop_2;
        printf("%d ", arrayIn[R13-1]);
        R13 = R13 + 1;
        goto Label_loop_2;
        after_loop_2:
        printf("\nNew Array of Integers: ");
        
        int k;
        R14 = 1;
        k = R14;
        Label_loop_3: //For Loop 3
        if (R14 > 5) goto after_loop_3;
        printf("%d ", arrayOut[R14-1]);
        R14 = R14 + 1;
        goto Label_loop_3;
        after_loop_3:
        
        goto after_cond;
        else_label_3:
        if (R1 != 4) goto else_label_4; //Fourth if
        printf("Thank you for using our program! Exiting. . ."); 
        return R0;
        goto after_cond;
        else_label_4:
        printf("Action not found!");
        
        after_cond:
        goto While_label;
        after_loop:
            return 0;
}

int function_1(int R4){
    int counter;
    counter = R0;
    R17 = R0;
    int i;
    R15 = 1;
    i = R15;
    
    Label_loop_1: //Outside For Loop
    if (R15 > R4) goto after_loop_1;
    
    int j;
    R16 = 1;
    j = R16;
    
    Label_loop_2: //Inside For Loop
    if (R16 > R15) goto after_loop_2;
    printf("%d ", R16);
    R17 = R17 + 1;
    R16 = R16 + 1;
    goto Label_loop_2;
    after_loop_2:
    printf("\n");
    
    R15 = R15 + 1;
    goto Label_loop_1;
    after_loop_1:
    return R17;
}

int function_2(int R4){
    
    if (R4 < R0) goto else_label;
    
    While_label_1:
    if (R4 <= 1) goto after_loop_1;
    R4 = R4 - 2;
    goto While_label_1;
    after_loop_1:
    return R4;
    
    else_label:
    
    //while 2
    While_label_2:
    if (R4>=-1) goto after_loop_2;
    R4 = R4 + 2;
    goto While_label_2;
    after_loop_2:
    return (-R4);
}

int function_3(int R4, int R5){
    int i;
    R15 = R0;
    i = R15;
    
    Label_loop_1:
    if (R15 >= 5) goto after_loop_1;
    
    //another for loop
    int j;
    R16 = R0;
    j = R16;
    Label_loop_2:
    if (R16>=6) goto after_loop_2;
    R17 = arrayOut[R15];
    R18 = arrayIn[R15];
    R19 = R17 + R18;
    arrayOut[R15] = R19;
    R16 = R16 + 1;
    goto Label_loop_2;
    after_loop_2:    
    R15 = R15 + 1;
    goto Label_loop_1;
        
    after_loop_1:
    return (long) arrayOut;
}