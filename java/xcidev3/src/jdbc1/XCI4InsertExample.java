package jdbc1;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Scanner;

public class XCI4InsertExample {
	private static final String URL = "jdbc:oracle:thin:@localhost:1521/xepdb1";
	private static final String USER = "ace";
	private static final String PASSWORD = "ace";

	public static void main(String[] args) throws SQLException {
		Scanner sc = new Scanner(System.in);
		
		try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD)) {
		
		// 사원 정보 입력 받기
		System.out.print("LAST_NAME 을 입력해주세요 > ");
		String lastName = sc.next();
		System.out.print("SALARY 를 입력해주세요 > ");
		int salary = sc.nextInt();
		System.out.print("JOB_ID 를 입력해주세요 > ");
		String jobId = sc.next();
		System.out.print("COMMISSION_PCT 를 입력해주세요 > ");
		double commissionPt = sc.nextDouble();
		System.out.print("DEPARTMENT_ID 를 입력해주세요 > ");
		int departmentId = sc.nextInt();
		
		// 부사 유효성 검사
		String checkDeptSQL = "SELECT COUNT(*) FROM DEPARTMENTS WHERE DEPARTMENT_ID=? ";
		try (PreparedStatement checkStmt = conn.prepareStatement(checkDeptSQL)) {
			checkStmt.setInt(1, departmentId); // 바인딩 추가
			ResultSet rs = checkStmt.executeQuery();
			rs.next();
			int count = rs.getInt(1);
			if(count == 0) {
				System.out.println("잘못된 부서번호입니다.");
				return;
			} 
		}
		
		// 삽입 
		String insertSQL = """
				INSERT INTO EMP_TEMP (LAST_NAME, SALARY, JOB_ID, COMMISSION_PCT, DEPARTMENT_ID)
				VALUES (?, ?, ?, ?, ?)
				""";		
		
		try (PreparedStatement pstmt = conn.prepareStatement(insertSQL)) {
			
			pstmt.setString(1, lastName);
			pstmt.setInt(2, salary);
			pstmt.setString(3, jobId);
			pstmt.setDouble(4, commissionPt);
			pstmt.setInt(5, departmentId);

			int rowsInserted = pstmt.executeUpdate();
			if (rowsInserted > 0) {
				System.out.println("사원이 성공적으로 입력되었습니다!");
			} else {
				System.out.println("입력 실패!");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
}