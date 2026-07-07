package com.elibrary.controller;

import com.elibrary.dao.BorrowDAO;
import com.elibrary.model.Borrower;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet("/borrow")
public class BorrowServlet extends HttpServlet {
    private final BorrowDAO borrowDAO = new BorrowDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Borrower borrower = (Borrower) session.getAttribute("user");
        List<Map<String, Object>> loans = borrowDAO.getBorrowerActiveLoans(borrower.getBorrower_id());
        request.setAttribute("loans", loans);
        request.getRequestDispatcher("/borrow.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Borrower borrower = (Borrower) session.getAttribute("user");
        String action = request.getParameter("action");

        if ("request".equalsIgnoreCase(action)) {
            String bookId = request.getParameter("bookId");
            boolean success = borrowDAO.createBorrow(borrower.getBorrower_id(), bookId);
            if (success) {
                session.setAttribute("message", "Book successfully borrowed!");
            } else {
                session.setAttribute("error", "Failed to borrow book. It might be already borrowed.");
            }
        }
        response.sendRedirect(request.getContextPath() + "/borrow");
    }
}
