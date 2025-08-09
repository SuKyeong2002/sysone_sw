package operation;

import java.util.Scanner;

public class OpTest2 {
	public static void main(String[] args) {
		// System.in: 표준입력
		Scanner sc = new Scanner(System.in);
		System.out.print("a: ");
		int a = sc.nextInt();
		System.out.print("b: ");
		int b = sc.nextInt();
		
		// 관계 연산
		System.out.println(a > b);
		System.out.println(a >= b);
		System.out.println(a < b);
		System.out.println(a <= b);
		System.out.println(a == b);
		System.out.println(a != b);

		sc.close(); // 오토클라우즈는 나중에
		System.out.println("종료");
	}
}
