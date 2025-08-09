package jdbc1;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Scanner;

public class XCI2LoginInjectionExample {
	private static final String URL = "jdbc:oracle:thin:@localhost:1521/xepdb1";
	private static final String USER = "ace";
	private static final String PASSWORD = "ace";

	public static void main(String[] args) {

		Scanner sc = new Scanner(System.in);
		System.out.print("id : ");
		String inputUsername = sc.nextLine();
		System.out.print("pw : ");
		String inputPassword = sc.nextLine();

		String loginSQL = "SELECT NAME FROM XCI_MEMBERS " + "WHERE  USERNAME = '" + inputUsername + "' "
				+ "AND    PASSWORD = '" + inputPassword + "'";

		try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
				Statement stmt = conn.createStatement();
				ResultSet rs = stmt.executeQuery(loginSQL)) {

			if (rs.next()) {
				System.out.println("로그인 성공 : " + rs.getString("NAME"));
			} else {
				System.out.println("아이디 혹은 패스워드가 틀립니다.");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}