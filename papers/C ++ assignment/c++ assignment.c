//QUESTION ONE NUMBERS >10 AND THEIR SQUARES

#include <iostream>

using namespace std;

int main()
{
    int k; 
 
    cout << "Enter an integer to print: "; 
    cin >> k; 
 
 
    if (k < 10)  
    { 
    cout << k << "is less than 10: " <<  endl; 
        cout << "Square of the number is:" << n*n<< endl; 
    } 
 
    cout << "I like C++ programming"; 
}

//QUESTION TWO NUMBERS >10 AND THEIR SQUARES

#include <iostream>

using namespace std;

int main()
{
      int k; 
     
    cout<< "Enter an integer to detect:"; 
    cin>> k; 
     
    if(k%2==0) 
    {  
        cout<<k<<"is even."; 
    } 
    else{ 
        cout<<k<<"is odd."; 
     
    } 
}

//QUESTION THREE -VE +VE INTEGERS

#include <iostream>

using namespace std;

int main()
{
       int k; 
     
    cout<< "Enter an integer:"; 
    cin>> k; 
     
    if(k>0) 
    {  
        cout<<k<<"is Positive"; 
    } 
    else if (k==0) 
    { 
        cout<<k<<"is zero"; 
 
    } 
    else 
    { 
    cout<<k<<"is Negative"; 
    }
}

//QUESTION 4 MAX MIN COMPARISON BETWEEN TWO NUMBERS

#include <iostream>

using namespace std;

int main()
{
       int x,y; 
     
    cout<< "Please enter the 1st integer number:"; 
    cin>> x; 
     
    cout<< "Please enter the 2nd integer  number:"; 
    cin>> y; 
     
    if(x>y) 
    {  
        cout<< x <<"is Max"; 
    } 
    else if (y>x) 
    { 
        cout<< y <<"is Max"; 
 
    } 
    else 
    { 
    cout<< x <<"&" << y << "equal"; 
    }
}


// QUESTION  5 PRINT STUDENT MARKS

#include <iostream>

using namespace std;

int main()
{
    
    float G; 
     
    cout<< "Please enter your mark:"; 
    cin>> G; 
     
    if(G>= 90) 
    {  
        cout<< "your Grade is A"; 
    } 
    else if (G>= 85) 
    { 
        cout<<"your Grade is B"; 
    } 
    else if (G>= 75) 
    { 
        cout<<"your Grade is C"; 
    } 
    else if (G>= 60) 
    { 
        cout<< "your Grade is D"; 
    } 
    else 
    { 
        cout<< "your Grade is F"; 
 
    }

    return 0;
}


