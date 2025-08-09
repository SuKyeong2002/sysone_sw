package operation;

public class OpTest3 {
	public static void main(String[] args) {
		boolean b1 = false, b2 = false;
		
		// 논리 연산
		System.out.println(b1 && b2);
		System.out.println(b1 || b2);
		System.out.println(!b1);
		
		// 비트 연산
		int n1 = 5, n2 = 3;
		System.out.println(n1 & n2);
		System.out.println(n1 | n2);
		
		// 치환
		/*
		int temp = n1;
		n1 = n2;
		n2 = temp;
		*/
		
		n1 = n1 ^ n2;
		n2 = n2 ^ n1;
		n1 = n1 ^ n2;
		System.out.println(n1 + "," + n2);
		
		System.out.println("종료");
	}
}
