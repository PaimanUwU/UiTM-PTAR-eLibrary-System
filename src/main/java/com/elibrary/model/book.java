/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.elibrary.model;

/**
 *
 * @author AdamZ
 */
public class book {
    String book_id;
    String librarian_id;
    String book_title;
    String author_name;
    String publisher;
    String publish_year;
    String ISBN;
    String book_status;
    String book_type;
    
    public book(String book_id, String lib_id, String title, String author_name, String publisher, String publish_year, String ISBN, String book_status, String book_type){
        this.book_id = book_id;
        this.librarian_id = lib_id;
        this.book_title = title;
        this.author_name = author_name;
        this.publisher = publisher;
        this.publish_year = publish_year;
        this.ISBN = ISBN;
        this.book_status = book_status;
        this.book_type = book_type;
    }
}
