package jdbc1;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class XCI4InsertExample2 {
	private static final String URL = "jdbc:oracle:thin:@localhost:1521/xepdb1";
	private static final String USER = "ace";
	private static final String PASSWORD = "ace";

	public static void main(String[] args) {
		String insertSQL = """
				INSERT INTO XCI_MEMBERS (USERNAME, PASSWORD, NAME, EMAIL, BIRTH, JOIN_DATE)
				VALUES (?, ?, ?, ?, ?, ?)
				""";
		try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
				PreparedStatement pstmt = conn.prepareStatement(insertSQL)) {

			pstmt.setString(1, "iu");
			pstmt.setString(2, "iu");
			pstmt.setString(3, "이지은");
			pstmt.setString(4, "iu@ive.com");
			pstmt.setInt(5, 1993);
			pstmt.setDate(6, java.sql.Date.valueOf("2024-07-07"));

			int rowsInserted = pstmt.executeUpdate();
			if (rowsInserted > 0) {
				System.out.println("입력 되었습니다!");
			} else {
				System.out.println("입력된 행이 없습니다.");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}