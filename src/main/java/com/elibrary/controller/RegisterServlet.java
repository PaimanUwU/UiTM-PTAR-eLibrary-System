package com.elibrary.controller;

import com.elibrary.dao.UserDAO;
import com.elibrary.model.Borrower;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.UUID;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String phone = request.getParameter("phone");
        String type = request.getParameter("type");

        // Generate custom unique ID
        String borrowerId = "B-" + UUID.randomUUID().toString().substring(0, 6).toUpperCase();

        Borrower newBorrower = new Borrower(borrowerId, name, email, password, phone, type, "ACTIVE");

        boolean success = userDAO.addBorrower(newBorrower);

        if (success) {
            request.getSession().setAttribute("message", "Registration successful! You can now login.");
            response.sendRedirect(request.getContextPath() + "/login");
        } else {
            request.setAttribute("error", "Registration failed. Email might already be registered.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
        }
    }
}
