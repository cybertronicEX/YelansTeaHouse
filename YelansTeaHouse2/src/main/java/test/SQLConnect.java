package test;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class SQLConnect {
	private static Connection conn = null;
	private static String database = "yelan";
	
	public static Connection connect() {
		try {
			String connURL = "jdbc:mysql://localhost:3306/" + database;
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(connURL,"root","");
			return conn;
		}catch(Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	public static void close(ResultSet rs, PreparedStatement stmt, Connection conn) {
        try {
            if (rs != null) {
                rs.close();
            }
            if (stmt != null) {
                stmt.close();
            }
            if (conn != null) {
                conn.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
