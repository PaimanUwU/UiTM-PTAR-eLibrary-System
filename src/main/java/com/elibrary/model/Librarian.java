package com.elibrary.model;

public class Librarian {
    public String librarian_id;
    public String supervisor_id;
    public String librarian_name;
    public String librarian_email;
    public String librarian_password;
    public String librarian_phone;
    public String position;

    public Librarian() {}

    public Librarian(String librarian_id, String supervisor_id, String librarian_name, String librarian_email, String librarian_password, String librarian_phone, String position) {
        this.librarian_id = librarian_id;
        this.supervisor_id = supervisor_id;
        this.librarian_name = librarian_name;
        this.librarian_email = librarian_email;
        this.librarian_password = librarian_password;
        this.librarian_phone = librarian_phone;
        this.position = position;
    }

    // Getters and Setters
    public String getLibrarian_id() { return librarian_id; }
    public void setLibrarian_id(String librarian_id) { this.librarian_id = librarian_id; }

    public String getSupervisor_id() { return supervisor_id; }
    public void setSupervisor_id(String supervisor_id) { this.supervisor_id = supervisor_id; }

    public String getLibrarian_name() { return librarian_name; }
    public void setLibrarian_name(String librarian_name) { this.librarian_name = librarian_name; }

    public String getLibrarian_email() { return librarian_email; }
    public void setLibrarian_email(String librarian_email) { this.librarian_email = librarian_email; }

    public String getLibrarian_password() { return librarian_password; }
    public void setLibrarian_password(String librarian_password) { this.librarian_password = librarian_password; }

    public String getLibrarian_phone() { return librarian_phone; }
    public void setLibrarian_phone(String librarian_phone) { this.librarian_phone = librarian_phone; }

    public String getPosition() { return position; }
    public void setPosition(String position) { this.position = position; }
}
