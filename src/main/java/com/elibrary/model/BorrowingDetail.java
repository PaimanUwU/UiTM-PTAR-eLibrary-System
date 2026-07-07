package com.elibrary.model;

import java.sql.Date;

public class BorrowingDetail {
    public String borrow_id;
    public String book_id;
    public Date borrow_date;
    public Date return_date;
    public String detail_status;

    public BorrowingDetail() {}

    public BorrowingDetail(String borrow_id, String book_id, Date borrow_date, Date return_date, String detail_status) {
        this.borrow_id = borrow_id;
        this.book_id = book_id;
        this.borrow_date = borrow_date;
        this.return_date = return_date;
        this.detail_status = detail_status;
    }

    // Getters and Setters
    public String getBorrow_id() { return borrow_id; }
    public void setBorrow_id(String borrow_id) { this.borrow_id = borrow_id; }

    public String getBook_id() { return book_id; }
    public void setBook_id(String book_id) { this.book_id = book_id; }

    public Date getBorrow_date() { return borrow_date; }
    public void setBorrow_date(Date borrow_date) { this.borrow_date = borrow_date; }

    public Date getReturn_date() { return return_date; }
    public void setReturn_date(Date return_date) { this.return_date = return_date; }

    public String getDetail_status() { return detail_status; }
    public void setDetail_status(String detail_status) { this.detail_status = detail_status; }
}
