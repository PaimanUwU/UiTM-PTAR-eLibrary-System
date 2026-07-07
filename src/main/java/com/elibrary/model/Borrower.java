package com.elibrary.model;

public class Borrower {
    public String borrower_id;
    public String borrower_name;
    public String borrower_email;
    public String borrower_password;
    public String borrower_phone;
    public String borrower_type;
    public String borrower_status;

    public Borrower() {}

    public Borrower(String borrower_id, String borrower_name, String borrower_email, String borrower_password, String borrower_phone, String borrower_type, String borrower_status) {
        this.borrower_id = borrower_id;
        this.borrower_name = borrower_name;
        this.borrower_email = borrower_email;
        this.borrower_password = borrower_password;
        this.borrower_phone = borrower_phone;
        this.borrower_type = borrower_type;
        this.borrower_status = borrower_status;
    }

    // Getters and Setters
    public String getBorrower_id() { return borrower_id; }
    public void setBorrower_id(String borrower_id) { this.borrower_id = borrower_id; }

    public String getBorrower_name() { return borrower_name; }
    public void setBorrower_name(String borrower_name) { this.borrower_name = borrower_name; }

    public String getBorrower_email() { return borrower_email; }
    public void setBorrower_email(String borrower_email) { this.borrower_email = borrower_email; }

    public String getBorrower_password() { return borrower_password; }
    public void setBorrower_password(String borrower_password) { this.borrower_password = borrower_password; }

    public String getBorrower_phone() { return borrower_phone; }
    public void setBorrower_phone(String borrower_phone) { this.borrower_phone = borrower_phone; }

    public String getBorrower_type() { return borrower_type; }
    public void setBorrower_type(String borrower_type) { this.borrower_type = borrower_type; }

    public String getBorrower_status() { return borrower_status; }
    public void setBorrower_status(String borrower_status) { this.borrower_status = borrower_status; }
}
