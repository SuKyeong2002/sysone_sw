package method;

public class MethodTest4 {
	public static void main(String[] args) {
		// 가변형 아규먼트를 이용한 오버로딩
		prn(1);
		prn(2, 3);
	}

	private static void prn(int ... n) { 
		
		
		for (int i:n) {
			System.out.print(i + "\t");
		}
		System.out.println();
	}
}