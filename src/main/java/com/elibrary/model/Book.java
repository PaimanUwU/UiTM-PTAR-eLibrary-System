package com.elibrary.model;

public class Book {
    public String book_id;
    public String librarian_id;
    public String book_title;
    public String author_name;
    public String publisher;
    public String publish_year;
    public String ISBN;
    public String book_status;
    public String book_type;

    public Book() {}

    public Book(String book_id, String librarian_id, String book_title, String author_name, String publisher, String publish_year, String ISBN, String book_status, String book_type) {
        this.book_id = book_id;
        this.librarian_id = librarian_id;
        this.book_title = book_title;
        this.author_name = author_name;
        this.publisher = publisher;
        this.publish_year = publish_year;
        this.ISBN = ISBN;
        this.book_status = book_status;
        this.book_type = book_type;
    }

    // Getters and Setters
    public String getBook_id() { return book_id; }
    public void setBook_id(String book_id) { this.book_id = book_id; }

    public String getLibrarian_id() { return librarian_id; }
    public void setLibrarian_id(String librarian_id) { this.librarian_id = librarian_id; }

    public String getBook_title() { return book_title; }
    public void setBook_title(String book_title) { this.book_title = book_title; }

    public String getAuthor_name() { return author_name; }
    public void setAuthor_name(String author_name) { this.author_name = author_name; }

    public String getPublisher() { return publisher; }
    public void setPublisher(String publisher) { this.publisher = publisher; }

    public String getPublish_year() { return publish_year; }
    public void setPublish_year(String publish_year) { this.publish_year = publish_year; }

    public String getISBN() { return ISBN; }
    public void setISBN(String ISBN) { this.ISBN = ISBN; }

    public String getBook_status() { return book_status; }
    public void setBook_status(String book_status) { this.book_status = book_status; }

    public String getBook_type() { return book_type; }
    public void setBook_type(String book_type) { this.book_type = book_type; }
}
