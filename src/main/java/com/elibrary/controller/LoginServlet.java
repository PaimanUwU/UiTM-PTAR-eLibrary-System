package com.elibrary.controller;

import com.elibrary.dao.UserDAO;
import com.elibrary.model.Borrower;
import com.elibrary.model.Librarian;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String role = request.getParameter("role");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        HttpSession session = request.getSession();

        if ("librarian".equalsIgnoreCase(role)) {
            Librarian librarian = userDAO.authenticateLibrarian(email, password);
            if (librarian != null) {
                session.setAttribute("admin", librarian);
                response.sendRedirect(request.getContextPath() + "/admin/books?action=list");
            } else {
                request.setAttribute("error", "Invalid Librarian Credentials");
                request.getRequestDispatcher("/login.jsp").forward(request, response);
            }
        } else {
            Borrower borrower = userDAO.authenticateBorrower(email, password);
            if (borrower != null) {
                session.setAttribute("user", borrower);
                response.sendRedirect(request.getContextPath() + "/books?action=list");
            } else {
                request.setAttribute("error", "Invalid Borrower Credentials");
                request.getRequestDispatcher("/login.jsp").forward(request, response);
            }
        }
    }
}
