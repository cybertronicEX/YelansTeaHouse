package test;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 * Servlet implementation class UserSearchServlet
 */
public class UserSearchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserSearchServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve search query from request parameter
        String query = request.getParameter("query");

        // Retrieve user data from the database based on the search query
        List<User> userList = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = SQLConnect.connect();
            String sql = "SELECT * FROM user WHERE email LIKE ? OR contactNumber LIKE ? OR address LIKE ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, "%" + query + "%");
            stmt.setString(2, "%" + query + "%");
            stmt.setString(3, "%" + query + "%");
            rs = stmt.executeQuery();

            // Populate userList with user data from the result set
            while (rs.next()) {
                User user = new User();
                user.setEmail(rs.getString("email"));
                user.setContactNumber(rs.getString("contactNumber"));
                user.setAddress(rs.getString("address"));
                user.setPassword(rs.getString("password"));
                userList.add(user);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // Close resources
            SQLConnect.close(rs, stmt, conn);
        }

        // Debugging: Print out the retrieved user list
        System.out.println("Retrieved user list: " + userList);
        // Set userList as an attribute in the request
        request.setAttribute("userList", userList);

        // Forward the request to the users.jsp page for display
        request.getRequestDispatcher("users.jsp").forward(request, response);
    }


}
