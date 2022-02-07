package com.enaji;

import java.util.Date;
import java.util.Scanner;

import static java.time.LocalTime.now;

public class Main {

    public static <scanner> void main(String[] args) {
        Scanner sc = new Scanner(System.in); //this class captures input
        System.out.println("Enter tip Amount: ");
        int clientTip= sc.nextInt();
        
        //selected menu items
        double coffee = 50.56;
        double salad = 2.55;
        double soup = 4.23;
        double vatTax  = 0.16;
        double vatValue = (coffee + salad +soup) * vatTax;

        double totalPrice =  Math.round((coffee + salad +soup) + vatValue  + clientTip);
        System.out.println("your bill is:  " +  totalPrice +  "  Thank You !!");
    }
}
