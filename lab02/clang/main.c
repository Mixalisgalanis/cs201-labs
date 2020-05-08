#include <stdio.h>
#include <stdlib.h>

int R0 = 0;
int R1,R2,R3,R4,R5,R8,R9,R10,R11,R12,R13,R14,R15,R16,R17,R18,R19,R20,R21,R22,R23;

struct list{
    short id;
    int value;
    struct list *next;
};

int insertNodeToList(int R4);
int deleteItem(int R4);
void findAndPrint(int R4);
int numberOfItems(int R4);
void displayNumberOfItems(int R4);
int findItem(int R4, int R5);
void displayMainMenu();

int main()
{

    printf("Welcome to LAB02!");

    struct list *head;

    int action = 0;
    R1 = action;
    R3 = 6;

    R8 = 1;
    R9 = 2;
    R10 = 3;
    R11 = 4;
    R12 = 5;


    While_label:
        if (R1 == R3) goto after_loop;

        displayMainMenu();
        printf("\nPlease Select Action: ");
        scanf("%d", &R1);

        if (R1 != R8) goto else_label_1;
            head = NULL;
            R18 = (int) head;
            printf("List Successfully Created!");
        else_label_1:
            if (R1 != R9) goto else_label_2;
            R2 = insertNodeToList(R18);
            else_label_2:
                if (R1 != R10) goto else_label_3;
                R2  = deleteItem(R18);
                else_label_3:
                    if (R1 != R11) goto else_label_4;
                    findAndPrint((struct list*)R18);
                    else_label_4:
                        if (R1!=R12) goto else_label_5;
                        displayNumberOfItems((struct list*)R18);
                        else_label_5:
                            if (R1!=R3) goto else_label_6;
                            return 0;
                            else_label_6:
                                printf("Action not found!");
        goto While_label;
    after_loop:
        return 0;
}

void displayMainMenu(){
    printf("\n\nMAIN MENU");
    printf("\n============================================");
    printf("\n1.  Create a List");
    printf("\n--------------------------------------------");
    printf("\n2.  Insert Item to List");
    printf("\n--------------------------------------------");
    printf("\n3.  Remove Item from List");
    printf("\n--------------------------------------------");
    printf("\n4.  Search for Item in List");
    printf("\n--------------------------------------------");
    printf("\n5.  Display Number of List Items");
    printf("\n--------------------------------------------");
    printf("\n6. Exit");
    printf("\n============================================");
}

int insertNodeToList(int R4){

    struct list *currentNode;
    R14 = (int) currentNode;
    R14 = R4;
    currentNode = (struct list *) R14;
    R20 = (int) currentNode->value;
    R21 = (int) currentNode->next;

    struct list *newNode;
    R15 = (int)(malloc(sizeof(struct list)));
    newNode = (struct list *)R15;

    short id; int value;
    printf("Enter ID for the New Item: ");
    scanf("%d", &R16);
    printf("Enter Value for the New Item: ");
    scanf("%d", &R17);
    id = R16;
    value = R17;

    newNode->id = R16;
    newNode->value = R17;
    R23 = (int) newNode->next;


    R18 = NULL;
    if (R4 != R18) goto after_if_label_1;
    R4 = R15;
    R19 = NULL;
    return R4;
    after_if_label_1:
        R22 = (int) currentNode->next->value;
        if (R17 >= R20)goto after_if_label_2;
        R19 = R4;
        R4 = R15;
        return R4;
        after_if_label_2:

            While_label_1:
                if (R21 == NULL) goto after_loop_1;
                While_label_2:
                    if (R22 >= R17) goto after_loop_2;
                    R14 = R21;
                    goto While_label_2;
                after_loop_2:
                goto While_label_1;
            after_loop_1:
                if (R21 != NULL) goto after_if_label_3;
                R21 = R15;
                R23 = NULL;
                return R4;
                after_if_label_3:
                    R23 = R21;
                    R21 = R15;
                    return R4;
}

int deleteItem(int R4){

    int value;
    printf("Insert Value of Item to be Removed:");
    scanf("%d", &R14);
    value = R14;

    struct list *currentNode;
    R15 = (int) currentNode;
    R15 = R4;
    currentNode = (struct list *) R15;

    struct list *previousNode;
    R16 = (int) previousNode;
    R16 = R4;
    previousNode = (struct list *) R16;

    R17 = (int) currentNode->value;
    R18 = (int) currentNode->next;
    R19 = (int) previousNode->next;

    if (R4 != NULL) goto after_if_label1;
    return NULL;
    after_if_label1:
        if (R17 != R14) goto after_if_label2;
        R16 = R18;
        free((struct list*) R15);
        return R16;
        after_if_label2:
            R20 = (int) previousNode->next->value;
            While_label_1:
                if (R19 == NULL) goto after_loop_1;
                While_label_2:
                    if (R20 == R14) goto after_loop_2;
                    R16 = R19;
                    goto While_label_2;
                after_loop_2:
                goto While_label_1;
            after_loop_1:
                if (R19 != NULL) goto after_if_label3;
                return R4;
                after_if_label3:
                    R15 = R19;
                    R19 = R18;
                    free((struct list*)R15);
                    return R4;
}

int findItem(int R4, int R5){

    struct list *currentNode;
    R15 = (int) currentNode;
    R15 = R4;
    currentNode = (struct list *) R15;

    R16 = (int) currentNode->value;
    R17 = (int) currentNode->next;


    if (R4 != NULL) goto after_if_label1;
    return NULL;
    after_if_label1:
        if (R16!=R5) goto after_if_label2;
        return R15;
        after_if_label2:
            R18 = (int) currentNode->next->value;
            While_label_1:
                if (R17 == NULL) goto after_loop_1;
                While_label_2:
                    if (R18 == R5) goto after_loop_2;
                    R15 = R17;
                    goto While_label_2;
                after_loop_2:
                goto While_label_1;
            after_loop_1:
                if (R17 == NULL) goto after_if_label3;
                return NULL;
                after_if_label3:
                    return R17;
}

void findAndPrint(int R4){

    int value;
    printf("Insert Value of Item to be Removed:");
    scanf("%d", &R19);
    value = R19;

    struct list *node;
    R20 = (int) node;
    R20 = findItem(R4,R19);
    node = (struct list*)R20;

    if (R20 != NULL) goto else_label;
    printf("The item could not be found!");
    else_label:
        printf("ID of Item: %hd", node->id);
}

int numberOfItems(int R4){
    int i;
    i = R0;

    struct list *currentNode;
    R14 = (int) currentNode;
    R14 = R4;
    currentNode = (struct list *) R14;

    R15 = (int) currentNode->next;

    While_label:
        if (R4 == NULL) goto after_loop;
        i = R0 + R8;
        R4 = R15;
        goto While_label;
    after_loop:
        R16 = i;
        return R16;
}

void displayNumberOfItems(int R4){
    printf("Number of Items: %d", numberOfItems(R4));
}
