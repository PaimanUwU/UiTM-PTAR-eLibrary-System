package com.elibrary.controller;

import com.elibrary.dao.BookDAO;
import com.elibrary.model.Book;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/books")
public class BookServlet extends HttpServlet {
    private final BookDAO bookDAO = new BookDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        HttpSession session = request.getSession(false);
        boolean isLoggedIn = (session != null && session.getAttribute("user") != null);

        if ("info".equalsIgnoreCase(action)) {
            String bookId = request.getParameter("id");
            Book book = bookDAO.getBookById(bookId);
            request.setAttribute("book", book);
            if (isLoggedIn) {
                request.getRequestDispatcher("/bookinfo.jsp").forward(request, response);
            } else {
                request.getRequestDispatcher("/bookinfo-not-log.jsp").forward(request, response);
            }
        } else {
            String search = request.getParameter("search");
            List<Book> books;
            if (search != null && !search.trim().isEmpty()) {
                books = bookDAO.searchBooks(search);
            } else {
                books = bookDAO.getAllBooks();
            }
            request.setAttribute("books", books);
            if (isLoggedIn) {
                request.getRequestDispatcher("/page-browse.jsp").forward(request, response);
            } else {
                request.getRequestDispatcher("/page-browse-not-log.jsp").forward(request, response);
            }
        }
    }
}
