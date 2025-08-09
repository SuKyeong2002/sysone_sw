package sec05_superkeywordsupermethod.EX01_SuperKeyword_1;

class A {
	void abc() {
		System.out.println("A 클래스의 abc()");
	}
}

class B extends A {
	void abc() {
		System.out.println("B 클래스의 abc()");
	}

	void bcd() {
		System.out.println("B 클래스의 abc()");
	}
}

public class SuperKeyword_1 {
	public static void main(String[] args) {
		B bb = new B();

		bb.abc();
	}
}
