	package test;
	
	import java.io.IOException;
	import java.sql.Connection;
	import java.sql.PreparedStatement;
	import java.sql.ResultSet;
	
	import jakarta.servlet.ServletException;
	import jakarta.servlet.http.HttpServlet;
	import jakarta.servlet.http.HttpServletRequest;
	import jakarta.servlet.http.HttpServletResponse;
	import jakarta.servlet.http.HttpSession;
	
	public class LoginServlet extends HttpServlet {
		private static final long serialVersionUID = 1L;
	
		public LoginServlet() {
			super();
		}
	
		protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			String email = request.getParameter("email");
			String password = request.getParameter("password");
	
			Connection conn = SQLConnect.connect();
			try {
				String sql = "SELECT * FROM User WHERE email = ? AND password = ?";
				PreparedStatement stmt = conn.prepareStatement(sql);
				stmt.setString(1, email);
				stmt.setString(2, password);
				ResultSet rs = stmt.executeQuery();
	
				if (rs.next()) {
					// Login successful
					HttpSession session = request.getSession();
	                session.setAttribute("id", rs.getInt("id"));
	                session.setAttribute("email", rs.getString("email"));
	                response.sendRedirect("home.jsp");
	                } else {
					// Login failed
	                	 request.setAttribute("errorMessage", "Login failed.");
	                     // Forward the request to the login page
	                     request.getRequestDispatcher("login.jsp").forward(request, response);
					
				}
			} catch (Exception e) {
				e.printStackTrace();
				response.getWriter().append("Error occurred.");
			}
		}
	}
