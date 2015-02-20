// Author: Jessica + Chan
// Scrolling through C code


#include <stdio.h>
#include <string.h>
#include <math.h>

#define INPUT_LENGTH 80

int main()
{
    volatile int * reg = (int *) 0xFF200038;

    int len, i, integer, not_int_flag = 0, exit_flag = 0;
    char input[INPUT_LENGTH];

    while (!exit_flag)
    {
        printf("Please enter a scrolling speed [1-100]: ");
        fgets(input, INPUT_LENGTH, stdin);
        len = strlen(input);

        for (i = 0; i <= (len - 2); i++)
        {
            // Check the value of the char
            if (input[i] == 32)
            {
                printf("No spaces allowed.\n");
                not_int_flag = 1;
            } // if input[i] == " "
            else if (input[i] < 48 || input[i] > 57)
            {
                if (input[i] == 68 || input[i] == 100) // d
                {
                    i++;
                    if (input[i] == 79 || input[i] == 111) // o
                    {
                        i++;
                        if (input[i] == 78 || input[i] == 110) // n
                        {
                            i++;
                            if (input[i] == 69 || input[i] == 101) // e
                            
                                exit_flag = 1;
                        } // n
                    } // o
                } // d
                if (exit_flag == 0)
                {
                    not_int_flag = 1;
                    printf("Not an integer.\n");
                }
                else
                    printf("Exiting Program...\n");
            } // else if input[i] != int
            if (not_int_flag == 1 || exit_flag == 1)
                break;
        } // for input[i]
        if (not_int_flag == 0)
        {
            integer = atoi(input);
            if ((integer != 0) && (integer < 101))
            {
                printf("%d\n", integer);
                *(reg) = integer; // assign integer to register
            }
            else if (integer == 0)
                printf("Please enter a digit greater than 0. Or 'done' to exit.\n");
            else if (integer > 100)
                printf("Please enter a digit less than 100. Or 'done' to exit.\n");
        }
    }
    return 0;
}
