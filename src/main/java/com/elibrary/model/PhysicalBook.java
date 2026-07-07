package com.elibrary.model;

public class PhysicalBook extends Book {
    public String shelf_location;
    public String accession_no;
    public int copy_number;
    public String condition_status;

    public PhysicalBook() {
        super();
    }

    public PhysicalBook(String book_id, String librarian_id, String book_title, String author_name, String publisher, String publish_year, String ISBN, String book_status, String book_type, String shelf_location, String accession_no, int copy_number, String condition_status) {
        super(book_id, librarian_id, book_title, author_name, publisher, publish_year, ISBN, book_status, book_type);
        this.shelf_location = shelf_location;
        this.accession_no = accession_no;
        this.copy_number = copy_number;
        this.condition_status = condition_status;
    }

    // Getters and Setters
    public String getShelf_location() { return shelf_location; }
    public void setShelf_location(String shelf_location) { this.shelf_location = shelf_location; }

    public String getAccession_no() { return accession_no; }
    public void setAccession_no(String accession_no) { this.accession_no = accession_no; }

    public int getCopy_number() { return copy_number; }
    public void setCopy_number(int copy_number) { this.copy_number = copy_number; }

    public String getCondition_status() { return condition_status; }
    public void setCondition_status(String condition_status) { this.condition_status = condition_status; }
}
