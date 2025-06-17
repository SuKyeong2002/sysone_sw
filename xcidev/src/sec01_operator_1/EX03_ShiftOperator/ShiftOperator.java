package sec01_operator_1.EX03_ShiftOperator;

public class ShiftOperator {
	public static void main(String[] args) {
		System.out.println(3 << 1);
		System.out.println(-3 << 1);
		System.out.println(3 << 2);
		System.out.println(-3 << 1);
		System.out.println();
		
		System.out.println(5 >> 1);
		System.out.println(-5 >> 1);
		System.out.println(5 >> 2);
		System.out.println(-5 >> 2);
		System.out.println();
		
		System.out.println(3 >>> 1);
		System.out.println(-3 >>> 31);
		System.out.println();
	}
}
