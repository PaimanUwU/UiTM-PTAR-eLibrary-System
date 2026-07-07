package com.elibrary.controller;

import com.elibrary.dao.BookDAO;
import com.elibrary.dao.BorrowDAO;
import com.elibrary.model.Book;
import com.elibrary.model.EBook;
import com.elibrary.model.Librarian;
import com.elibrary.model.PhysicalBook;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet(urlPatterns = {"/admin/panel", "/admin/books", "/admin/borrowed", "/admin/late"})
public class AdminServlet extends HttpServlet {
    private final BookDAO bookDAO = new BookDAO();
    private final BorrowDAO borrowDAO = new BorrowDAO();

    private boolean isNotAdmin(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        return session == null || session.getAttribute("admin") == null;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (isNotAdmin(request)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String path = request.getServletPath();

        if ("/admin/panel".equals(path)) {
            // Dashboard overview
            List<Book> books = bookDAO.getAllBooks();
            List<Map<String, Object>> loans = borrowDAO.getAllLoans();
            List<Map<String, Object>> late = borrowDAO.getOverdueLoans();

            request.setAttribute("totalBooks", books.size());
            request.setAttribute("totalLoans", loans.size());
            request.setAttribute("totalLate", late.size());

            request.getRequestDispatcher("/admin-panel.jsp").forward(request, response);
        } else if ("/admin/books".equals(path)) {
            String action = request.getParameter("action");
            if (action == null) {
                action = "list";
            }

            if ("add".equalsIgnoreCase(action)) {
                request.getRequestDispatcher("/admin-add-book.jsp").forward(request, response);
            } else if ("edit".equalsIgnoreCase(action)) {
                String id = request.getParameter("id");
                Book book = bookDAO.getBookById(id);
                request.setAttribute("book", book);
                request.getRequestDispatcher("/admin-edit-book.jsp").forward(request, response);
            } else if ("delete".equalsIgnoreCase(action)) {
                String id = request.getParameter("id");
                bookDAO.deleteBook(id);
                response.sendRedirect(request.getContextPath() + "/admin/books");
            } else {
                // List
                String search = request.getParameter("search");
                List<Book> books;
                if (search != null && !search.trim().isEmpty()) {
                    books = bookDAO.searchBooks(search);
                } else {
                    books = bookDAO.getAllBooks();
                }
                request.setAttribute("books", books);
                request.getRequestDispatcher("/admin-book-list.jsp").forward(request, response);
            }
        } else if ("/admin/borrowed".equals(path)) {
            List<Map<String, Object>> loans = borrowDAO.getAllLoans();
            request.setAttribute("loans", loans);
            request.getRequestDispatcher("/admin-borrowed.jsp").forward(request, response);
        } else if ("/admin/late".equals(path)) {
            List<Map<String, Object>> late = borrowDAO.getOverdueLoans();
            request.setAttribute("late", late);
            request.getRequestDispatcher("/admin-late.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (isNotAdmin(request)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String path = request.getServletPath();
        HttpSession session = request.getSession(false);
        Librarian currentLib = (Librarian) session.getAttribute("admin");

        if ("/admin/books".equals(path)) {
            String action = request.getParameter("action");
            if ("add".equalsIgnoreCase(action) || "edit".equalsIgnoreCase(action)) {
                String bookId = request.getParameter("book_id");
                String title = request.getParameter("book_title");
                String author = request.getParameter("author_name");
                String publisher = request.getParameter("publisher");
                String publishYear = request.getParameter("publish_year");
                String isbn = request.getParameter("ISBN");
                String status = request.getParameter("book_status");
                String type = request.getParameter("book_type");

                Book book;
                if ("E-BOOK".equalsIgnoreCase(type)) {
                    String fileSize = request.getParameter("file_size");
                    String accessLink = request.getParameter("access_link");
                    book = new EBook(bookId, currentLib.getLibrarian_id(), title, author, publisher, publishYear, isbn, status, type, fileSize, accessLink);
                } else {
                    String shelfLocation = request.getParameter("shelf_location");
                    String accessionNo = request.getParameter("accession_no");
                    int copyNumber = Integer.parseInt(request.getParameter("copy_number"));
                    String conditionStatus = request.getParameter("condition_status");
                    book = new PhysicalBook(bookId, currentLib.getLibrarian_id(), title, author, publisher, publishYear, isbn, status, type, shelfLocation, accessionNo, copyNumber, conditionStatus);
                }

                boolean success;
                if ("add".equalsIgnoreCase(action)) {
                    success = bookDAO.addBook(book);
                } else {
                    success = bookDAO.updateBook(book);
                }

                if (success) {
                    session.setAttribute("message", "Book successfully " + ("add".equalsIgnoreCase(action) ? "added" : "updated") + "!");
                } else {
                    session.setAttribute("error", "Database operation failed. Ensure book ID is unique.");
                }
                response.sendRedirect(request.getContextPath() + "/admin/books");
            }
        } else if ("/admin/borrowed".equals(path)) {
            String action = request.getParameter("action");
            if ("return".equalsIgnoreCase(action)) {
                String borrowId = request.getParameter("borrowId");
                String bookId = request.getParameter("bookId");
                boolean success = borrowDAO.returnBook(borrowId, bookId);
                if (success) {
                    session.setAttribute("message", "Book successfully returned!");
                } else {
                    session.setAttribute("error", "Return processing failed.");
                }
            }
            response.sendRedirect(request.getContextPath() + "/admin/borrowed");
        }
    }
}
