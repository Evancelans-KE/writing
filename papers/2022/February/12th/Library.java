package com.bookSpace;

import java.util.Date;

public class Main {

    public static <scanner> void main(String[] args) {

        //defining the book class
        Books libBooks = new Books();
        libBooks.bookTitle = "Crime and Punishment";
        libBooks.bookAuthor = "Dostoevsky";
        libBooks.bookPublisher = "Simon and Schuster";
        System.out.println(libBooks.bookTitle + libBooks.bookAuthor+libBooks.bookPublisher);

        //defining the magazine class
        Magazine libMagazines = new Magazine();
        libMagazines.magazineTitle = "Sports Illustrated";
        libMagazines.magazinePublisher = "Random House";
        libMagazines.printDate = new Date();
        System.out.println(libMagazines.magazineTitle+libMagazines.magazinePublisher+libMagazines.printDate);

        //defining another book class
        Books libBooks2 = new Books();
        libBooks2.bookTitle = "The Hobbit";
        libBooks2.bookAuthor = "Tolkien";
        libBooks2.bookPublisher = "Harper Collins";
        System.out.println(libBooks2.bookTitle + libBooks2.bookAuthor+libBooks2.bookPublisher);

    }

    public static void printCollection(String publishedWorks){
        System.out.println(publishedWorks);

    }

}
