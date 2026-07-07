package com.elibrary.dao;

import com.elibrary.model.Borrower;
import com.elibrary.model.Librarian;
import com.elibrary.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO {

    public Borrower authenticateBorrower(String email, String password) {
        String query = "SELECT * FROM BORROWER WHERE borrower_email = ? AND borrower_password = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, email);
            ps.setString(2, password);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Borrower(
                        rs.getString("borrower_id"),
                        rs.getString("borrower_name"),
                        rs.getString("borrower_email"),
                        rs.getString("borrower_password"),
                        rs.getString("borrower_phone"),
                        rs.getString("borrower_type"),
                        rs.getString("borrower_status")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public Librarian authenticateLibrarian(String email, String password) {
        String query = "SELECT * FROM LIBRARIAN WHERE librarian_email = ? AND librarian_password = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, email);
            ps.setString(2, password);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Librarian(
                        rs.getString("librarian_id"),
                        rs.getString("supervisor_id"),
                        rs.getString("librarian_name"),
                        rs.getString("librarian_email"),
                        rs.getString("librarian_password"),
                        rs.getString("librarian_phone"),
                        rs.getString("position")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public Borrower getBorrowerById(String id) {
        String query = "SELECT * FROM BORROWER WHERE borrower_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Borrower(
                        rs.getString("borrower_id"),
                        rs.getString("borrower_name"),
                        rs.getString("borrower_email"),
                        rs.getString("borrower_password"),
                        rs.getString("borrower_phone"),
                        rs.getString("borrower_type"),
                        rs.getString("borrower_status")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean addBorrower(Borrower borrower) {
        String query = "INSERT INTO BORROWER (borrower_id, borrower_name, borrower_email, borrower_password, borrower_phone, borrower_type, borrower_status) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, borrower.getBorrower_id());
            ps.setString(2, borrower.getBorrower_name());
            ps.setString(3, borrower.getBorrower_email());
            ps.setString(4, borrower.getBorrower_password());
            ps.setString(5, borrower.getBorrower_phone());
            ps.setString(6, borrower.getBorrower_type());
            ps.setString(7, borrower.getBorrower_status());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
