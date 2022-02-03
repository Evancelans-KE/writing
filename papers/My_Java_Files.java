//Simple number identifications;
package com.enaji;

import java.util.Date;
import java.util.Scanner;

import static java.time.LocalTime.now;

public class Main {

    public static <scanner> void main(String[] args) {
        Scanner sc = new Scanner(System.in); //this class captures inputs
        double avg, sum, div, multiplication; //the operations we want to carry out;
        int currentYear = 2022;
        System.out.println("Enter your Current  age: ");
        int Age = sc.nextInt();
        int birthYear = currentYear - Age;
        String greeting = "Welcome to GT Bank";
        System.out.println(greeting + "Your Year of Birth is" + birthYear);


    }
}

// BASIC ATM  SCENERIO

