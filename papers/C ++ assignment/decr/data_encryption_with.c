#include<iostream>
#include<string.h>
using namespace std;
 int main()
 {
     // character array to hold message
     char mess[256];
     // to hold single character
     char ch;
     // to hold key
     int key;
     int i;
     // promt message
     cout<<"Enter a message to encrypt: ";
     // input message
     cin>>mess;
     cout<<"Enter a key: ";
     // input key
     cin>>key;
     
     // iterate over each character of a message
     for(i=0; mess[i]!='\0';i++)
     {
         // hold character
         ch = mess[i];
         // check if character is in lower case
         if(ch>= 'a' && ch<='z')
         { 
             ch = ch + key;
            if(ch>'z')
                ch = ch - 'z' + 'a' - 1;
         
         mess[i] = ch;
         }
          // check if character is in upper case
        else if(ch>= 'A' && ch<='Z')
         { 
             ch = ch + key;
              if(ch>'Z')
                ch = ch - 'Z' + 'A' - 1;
         
         mess[i] = ch;
         }
     }
         // print encrypted result
     cout<<"Encrypted message is "<<mess;
     

     return 0;
 }