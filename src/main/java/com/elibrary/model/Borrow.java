package com.elibrary.model;

import java.sql.Date;

public class Borrow {
    public String borrow_id;
    public String borrower_id;
    public String librarian_id;
    public Date borrow_date;
    public Date due_date;
    public String borrow_status;

    public Borrow() {}

    public Borrow(String borrow_id, String borrower_id, String librarian_id, Date borrow_date, Date due_date, String borrow_status) {
        this.borrow_id = borrow_id;
        this.borrower_id = borrower_id;
        this.librarian_id = librarian_id;
        this.borrow_date = borrow_date;
        this.due_date = due_date;
        this.borrow_status = borrow_status;
    }

    // Getters and Setters
    public String getBorrow_id() { return borrow_id; }
    public void setBorrow_id(String borrow_id) { this.borrow_id = borrow_id; }

    public String getBorrower_id() { return borrower_id; }
    public void setBorrower_id(String borrower_id) { this.borrower_id = borrower_id; }

    public String getLibrarian_id() { return librarian_id; }
    public void setLibrarian_id(String librarian_id) { this.librarian_id = librarian_id; }

    public Date getBorrow_date() { return borrow_date; }
    public void setBorrow_date(Date borrow_date) { this.borrow_date = borrow_date; }

    public Date getDue_date() { return due_date; }
    public void setDue_date(Date due_date) { this.due_date = due_date; }

    public String getBorrow_status() { return borrow_status; }
    public void setBorrow_status(String borrow_status) { this.borrow_status = borrow_status; }
}
