package jdbc1;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Scanner;

public class XCI2LoginInjectionExample2 {
	private static final String URL = "jdbc:oracle:thin:@localhost:1521/xepdb1";
	private static final String USER = "ace";
	private static final String PASSWORD = "ace";

	public static void main(String[] args) {

		Scanner sc = new Scanner(System.in);
		System.out.print("id : ");
		String inputUsername = sc.nextLine();
		System.out.print("pw : ");
		String inputPassword = sc.nextLine();

		// ? : 바인딩 변수로 처리
		String loginSQL = "SELECT NAME FROM XCI_MEMBERS " + "WHERE  USERNAME = ? " + "AND    PASSWORD = ? ";

		// Statement -> PreparedStatement
		try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
				PreparedStatement stmt = conn.prepareStatement(loginSQL)) {
			stmt.setString(1, inputUsername);
			stmt.setString(2, inputPassword);

			try (ResultSet rs = stmt.executeQuery()) {
				if (rs.next()) {
					System.out.println("로그인 성공 : " + rs.getString("NAME"));
				} else {
					System.out.println("아이디 혹은 패스워드가 틀립니다.");
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}