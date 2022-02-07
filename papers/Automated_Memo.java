package com.enaji;

import java.util.Date;
import java.util.Scanner;

import static java.time.LocalTime.now;

public class Main {

    public static <scanner> void main(String[] args) {
        Scanner sc = new Scanner(System.in); //this class captures input

        Date now = new Date();
        String salutation = "Yours sincerely:";
        System.out.println("Enter Recipient Name/(s): ");
        String toReader= sc.nextLine();
        System.out.println("From  Name/(s): ");
        String fromUser = sc.nextLine();
        System.out.println("Subject: ");
        String memoSubject = sc.nextLine();
        System.out.println("Body message: ");
        String bodyMessage  = sc.nextLine();
        System.out.println("Your Name: ");
        String yourName  = sc.nextLine();

        System.out.println("Date:" +now);
        System.out.println("To:"  +toReader);
        System.out.println("From:" +fromUser);
        System.out.println("Subject:"  +memoSubject);
        System.out.println("Message: " +bodyMessage);
        System.out.println(salutation);
        System.out.println(yourName);

    }
}
