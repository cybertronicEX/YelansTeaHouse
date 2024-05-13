package test;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 * Servlet implementation class Register
 */
public class RegistrationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegistrationServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String contactNumber = request.getParameter("contactNumber");
        String address = request.getParameter("address");
        String password = request.getParameter("password");

        Connection conn = SQLConnect.connect();
        try {
            // Check if user with the provided email already exists
            String checkSql = "SELECT * FROM User WHERE email=?";
            PreparedStatement checkStmt = conn.prepareStatement(checkSql);
            checkStmt.setString(1, email);
            ResultSet rs = checkStmt.executeQuery();

            if (rs.next()) {
                // User with the same email already exists
                response.setContentType("text/html");
                PrintWriter out = response.getWriter();
                out.println("<script type='text/javascript'>");
                out.println("alert('User with the same email already exists.');");
                out.println("window.location.href='register.jsp';"); // Redirect back to registration page
                out.println("</script>");
            } else {
                // Insert new user
                String sql = "INSERT INTO User (email, contactNumber, address, password) VALUES (?, ?, ?, ?)";
                PreparedStatement stmt = conn.prepareStatement(sql);
                stmt.setString(1, email);
                stmt.setString(2, contactNumber);
                stmt.setString(3, address);
                stmt.setString(4, password);
                int rowsInserted = stmt.executeUpdate();

                if (rowsInserted > 0) {
                    // Registration successful
                    response.getWriter().append("Registration success.");
                } else {
                    // Registration failed
                    response.getWriter().append("Registration failed.");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().append("Error occurred.");
        }
    }
}
