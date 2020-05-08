/* 
 * File:   main.c
 * Author: mgala
 *
 * Created on October 17, 2017, 8:54 PM
 */

#include <stdio.h>
#include <stdlib.h>

int function_1(int N);
int function_2(int N);
int* function_3(int* arrayInAddress, int* arrayOutAddress);

int arrayIn[5], arrayOut[5];

int main() {

    printf("Welcome to LAB03!");
    
    int action = 0;
    while(action != 4){
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
        scanf("%d", &action);  
            
        int N, result;
        if (action == 1){ //Function 1
            printf("Please Enter an Integer (N): ");
            scanf("%d", &N);
            result = function_1(N);
            printf("\nTotal Numbers printed: %d", result);
        
        }
        else if (action == 2){ //Function 2
            printf("Please Enter an Integer (N): ");
            scanf("%d", &N);
            result = function_2(N);
            if (result == 0) printf("%d is Even (Zigos)!", N);
            else printf("%d is Odd (Monos)!", N);
        }
        else if (action == 3){ //Function 3
            int* arrayOutAddress;
            for (int i=1;i<=5;i++){
                printf("Please Enter Integer %d: ", i);
                scanf("%d", &arrayIn[i-1]);
            }
            arrayOutAddress = function_3(arrayIn, arrayOut);
            printf("\nOld Array of Integers: ");
            for (int j=1;j<=5;j++){
                printf("%d ", arrayIn[j-1]);
            }
            printf("\nNew Array of Integers: ");
            for (int k=1;k<=5;k++){
                printf("%d ", arrayOut[k-1]);
            }
        }
        else if (action == 4) { //Exit
            printf("Thank you for using our program! Exiting. . ."); 
            return 0;
        }
        else printf("Action not found!"); //Other
    }
    return (0);
}

int function_1(int N){
    int counter=0;
    
    for (int i = 1; i<=N; i++){
        for (int j = 1; j <= i; j++){
            printf("%d ", j);
            counter++;
        }
        printf("\n");
    }
    
    return counter;
}

int function_2(int N){ //Returns 1 for even (zigos), 0 for odd (monos)
    
    if (N>=0){
        while (N>1){
            N = N-2;
        }
        return N;
    }
    else{
        while (N<-1){
            N = N+2;
        }
        return (-N);
    }
}

int* function_3(int *arrayInAddress, int *arrayOutAddress){
    for (int i=0;i<5;i++){//Number Of Elements
        for (int j=0;j<6;j++){//Times 6
            arrayOutAddress[i] += arrayInAddress[i];
        }
    }
    return arrayOut;
}
