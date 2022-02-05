package com.enaji;

import java.text.NumberFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.Scanner;

import static java.time.LocalTime.now;

public class Main {

    //Dealing with operators then  building the Covid 19 thermometer;
    public static <scanner> void main(String[] args) {
        int numA = 4;
        int numB = 5;
        //System.out.println(numA==numB);

        int temperature = 30;
        boolean  isNormal = temperature >30 && temperature <38;
        //System.out.println(isNormal);

        boolean hasHighincome = true;
        boolean hasGoodcredit = true;
        boolean hasCriminalrecord = false;
        boolean isEligible = (hasHighincome || hasGoodcredit) && !hasCriminalrecord;
        //System.out.println(isEligible);

       //
        //Switch statements
        String role = "admin";
        switch (role) {
           case "admin":
                System.out.println("You are an admin");
                break;
            case "moderator":
                System.out.println("You are a moderator");
                break;
            default:
                System.out.println("You are a guest");
        }

        //Do while loops --scenerio one

        String codeGreeting = "Hello world";
        //for (int k=5; k >=0; k--)
      //  System.out.println(codeGreeting + k);

        //For each loop in

        String[] fruits = {"Mango","Apple","Cider","Avocado"};
         for(String fruit: fruits);
        System.out.println(fruits);
    }
}
