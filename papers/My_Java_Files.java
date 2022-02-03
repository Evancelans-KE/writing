package com.enaji;

import java.util.Date;
import java.util.Scanner;

import static java.time.LocalTime.now;

public class Main {

    public static <scanner> void main(String[] args) {
        Scanner sc = new Scanner(System.in); //this class captures input
        System.out.println("Enter your PIN: ");
        int userPin = sc.nextInt();

         //Define ATM activities
        String one =    "1. Check Balance";
        String two =    "2. Withdraw";
        String three =  "3. Deposit";
        int currentBalance = 30_000;
        String allActions = one + two + three;
        System.out.println(allActions);
        System.out.println("Type the  Service Type below:");
        String userAction = sc.nextLine();

       //show user balance
          if (userAction == one){
              System.out.println(currentBalance);
          }
          //Deduct balance from user account;
          else if (userAction == two){
              System.out.println("Enter Amount to Withdraw: ");
              int withdrawAmount = sc.nextInt();
              //then deduct from balance
              float deductfromBalance = currentBalance - withdrawAmount;
              System.out.println("Withdraw Successful, Your balance is ..." + deductfromBalance);
          }
    }
}
