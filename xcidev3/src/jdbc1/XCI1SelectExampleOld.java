package jdbc1;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class XCI1SelectExampleOld {
	private static final String URL = "jdbc:oracle:thin:@localhost:1521/xepdb1";
	private static final String USER = "ace";
	private static final String PASSWORD = "ace";

	public static void main(String[] args) {
		String selectSQL = """
				SELECT
				    username,
				    password,
				    email,
				    birth,
				    join_date
				FROM
				    xci_members
				""";
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;

		try {
			conn = DriverManager.getConnection(URL, USER, PASSWORD);
//conn.setAutoCommit(false); // default: true
			stmt = conn.createStatement();
			rs = stmt.executeQuery(selectSQL); // 1. .execute(), 2. executeQuery(), 3. executeUpdate()
			while (rs.next()) {
				String username = rs.getString("USERNAME");
				String password = rs.getString("PASSWORD");
				String maskedPassword = "*".repeat(password.length()); // Password masking
				String email = rs.getString("EMAIL");
				int birth = rs.getInt("BIRTH");
				Date joinDate = rs.getDate("JOIN_DATE");
				System.out.println("Username: " + username + ", Password: " + maskedPassword + ", Email: " + email
						+ ", Birth: " + birth + ", Join Date: " + joinDate);
			}
//conn.commit();
		} catch (SQLException e) {
			System.out.println(e.getMessage());
//try {conn.rollback();} catch (SQLException e1) {}
		} finally {
//try {conn.setAutoCommit(true);} catch (SQLException e) {}

			if (rs != null)
				try {
					rs.close();
				} catch (Exception e) {
				}
			if (stmt != null)
				try {
					stmt.close();
				} catch (Exception e) {
				}
			if (conn != null)
				try {
					conn.close();
				} catch (Exception e) {
				}
		}
	}
}