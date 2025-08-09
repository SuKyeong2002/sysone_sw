package control;

public class DoWhileTest1 {
	public static void main(String[] args) {

		int i = 1;
		do {
			System.out.println("Sysone");
			i++;
		} while (i <= 3);
		
		System.out.println();
		
		int j = 1;
		int sum = 0;
		do {
			if (j % 4 == 0) sum += j;
			j++;
		} while (j <= 1000);
		System.out.println("1~1000까지 4의 배수의 합계: " + sum);
		
		System.out.println("종료");
	}
}
