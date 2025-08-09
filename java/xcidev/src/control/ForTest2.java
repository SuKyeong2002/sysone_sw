package control;

public class ForTest2 {
	public static void main(String[] args) {
		int sum = 0;
		for (int n = 1; n <= 1000; n++) {
			if (n % 3 == 0) sum += n;
		}
		System.out.println("1~1000 3의 배수의 sum: " + sum);
		
		System.out.println();
		
		// 이 방법이 성능 좋음 
		int sum2 = 0;
		for (int n = 3; n <= 1000; n+=3) {
			if (n % 3 == 0) sum2 += n;
		}
		System.out.println("1~1000 3의 배수의 sum: " + sum2);
		
		System.out.println();
		System.out.println("종료");
	}
}