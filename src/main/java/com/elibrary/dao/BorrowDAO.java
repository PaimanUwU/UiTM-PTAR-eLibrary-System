package com.elibrary.dao;

import com.elibrary.model.Borrow;
import com.elibrary.model.BorrowingDetail;
import com.elibrary.util.DBConnection;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

public class BorrowDAO {

    private String getAnyLibrarianId(Connection conn) throws SQLException {
        String query = "SELECT librarian_id FROM LIBRARIAN LIMIT 1";
        try (PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getString("librarian_id");
            }
        }
        // Fallback: If no librarian exists, insert one
        String insertLib = "INSERT INTO LIBRARIAN (librarian_id, supervisor_id, librarian_name, librarian_email, librarian_password, librarian_phone, position) " +
                           "VALUES ('L001', NULL, 'System Admin', 'admin@ptar.edu.my', 'admin123', '0123456789', 'Chief Librarian')";
        try (PreparedStatement ps = conn.prepareStatement(insertLib)) {
            ps.executeUpdate();
        }
        return "L001";
    }

    public boolean createBorrow(String borrowerId, String bookId) {
        try (Connection conn = DBConnection.getConnection()) {
            conn.setAutoCommit(false);
            try {
                String librarianId = getAnyLibrarianId(conn);
                String borrowId = "BRW-" + UUID.randomUUID().toString().substring(0, 8).toUpperCase();
                
                // Borrow period: 14 days
                LocalDate now = LocalDate.now();
                LocalDate due = now.plusDays(14);
                
                String insertBorrow = "INSERT INTO BORROW (borrow_id, borrower_id, librarian_id, borrow_date, due_date, borrow_status) VALUES (?, ?, ?, ?, ?, ?)";
                try (PreparedStatement ps = conn.prepareStatement(insertBorrow)) {
                    ps.setString(1, borrowId);
                    ps.setString(2, borrowerId);
                    ps.setString(3, librarianId);
                    ps.setDate(4, Date.valueOf(now));
                    ps.setDate(5, Date.valueOf(due));
                    ps.setString(6, "ACTIVE");
                    ps.executeUpdate();
                }
                
                String insertDetail = "INSERT INTO BORROWING_DETAIL (borrow_id, book_id, borrow_date, return_date, detail_status) VALUES (?, ?, ?, NULL, ?)";
                try (PreparedStatement ps = conn.prepareStatement(insertDetail)) {
                    ps.setString(1, borrowId);
                    ps.setString(2, bookId);
                    ps.setDate(3, Date.valueOf(now));
                    ps.setString(4, "BORROWED");
                    ps.executeUpdate();
                }

                // Update book status to BORROWED
                String updateBook = "UPDATE BOOK SET book_status = 'BORROWED' WHERE book_id = ?";
                try (PreparedStatement ps = conn.prepareStatement(updateBook)) {
                    ps.setString(1, bookId);
                    ps.executeUpdate();
                }
                
                conn.commit();
                return true;
            } catch (SQLException e) {
                conn.rollback();
                e.printStackTrace();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Map<String, Object>> getBorrowerActiveLoans(String borrowerId) {
        List<Map<String, Object>> loans = new ArrayList<>();
        String query = "SELECT b.borrow_id, b.borrow_date, b.due_date, b.borrow_status, bd.book_id, bk.book_title, bk.author_name " +
                       "FROM BORROW b " +
                       "JOIN BORROWING_DETAIL bd ON b.borrow_id = bd.borrow_id " +
                       "JOIN BOOK bk ON bd.book_id = bk.book_id " +
                       "WHERE b.borrower_id = ? " +
                       "ORDER BY b.borrow_date DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, borrowerId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> map = new HashMap<>();
                    map.put("borrow_id", rs.getString("borrow_id"));
                    map.put("borrow_date", rs.getDate("borrow_date"));
                    map.put("due_date", rs.getDate("due_date"));
                    map.put("borrow_status", rs.getString("borrow_status"));
                    map.put("book_id", rs.getString("book_id"));
                    map.put("book_title", rs.getString("book_title"));
                    map.put("author_name", rs.getString("author_name"));
                    loans.add(map);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return loans;
    }

    public List<Map<String, Object>> getAllLoans() {
        List<Map<String, Object>> loans = new ArrayList<>();
        String query = "SELECT b.borrow_id, b.borrower_id, br.borrower_name, b.borrow_date, b.due_date, b.borrow_status, bd.book_id, bk.book_title, bd.return_date " +
                       "FROM BORROW b " +
                       "JOIN BORROWING_DETAIL bd ON b.borrow_id = bd.borrow_id " +
                       "JOIN BOOK bk ON bd.book_id = bk.book_id " +
                       "JOIN BORROWER br ON b.borrower_id = br.borrower_id " +
                       "ORDER BY b.borrow_date DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Map<String, Object> map = new HashMap<>();
                map.put("borrow_id", rs.getString("borrow_id"));
                map.put("borrower_id", rs.getString("borrower_id"));
                map.put("borrower_name", rs.getString("borrower_name"));
                map.put("borrow_date", rs.getDate("borrow_date"));
                map.put("due_date", rs.getDate("due_date"));
                map.put("borrow_status", rs.getString("borrow_status"));
                map.put("book_id", rs.getString("book_id"));
                map.put("book_title", rs.getString("book_title"));
                map.put("return_date", rs.getDate("return_date"));
                loans.add(map);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return loans;
    }

    public List<Map<String, Object>> getOverdueLoans() {
        List<Map<String, Object>> loans = new ArrayList<>();
        String query = "SELECT b.borrow_id, b.borrower_id, br.borrower_name, b.borrow_date, b.due_date, b.borrow_status, bd.book_id, bk.book_title " +
                       "FROM BORROW b " +
                       "JOIN BORROWING_DETAIL bd ON b.borrow_id = bd.borrow_id " +
                       "JOIN BOOK bk ON bd.book_id = bk.book_id " +
                       "JOIN BORROWER br ON b.borrower_id = br.borrower_id " +
                       "WHERE b.due_date < CURDATE() AND bd.return_date IS NULL";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Map<String, Object> map = new HashMap<>();
                map.put("borrow_id", rs.getString("borrow_id"));
                map.put("borrower_id", rs.getString("borrower_id"));
                map.put("borrower_name", rs.getString("borrower_name"));
                map.put("borrow_date", rs.getDate("borrow_date"));
                map.put("due_date", rs.getDate("due_date"));
                map.put("borrow_status", rs.getString("borrow_status"));
                map.put("book_id", rs.getString("book_id"));
                map.put("book_title", rs.getString("book_title"));
                loans.add(map);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return loans;
    }

    public boolean returnBook(String borrowId, String bookId) {
        try (Connection conn = DBConnection.getConnection()) {
            conn.setAutoCommit(false);
            try {
                String updateDetail = "UPDATE BORROWING_DETAIL SET return_date = CURDATE(), detail_status = 'RETURNED' WHERE borrow_id = ? AND book_id = ?";
                try (PreparedStatement ps = conn.prepareStatement(updateDetail)) {
                    ps.setString(1, borrowId);
                    ps.setString(2, bookId);
                    ps.executeUpdate();
                }

                String updateBorrow = "UPDATE BORROW SET borrow_status = 'RETURNED' WHERE borrow_id = ?";
                try (PreparedStatement ps = conn.prepareStatement(updateBorrow)) {
                    ps.setString(1, borrowId);
                    ps.executeUpdate();
                }

                String updateBook = "UPDATE BOOK SET book_status = 'AVAILABLE' WHERE book_id = ?";
                try (PreparedStatement ps = conn.prepareStatement(updateBook)) {
                    ps.setString(1, bookId);
                    ps.executeUpdate();
                }

                conn.commit();
                return true;
            } catch (SQLException e) {
                conn.rollback();
                e.printStackTrace();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
