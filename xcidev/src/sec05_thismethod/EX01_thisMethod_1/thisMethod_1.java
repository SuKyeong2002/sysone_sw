package sec05_thismethod.EX01_thisMethod_1;

class A {
	A() {
		System.out.println("첫 번째 생성자");
	}
	
	A(int a) {
		this();
		System.out.println("두 번째 생성자");
	}
}

public class thisMethod_1 {
	public static void main(String[] args) {
		A a1 = new A();
		System.out.println();
		A a2 = new A(3);
	}
}
