package edu.mum.cs.cs472.controller;

import edu.mum.cs.cs472.dao.User;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "HomeServlet", urlPatterns = "/home", description = "HomeServlet")
public class HomeServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("loggedUser") != null) {
            RequestDispatcher rd = request.getRequestDispatcher("/home.jsp");
            User user = (User) session.getAttribute("loggedUser");

            request.setAttribute("email", user.getEmail());
            rd.forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/login");
        }
    }
}
