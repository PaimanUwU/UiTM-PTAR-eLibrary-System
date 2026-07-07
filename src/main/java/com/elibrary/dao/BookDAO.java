package com.elibrary.dao;

import com.elibrary.model.Book;
import com.elibrary.model.EBook;
import com.elibrary.model.PhysicalBook;
import com.elibrary.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class BookDAO {

    private Book extractBookFromResultSet(ResultSet rs) throws SQLException {
        String bookType = rs.getString("book_type");
        if ("E-BOOK".equalsIgnoreCase(bookType)) {
            return new EBook(
                rs.getString("book_id"),
                rs.getString("librarian_id"),
                rs.getString("book_title"),
                rs.getString("author_name"),
                rs.getString("publisher"),
                rs.getString("publish_year"),
                rs.getString("ISBN"),
                rs.getString("book_status"),
                bookType,
                rs.getString("file_size"),
                rs.getString("access_link")
            );
        } else {
            return new PhysicalBook(
                rs.getString("book_id"),
                rs.getString("librarian_id"),
                rs.getString("book_title"),
                rs.getString("author_name"),
                rs.getString("publisher"),
                rs.getString("publish_year"),
                rs.getString("ISBN"),
                rs.getString("book_status"),
                bookType,
                rs.getString("shelf_location"),
                rs.getString("accession_no"),
                rs.getInt("copy_number"),
                rs.getString("condition_status")
            );
        }
    }

    public List<Book> getAllBooks() {
        List<Book> books = new ArrayList<>();
        String query = "SELECT b.*, e.file_size, e.access_link, p.shelf_location, p.accession_no, p.copy_number, p.condition_status " +
                       "FROM BOOK b " +
                       "LEFT JOIN E_BOOK e ON b.book_id = e.book_id " +
                       "LEFT JOIN PHYSICAL_BOOK p ON b.book_id = p.book_id";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                books.add(extractBookFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return books;
    }

    public List<Book> searchBooks(String search) {
        List<Book> books = new ArrayList<>();
        String query = "SELECT b.*, e.file_size, e.access_link, p.shelf_location, p.accession_no, p.copy_number, p.condition_status " +
                       "FROM BOOK b " +
                       "LEFT JOIN E_BOOK e ON b.book_id = e.book_id " +
                       "LEFT JOIN PHYSICAL_BOOK p ON b.book_id = p.book_id " +
                       "WHERE b.book_title LIKE ? OR b.author_name LIKE ? OR b.ISBN LIKE ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            String pattern = "%" + search + "%";
            ps.setString(1, pattern);
            ps.setString(2, pattern);
            ps.setString(3, pattern);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    books.add(extractBookFromResultSet(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return books;
    }

    public Book getBookById(String bookId) {
        String query = "SELECT b.*, e.file_size, e.access_link, p.shelf_location, p.accession_no, p.copy_number, p.condition_status " +
                       "FROM BOOK b " +
                       "LEFT JOIN E_BOOK e ON b.book_id = e.book_id " +
                       "LEFT JOIN PHYSICAL_BOOK p ON b.book_id = p.book_id " +
                       "WHERE b.book_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, bookId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return extractBookFromResultSet(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean addBook(Book book) {
        String bookQuery = "INSERT INTO BOOK (book_id, librarian_id, book_title, author_name, publisher, publish_year, ISBN, book_status, book_type) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection()) {
            conn.setAutoCommit(false);
            try (PreparedStatement ps = conn.prepareStatement(bookQuery)) {
                ps.setString(1, book.getBook_id());
                ps.setString(2, book.getLibrarian_id());
                ps.setString(3, book.getBook_title());
                ps.setString(4, book.getAuthor_name());
                ps.setString(5, book.getPublisher());
                ps.setString(6, book.getPublish_year());
                ps.setString(7, book.getISBN());
                ps.setString(8, book.getBook_status());
                ps.setString(9, book.getBook_type());
                ps.executeUpdate();
            }

            if (book instanceof EBook) {
                EBook ebook = (EBook) book;
                String subQuery = "INSERT INTO E_BOOK (book_id, file_size, access_link) VALUES (?, ?, ?)";
                try (PreparedStatement ps = conn.prepareStatement(subQuery)) {
                    ps.setString(1, ebook.getBook_id());
                    ps.setString(2, ebook.getFile_size());
                    ps.setString(3, ebook.getAccess_link());
                    ps.executeUpdate();
                }
            } else if (book instanceof PhysicalBook) {
                PhysicalBook pbook = (PhysicalBook) book;
                String subQuery = "INSERT INTO PHYSICAL_BOOK (book_id, shelf_location, accession_no, copy_number, condition_status) VALUES (?, ?, ?, ?, ?)";
                try (PreparedStatement ps = conn.prepareStatement(subQuery)) {
                    ps.setString(1, pbook.getBook_id());
                    ps.setString(2, pbook.getShelf_location());
                    ps.setString(3, pbook.getAccession_no());
                    ps.setInt(4, pbook.getCopy_number());
                    ps.setString(5, pbook.getCondition_status());
                    ps.executeUpdate();
                }
            }
            conn.commit();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateBook(Book book) {
        String bookQuery = "UPDATE BOOK SET librarian_id = ?, book_title = ?, author_name = ?, publisher = ?, publish_year = ?, ISBN = ?, book_status = ?, book_type = ? WHERE book_id = ?";
        try (Connection conn = DBConnection.getConnection()) {
            conn.setAutoCommit(false);
            try (PreparedStatement ps = conn.prepareStatement(bookQuery)) {
                ps.setString(1, book.getLibrarian_id());
                ps.setString(2, book.getBook_title());
                ps.setString(3, book.getAuthor_name());
                ps.setString(4, book.getPublisher());
                ps.setString(5, book.getPublish_year());
                ps.setString(6, book.getISBN());
                ps.setString(7, book.getBook_status());
                ps.setString(8, book.getBook_type());
                ps.setString(9, book.getBook_id());
                ps.executeUpdate();
            }

            if (book instanceof EBook) {
                EBook ebook = (EBook) book;
                String subQuery = "INSERT INTO E_BOOK (book_id, file_size, access_link) VALUES (?, ?, ?) ON DUPLICATE KEY UPDATE file_size = ?, access_link = ?";
                try (PreparedStatement ps = conn.prepareStatement(subQuery)) {
                    ps.setString(1, ebook.getBook_id());
                    ps.setString(2, ebook.getFile_size());
                    ps.setString(3, ebook.getAccess_link());
                    ps.setString(4, ebook.getFile_size());
                    ps.setString(5, ebook.getAccess_link());
                    ps.executeUpdate();
                }
            } else if (book instanceof PhysicalBook) {
                PhysicalBook pbook = (PhysicalBook) book;
                String subQuery = "INSERT INTO PHYSICAL_BOOK (book_id, shelf_location, accession_no, copy_number, condition_status) VALUES (?, ?, ?, ?, ?) " +
                                  "ON DUPLICATE KEY UPDATE shelf_location = ?, accession_no = ?, copy_number = ?, condition_status = ?";
                try (PreparedStatement ps = conn.prepareStatement(subQuery)) {
                    ps.setString(1, pbook.getBook_id());
                    ps.setString(2, pbook.getShelf_location());
                    ps.setString(3, pbook.getAccession_no());
                    ps.setInt(4, pbook.getCopy_number());
                    ps.setString(5, pbook.getCondition_status());
                    ps.setString(6, pbook.getShelf_location());
                    ps.setString(7, pbook.getAccession_no());
                    ps.setInt(8, pbook.getCopy_number());
                    ps.setString(9, pbook.getCondition_status());
                    ps.executeUpdate();
                }
            }
            conn.commit();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteBook(String bookId) {
        String query = "DELETE FROM BOOK WHERE book_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, bookId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
