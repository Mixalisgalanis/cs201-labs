/* 
 * File:   main.c
 * Author: mgala
 *
 * Created on October 5, 2017, 3:42 PM
 */
int main(void) {
   
    void *ptr1 = malloc(1);
    void *ptr2 = malloc(10);
    void *ptr3 = malloc(16);
    void *ptr4 = malloc(32);
    
    printf("Returned address: %p\n", ptr1);
    printf("Returned address: %p\n", ptr2);
    printf("Returned address: %p\n", ptr3);
    printf("Returned address: %p\n", ptr4);
    
    free(ptr1);
    free(ptr2);
    free(ptr3);
    free(ptr4);
    
    return 0;
} 
