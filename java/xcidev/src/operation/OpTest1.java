package operation;

import java.util.Scanner;

public class OpTest1 {
	public static void main(String[] args) {
		// System.in: 표준입력
		Scanner sc = new Scanner(System.in);
		System.out.print("a: ");
		int a = sc.nextInt();
		System.out.print("b: ");
		int b = sc.nextInt();
		
		System.out.println(a + "+" + b + "=" + a + b);
		System.out.println(a + "-" + b + "=" + (a - b));
		System.out.println(a + "*" + b + "=" + (a * b));
		System.out.println(a + "/" + b + "=" + (double)(a /b)); // 정수와 종수의 연산 결과는 정수
		System.out.println(a + "/" + b + "=" + (a / (double)b)); // 정수와 종수의 연산 결과는 정수
		System.out.println(a + "%" + b + "=" + (a % b));
		sc.close(); // 오토클라우즈는 나중에
		System.out.println("종료");
		
		
	}
}
