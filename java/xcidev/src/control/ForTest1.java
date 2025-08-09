package control;

public class ForTest1 {
	public static void main(String[] args) {
		for (int n = 1; n <= 3; n++) {
			System.out.println(n*10 + ": sysone");
		}
		
		System.out.println();
		
		for (int n = 10; n <= 30; n+=10) {
			System.out.println(n + ": sysone");
		}
		
		System.out.println("종료");
	}
}