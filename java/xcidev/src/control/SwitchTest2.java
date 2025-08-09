package control;

import java.util.Scanner;

public class SwitchTest2 {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		
		System.out.print("score: ");
		int score = sc.nextInt();

		switch(score/10) {
		case 10, 9: 
			System.out.println("A"); break;
		case 8: 
			System.out.println("B"); break;
		case 7: 
			System.out.println("C"); break;
		case 6: 
			System.out.println("D"); break;
		default: 
			System.out.println("F"); 
		}
		System.out.println("종료");
	}
}
