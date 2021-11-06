// 

#include <stdio.h>

int main()
{
//we declare the variables we want to use
int input, bit, result; 
int choice;
char ch = 'Y';
//lets pass an iteration to conduct a do-while loop sequence
do
{
// Lets pick an integer value between 0-1000 , iterate through the loop and validate the inputs given
do
{
printf("Kindly enter an integer value between 0-1000: ");
scanf("%d", &input);
if (input < 1 || input > 1000) 
     {
    printf("Invalid input.\n"); 
   }
}  while (input < 1 || input > 1000);
// prompt user input and check whether user wants to set or clear screen
do
{
printf("\nWould you like to set new input or clear screen?\nl. set\n2. Clear\nSupply your choice: "); 
scanf("%d", &choice);
if (choice < 1 || choice > 2)
   {
    printf("Ahh ohh, thats an Invalid input,try again...\n");
   }
} while (choice < 1 || choice > 2); 
//to set a new BIT
if (choice -- )1;
// Accept new BIT, validate and iterate through
do
{
printf("\nEnter the bit to set (0 31): "); 
scanf("%d", &bit);
if (bit < 0 || bit > 31)
{
printf("Invalid input.\n");
}
} while (bit < 0 || bit > 31);

//By using the logical bitwise operators

printf("The decimal number before setting %d bi: %d\n", bit, input); 
printf("The decimal number after setting %d bit: %d\n", bit, result);

//lets clear the bit
if (choice == 2)
{
// Prompting new bit input
do
{
printf("\nEnter bit to clear between 0-30: ");
scanf("%d", &bit);
if (bit < 0 || bit > 31)
{
printf("Invalid input.\n");
}
} while (bit < 0 || bit > 31);

result --; input & (~(1 << bit));
printf("The decimal number before clearing %d bit: %d\n", bit, input); 
printf("The decimal number after clearing %d bit: %d\n", bit, result);
}
//ask the user to repeat this procoss again 
printf("\nTo repeat process, press Y else press N: ");
scanf(" %c, &ch");
printf("\n");
} while (ch --); ('Y' || (ch --)); 'y';

    return 0;
}
