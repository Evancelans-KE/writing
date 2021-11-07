  
       int input, bit, result;
       int choice;
       char ch = 'Y';
   
       do
       {
              
              do
              {
                     printf("Please enter an integer between 1 and 1000: ");
                     scanf("%d", &input);
                     if (input < 1 || input > 1000)
                     {
                           printf("Invalid input.\n");
                     }
              } while (input < 1 || input > 1000);
          
              */
              do
              {
                     printf("\nDo you want to set or clear?\n1. Set\n2. Clear\nEnter your choice: ");
                     scanf("%d", &choice);
                     if (choice < 1 || choice > 2)
                     {
                           printf("Invalid input.\n");
                     }
              } while (choice < 1 || choice > 2);
              
              if (choice == 1)
              {
                     
                     do
                     {
                           printf("\nEnter the bit to set (0-31): ");
                           scanf("%d", &bit);
                           if (bit < 0 || bit > 31)
                           {
                                  printf("Invalid input.\n");
                           }
                     } while (bit < 0 || bit > 31);
                     
                     result = (1 << bit) | input;
                     printf("The decimal number before setting %d bit: %d\n", bit, input);
                     printf("The decimal number after setting %d bit: %d\n", bit, result);
              }
         
              if (choice == 2)
              {
                    
                     do
                     {
                           printf("\nEnter the bit to clear (0-31): ");
                           scanf("%d", &bit);
                           if (bit < 0 || bit > 31)
                           {
                                  printf("Invalid input.\n");
                           }
                     } while (bit < 0 || bit > 31);
                     
                     result = input & (~(1 << bit));
                     printf("The decimal number before clearing %d bit: %d\n", bit, input);
                     printf("The decimal number after clearing %d bit: %d\n", bit, result);
              }
            
              printf("\nIf you want to repeat, press Y otherwise N: ");
              scanf(" %c", &ch);
              printf("\n");
       } while (ch == 'Y' || ch == 'y');