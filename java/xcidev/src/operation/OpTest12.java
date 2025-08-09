package operation;

import java.util.Scanner;

public class OpTest12 {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		
		System.out.print("정수를 입력해주세요: ");
		int a = sc.nextInt();
		
		// 나머지 연산 주의 !!! 음수값을 나머지 적용 시 반드시 절대값을 먼저 취해야 함
		System.out.println(a + "은(는)" + (a % 2 == 0 ? "짝수" : "홀수") + "입니다.");
		
	}
}
