package method;

import java.util.Scanner;

public class ScissorsGame {
	public static void main(String[] args) {
//		String[] caption = {"가위", "바위", "보"};
		
		try (Scanner sc = new Scanner(System.in)) {
			System.out.print("가위는 1, 바위는 2, 보는 3을 입력 > ");
			int you = sc.nextInt();
			int com = (int) (Math.random() * 3) + 1;
			
			System.out.println("You : " + caption(you));
			System.out.println("Com : " + caption(com));
			
			if (caption(you).equals(caption(com))) {
				System.out.println("무승부");
			} 
			
//			System.out.print("You : "); printCaption(you);
//			System.out.print("Com : ");printCaption(com);
		};
	}

	private static void printCaption(int val) {
		switch(val) {
		case 1: System.out.println("가위"); break;
		case 2: System.out.println("바위"); break;
		case 3: System.out.println("보"); break;
		default : System.out.println("에러"); break;
		}
	}

	// 선호됨: 좀더 모듈화 가능해서
	private static String caption(int val) {
		switch(val) {
		case 1: return "가위";
		case 2: return "바위";
		case 3: return "보";
		default : return "에러";
		}
	}
} 
