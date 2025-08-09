package control;

public class IfTest1 {
	public static void main(String[] args) {
		int n = 4; // 주민등록번호 7번째 자리 숫자

		if (n == 1 || n == 3) {
			System.out.println("남자입니다.");
		} else if (n == 2 || n == 4) {
			System.out.println("여자입니다.");
		} else {
			System.out.println("에러입니다.");
		}
		System.out.println("종료");
	}
}
