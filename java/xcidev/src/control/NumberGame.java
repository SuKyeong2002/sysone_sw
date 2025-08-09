package control;

import java.util.Scanner;

public class NumberGame {
	public static void main(String[] args) {
		int s, b; // s: 스트라이크, b: 볼
		int c1, c2, c3; // 난수 저장
		int h1, h2, h3; // 우리가 던진 수 저장
		int count = 0;
		
		c1 = (int)(Math.random() * 10);
		do {
			c2 = (int) (Math.random() * 10);
		} while (c2 == c1);
		do {
			c3 = (int) (Math.random() * 10);
		} while (c3 == c1 || c3 == c2);
		
		// 게임 시작
		Scanner sc = new Scanner(System.in);
		do {
			s = b = 0;
			System.out.print("0부터 9 사이의 중복되지 않은 숫자 3개 ex. 7 0 2 >");
			h1 = sc.nextInt();
			h2 = sc.nextInt();
			h3 = sc.nextInt();
			
			if (h1 == c1) s++;
			else if (h1 == c2 || h1 == c3) b++;
			
			if (h2 == c2) s++;
			else if (h2 == c1 || h2 == c3) b++;
			
			if (h3 == c3) s++;
			else if (h3 == c1 || h3 == c2) b++;
			
			System.out.println(s + "S" + b + "B");
			count++;
		} while (s != 3);
		
		
		System.out.printf("축하합니다! %d번 만에 맞추셨습니다.\n", count);
		sc.close();
	}
}
