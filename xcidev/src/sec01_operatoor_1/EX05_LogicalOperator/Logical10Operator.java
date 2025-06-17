package sec01_operatoor_1.EX05_LogicalOperator;

public class Logical10Operator {
	public static void main(String[] args) {
		// 논리 연산자
		System.out.println(true && true);
		System.out.println(true && false);
		System.out.println(true && (5 < 3));
		System.out.println((5 <= 5) && (7 > 2));
		System.out.println();
		
		System.out.println(true || true);
		System.out.println(true || false);
		System.out.println(false || (5 < 3));
		System.out.println((5 <= 5) || (7 > 2));
		System.out.println();
		
		System.out.println(true ^ true);
		System.out.println(true ^ false);
		System.out.println(false ^ (5 < 3));
		System.out.println((5 <= 5) ^ (7 > 2));
		System.out.println();
		
		System.out.println(!true);
		System.out.println(!false);
		System.out.println(false && !(5 < 3));
		System.out.println((5 <= 5) || (7 > 2));
		System.out.println();
		
		System.out.println(true & true);
		System.out.println(true & false);
		System.out.println(true | (5 < 3));
		System.out.println((5 <= 5) | (7 > 2));
		System.out.println();
		
		int value1 = 3;
		System.out.println(false && ++value1 > 6);
		System.out.println(value1);
		
		
		int value2 = 3;
		System.out.println(false & ++value2 > 6);
		System.out.println(value2);
		
		int value3 = 3;
		System.out.println(false || ++value3 > 6);
		System.out.println(value3);
		
		int value4 = 3;
		System.out.println(false | ++value4 > 6);
		System.out.println(value4);
	}
}
