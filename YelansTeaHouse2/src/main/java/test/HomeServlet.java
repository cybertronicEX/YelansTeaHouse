package test;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

public class HomeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public HomeServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve session
        HttpSession session = request.getSession(false);

        // Check if session exists and user is logged in
        if (session != null && session.getAttribute("id") != null) {
            // Forward to session details JSP
            request.getRequestDispatcher("sessionDetails.jsp").forward(request, response);
        } else {
            // If session doesn't exist or user is not logged in, redirect to login page
            response.sendRedirect("login.jsp");
        }
    }

}
