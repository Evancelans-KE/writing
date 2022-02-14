#include
#include "unistd.h"
int main()
{
fork();
fork();
fork();
printf("These processes are being forked !! \n")
return 0;
}
