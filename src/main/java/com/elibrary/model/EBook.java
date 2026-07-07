package com.elibrary.model;

public class EBook extends Book {
    public String file_size;
    public String access_link;

    public EBook() {
        super();
    }

    public EBook(String book_id, String librarian_id, String book_title, String author_name, String publisher, String publish_year, String ISBN, String book_status, String book_type, String file_size, String access_link) {
        super(book_id, librarian_id, book_title, author_name, publisher, publish_year, ISBN, book_status, book_type);
        this.file_size = file_size;
        this.access_link = access_link;
    }

    // Getters and Setters
    public String getFile_size() { return file_size; }
    public void setFile_size(String file_size) { this.file_size = file_size; }

    public String getAccess_link() { return access_link; }
    public void setAccess_link(String access_link) { this.access_link = access_link; }
}
