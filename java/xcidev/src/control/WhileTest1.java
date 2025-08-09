package control;

public class WhileTest1 {
	public static void main(String[] args) {
		int n = 1;
		while (n <= 1000) {
			System.out.println(n + "0: sysone");
			n*=3;
		}
		
		System.out.println();
		
//		for (int n = 10; n <= 30; n+=10) {
//			System.out.println(n + ": sysone");
//		}
//		
		System.out.println("종료");
	}
}