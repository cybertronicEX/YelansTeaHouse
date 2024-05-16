package test;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 * Servlet implementation class UpdateUserServlet
 */
public class UpdateUserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public UpdateUserServlet() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve user details from the form
        String email = request.getParameter("email");
        String contactNumber = request.getParameter("contactNumber");
        String address = request.getParameter("address");
        String password = request.getParameter("password");

        // Perform validation if needed

        boolean updated = false;
        try {
            Connection conn = SQLConnect.connect();
            String query = "UPDATE user SET contactNumber=?, address=?, password=? WHERE email=?";
            PreparedStatement statement = conn.prepareStatement(query);
            statement.setString(1, contactNumber);
            statement.setString(2, address);
            statement.setString(3, password);
            statement.setString(4, email);

            // Debugging: Print the SQL query and parameters
            System.out.println("Executing query: " + query);
            System.out.println("With parameters: ");
            System.out.println("1: " + contactNumber);
            System.out.println("2: " + address);
            System.out.println("3: " + password);
            System.out.println("4: " + email);

            int rowsAffected = statement.executeUpdate();
            System.out.println("Rows affected: " + rowsAffected);
            updated = rowsAffected > 0;
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle database errors
        }

        // Send a response to the client with JavaScript to display an alert and redirect
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        out.println("<script type=\"text/javascript\">");
        if (updated) {
            out.println("alert('User updated successfully');");
            out.println("window.location.href='UserServlet';");
        } else {
            out.println("alert('Failed to update user');");
            out.println("window.location.href='UserServlet';");
        }
        out.println("</script>");
    }
}
