package com.elibrary.util;

import com.elibrary.model.*;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

public class DummyDataFactory {

    // Factory Method to create Book instances
    public static Book createBook(String type, String id, String librarianId, String title, String author, String publisher, String year, String isbn, String status, String field1, String field2, int copyNum, String condition) {
        if ("E-BOOK".equalsIgnoreCase(type)) {
            return new EBook(id, librarianId, title, author, publisher, year, isbn, status, "E-BOOK", field1, field2);
        } else {
            return new PhysicalBook(id, librarianId, title, author, publisher, year, isbn, status, "PHYSICAL_BOOK", field1, field2, copyNum, condition);
        }
    }

    public static void main(String[] args) {
        insertDummyData();
    }

    public static void insertDummyData() {
        try (Connection conn = DBConnection.getConnection()) {
            // Clear existing records first to guarantee clean slate with user-specified counts
            System.out.println("Clearing old records to seed fresh mock data...");
            try (PreparedStatement ps = conn.prepareStatement("SET FOREIGN_KEY_CHECKS = 0")) { ps.executeUpdate(); }
            try (PreparedStatement ps = conn.prepareStatement("TRUNCATE TABLE BORROWING_DETAIL")) { ps.executeUpdate(); }
            try (PreparedStatement ps = conn.prepareStatement("TRUNCATE TABLE BORROW")) { ps.executeUpdate(); }
            try (PreparedStatement ps = conn.prepareStatement("TRUNCATE TABLE E_BOOK")) { ps.executeUpdate(); }
            try (PreparedStatement ps = conn.prepareStatement("TRUNCATE TABLE PHYSICAL_BOOK")) { ps.executeUpdate(); }
            try (PreparedStatement ps = conn.prepareStatement("TRUNCATE TABLE BOOK")) { ps.executeUpdate(); }
            try (PreparedStatement ps = conn.prepareStatement("TRUNCATE TABLE BORROWER")) { ps.executeUpdate(); }
            try (PreparedStatement ps = conn.prepareStatement("TRUNCATE TABLE LIBRARIAN")) { ps.executeUpdate(); }
            try (PreparedStatement ps = conn.prepareStatement("SET FOREIGN_KEY_CHECKS = 1")) { ps.executeUpdate(); }

            System.out.println("Populating database with 2 Admins, 10 Borrowers, and 55 Books...");

            // 1. Insert 2 Admins (Librarians)
            String insertLib = "INSERT INTO LIBRARIAN (librarian_id, supervisor_id, librarian_name, librarian_email, librarian_password, librarian_phone, position) VALUES (?, ?, ?, ?, ?, ?, ?)";
            try (PreparedStatement ps = conn.prepareStatement(insertLib)) {
                // Admin 1 (Supervisor)
                ps.setString(1, "L001");
                ps.setNull(2, java.sql.Types.VARCHAR);
                ps.setString(3, "Dr. Ahmad Fadzil");
                ps.setString(4, "ahmad@ptar.edu.my");
                ps.setString(5, "admin123");
                ps.setString(6, "019-2837465");
                ps.setString(7, "Chief Librarian");
                ps.executeUpdate();

                // Admin 2 (Subordinate)
                ps.setString(1, "L002");
                ps.setString(2, "L001");
                ps.setString(3, "Siti Aminah");
                ps.setString(4, "siti@ptar.edu.my");
                ps.setString(5, "admin123");
                ps.setString(6, "013-9847261");
                ps.setString(7, "Assistant Librarian");
                ps.executeUpdate();
            }

            // 2. Insert 10 Borrowers
            String insertBorrower = "INSERT INTO BORROWER (borrower_id, borrower_name, borrower_email, borrower_password, borrower_phone, borrower_type, borrower_status) VALUES (?, ?, ?, ?, ?, ?, ?)";
            String[] borrowerNames = {
                "Ali bin Abu", "Sarah Connor", "John Doe", "Aisha Ahmad", 
                "Chong Wei", "Muthu Pillay", "Fatimah Zakaria", "Daniel Craig", 
                "Nurul Huda", "Michael Scott"
            };
            try (PreparedStatement ps = conn.prepareStatement(insertBorrower)) {
                for (int i = 1; i <= 10; i++) {
                    String id = String.format("B%03d", i);
                    String name = borrowerNames[i - 1];
                    String email = name.toLowerCase().replace(" ", ".").replace("bin.", "").replace("binti.", "") + "@student.uitm.edu.my";
                    
                    ps.setString(1, id);
                    ps.setString(2, name);
                    ps.setString(3, email);
                    ps.setString(4, "student123");
                    ps.setString(5, "012-" + (1000000 + new Random().nextInt(9000000)));
                    ps.setString(6, i % 4 == 0 ? "STAFF" : "STUDENT");
                    ps.setString(7, "ACTIVE");
                    ps.executeUpdate();
                }
            }

            // 3. Generate 55 Books programmatically using various disciplines
            List<Book> books = new ArrayList<>();
            String[] subjects = {"Java", "Python", "Database", "Algorithms", "Web Development", "Operating Systems", "Networking", "AI", "Software Testing", "Cloud Computing"};
            String[] authors = {"John Smith", "Kathy Sierra", "Joshua Bloch", "Herbert Schildt", "Robert Martin", "Martin Fowler", "Bruce Eckel", "Craig Larman"};
            String[] publishers = {"O'Reilly Media", "Pearson", "Addison-Wesley", "McGraw-Hill", "Prentice Hall", "MIT Press"};

            Random rand = new Random();
            for (int i = 1; i <= 55; i++) {
                String bookId = String.format("BK%03d", i);
                String libId = (i % 2 == 0) ? "L002" : "L001";
                String type = (i % 3 == 0) ? "E-BOOK" : "PHYSICAL_BOOK";
                
                String subject = subjects[i % subjects.length];
                String title = subject + " Mastery: Volume " + ((i / subjects.length) + 1);
                String author = authors[i % authors.length];
                String publisher = publishers[i % publishers.length];
                String year = String.valueOf(2010 + rand.nextInt(16));
                String isbn = "978-" + (1000000000L + rand.nextInt(900000000));
                String status = "AVAILABLE"; // initial status

                if ("E-BOOK".equals(type)) {
                    String fileSize = (5 + rand.nextInt(35)) + " MB";
                    String accessLink = "https://ptar.elibrary.edu.my/resources/download/" + bookId;
                    books.add(createBook("E-BOOK", bookId, libId, title, author, publisher, year, isbn, status, fileSize, accessLink, 0, null));
                } else {
                    String shelf = "Level " + (1 + rand.nextInt(4)) + ", Shelf " + (char)('A' + rand.nextInt(6)) + "-" + (1 + rand.nextInt(10));
                    String accession = "ACC-" + (10000 + rand.nextInt(90000));
                    int copyNum = 1 + rand.nextInt(5);
                    String condition = rand.nextBoolean() ? "New" : "Good";
                    books.add(createBook("PHYSICAL_BOOK", bookId, libId, title, author, publisher, year, isbn, status, shelf, accession, copyNum, condition));
                }
            }

            // Set specific books status for active borrowings later
            books.get(10).setBook_status("BORROWED");
            books.get(20).setBook_status("BORROWED");

            // Insert Books & Subclass Data
            String insertBook = "INSERT INTO BOOK (book_id, librarian_id, book_title, author_name, publisher, publish_year, ISBN, book_status, book_type) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
            String insertEBook = "INSERT INTO E_BOOK (book_id, file_size, access_link) VALUES (?, ?, ?)";
            String insertPBook = "INSERT INTO PHYSICAL_BOOK (book_id, shelf_location, accession_no, copy_number, condition_status) VALUES (?, ?, ?, ?, ?)";

            for (Book book : books) {
                try (PreparedStatement ps = conn.prepareStatement(insertBook)) {
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
                    EBook eb = (EBook) book;
                    try (PreparedStatement ps = conn.prepareStatement(insertEBook)) {
                        ps.setString(1, eb.getBook_id());
                        ps.setString(2, eb.getFile_size());
                        ps.setString(3, eb.getAccess_link());
                        ps.executeUpdate();
                    }
                } else if (book instanceof PhysicalBook) {
                    PhysicalBook pb = (PhysicalBook) book;
                    try (PreparedStatement ps = conn.prepareStatement(insertPBook)) {
                        ps.setString(1, pb.getBook_id());
                        ps.setString(2, pb.getShelf_location());
                        ps.setString(3, pb.getAccession_no());
                        ps.setInt(4, pb.getCopy_number());
                        ps.setString(5, pb.getCondition_status());
                        ps.executeUpdate();
                    }
                }
            }

            // 4. Create Active and Late borrowings for demonstration
            LocalDate today = LocalDate.now();

            // Borrowing 1 (Active) - Borrower B001 borrows BK011
            String insertBorrow1 = "INSERT INTO BORROW (borrow_id, borrower_id, librarian_id, borrow_date, due_date, borrow_status) VALUES ('BRW-001', 'B001', 'L002', ?, ?, 'ACTIVE')";
            try (PreparedStatement ps = conn.prepareStatement(insertBorrow1)) {
                ps.setDate(1, Date.valueOf(today.minusDays(3)));
                ps.setDate(2, Date.valueOf(today.plusDays(11)));
                ps.executeUpdate();
            }
            String insertDetail1 = "INSERT INTO BORROWING_DETAIL (borrow_id, book_id, borrow_date, return_date, detail_status) VALUES ('BRW-001', 'BK011', ?, NULL, 'BORROWED')";
            try (PreparedStatement ps = conn.prepareStatement(insertDetail1)) {
                ps.setDate(1, Date.valueOf(today.minusDays(3)));
                ps.executeUpdate();
            }

            // Borrowing 2 (Late) - Borrower B002 borrows BK021
            String insertBorrow2 = "INSERT INTO BORROW (borrow_id, borrower_id, librarian_id, borrow_date, due_date, borrow_status) VALUES ('BRW-002', 'B002', 'L002', ?, ?, 'ACTIVE')";
            try (PreparedStatement ps = conn.prepareStatement(insertBorrow2)) {
                ps.setDate(1, Date.valueOf(today.minusDays(18)));
                ps.setDate(2, Date.valueOf(today.minusDays(4)));
                ps.executeUpdate();
            }
            String insertDetail2 = "INSERT INTO BORROWING_DETAIL (borrow_id, book_id, borrow_date, return_date, detail_status) VALUES ('BRW-002', 'BK021', ?, NULL, 'BORROWED')";
            try (PreparedStatement ps = conn.prepareStatement(insertDetail2)) {
                ps.setDate(1, Date.valueOf(today.minusDays(18)));
                ps.executeUpdate();
            }

            System.out.println("Mock data successfully seeded!");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
