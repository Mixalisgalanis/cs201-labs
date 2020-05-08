#include <stdio.h>
#include <stdlib.h>

//Register variables
int V0;
int A0;
int T0,T1,T2,T3,T4,T5,T6,T7,T8,T9;
int S0,S1;
int RA;

//Map
char map[232] =
"I.IIIIIIIIIIIIIIIIIII"
"I....I....I.......I.I"
"III.IIIII.I.I.III.I.I"
"I.I.....I..I..I.....I"
"I.I.III.II...II.I.III"
"I...I...III.I...I...I"
"IIIII.IIIII.III.III.I"
"I.............I.I...I"
"IIIIIIIIIIIIIII.I.III"
"@...............I..II"
"IIIIIIIIIIIIIIIIIIIII";


char temp[100];


void main()
{
    A0 = 1;
    makeMove();
	printLabyrinth();
    return;
}

void printLabyrinth (void){ //Uses T4-T9

    T4 = 0; //i = 0
    T5 = 0; //j = 0
    T6 = 0; //k = 0

	int stack[1];
	stack[0] = RA;
    usleep(9000);
    //for(i=0;i<80000000;i++){}; //Smooth: 1-80000000, Choppy: >80000000

	RA = stack[0];
    printf("\nLabyrinth:\n");

    label_loop_1: //Outside for loop
        if (T4 >= 11) goto after_loop_1;

        label_loop_2:
            if (T5 >= 21) goto after_loop_2;


            T7 = map[T6];
            temp[T5] = T7;
            T6 = T6 + 1; //k++

            T5 = T5 + 1; //j++
            goto label_loop_2;
        after_loop_2:

        T8 = T5 + 1; //Creating j+1
        temp[T8] = '\0';
        printf("%s\n", temp);

        T5 = 0; //Resetting j to 0

        T4 = T4 + 1; //i++
        goto label_loop_1;
    after_loop_1:
    RA = stack[0];
    return;
}

void makeMove(void){ //Input A0 (index)

    int stack[2];
    stack[0] = S0;
    S0 = A0;

    //The two following if's are for initial check:
    if (A0 >= 0) goto after_cond_1;

    goto RETURN_0;

    after_cond_1:

    if (A0 < 231) goto after_cond_2;

    goto RETURN_0;
    after_cond_2:

    //Outside if
    if (map[S0] != '.') goto else_label;

    map[S0] = '*';

    stack[1] = RA;
    printLabyrinth();
    RA = stack[1];

    //First if
    A0 = S0 + 1;
    stack[1] = RA;
    makeMove();
    RA = stack[1];

    if (V0 != 1) goto after_cond_3;
        goto REPLACE;

    after_cond_3:

    //Second if
    A0 = S0 + 21;

    stack[1] = RA;
    makeMove();
    RA = stack[1];

    if (V0 != 1) goto after_cond_4;
        goto REPLACE;

    after_cond_4:

    //Third if
    A0 = S0 - 1;
    stack[1] = RA;
    makeMove();
    RA = stack[1];

    if (V0 != 1) goto after_cond_5;
        goto REPLACE;

    after_cond_5:

    //Fourth if
    A0 = S0 - 21;
    stack[1] = RA;
    makeMove();
    RA = stack[1];

    if (V0 != 1) goto after_cond_6;
        goto REPLACE;

    after_cond_6:

    goto after_cond;
    else_label:

        if (map[S0] != '@') goto after_cond;

        map[S0] = '%';

        stack[1] = RA;
        printLabyrinth();
        RA = stack[1];
        goto RETURN_1;
    after_cond:
        goto RETURN_0;


REPLACE:

    map[S0] = '#';
    goto RETURN_1;


RETURN_0:

    V0 = 0;
	RA = stack[1];
    S0 = stack[0];
    return;

RETURN_1:

    V0 = 1;
	RA = stack[1];
    S0 = stack[0];
    return;
}




