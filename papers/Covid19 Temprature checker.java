package com.enaji;

import java.util.Date;
import java.util.Scanner;

import static java.time.LocalTime.now;

public class Main {

    public static <scanner> void main(String[] args) {
        Scanner sc = new Scanner(System.in); //this class captures input
        System.out.println("Enter your temperature: ");
        int temperature= sc.nextInt();
        //System.out.println("Enter your Name: ");
        //String yourName = sc.nextLine();
        String  greeting = "Welcome";
        String infoMessage = "Your body temperature is";
        String summaryMsg = greeting +infoMessage+temperature;

        if (temperature >30 && temperature <=35){
            System.out.println(summaryMsg+"Normal Temperature");
        }else if (temperature <29){
            System.out.println(summaryMsg+"Low temperature");
        }else if (temperature >35){
            System.out.println(summaryMsg+"High and this is a, Covid Symptom, please qaurantine");
        }else;
        System.out.println("Check further..");
    }
}
