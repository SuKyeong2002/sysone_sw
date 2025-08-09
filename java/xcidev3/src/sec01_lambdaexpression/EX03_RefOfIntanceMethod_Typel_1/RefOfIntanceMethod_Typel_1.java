package sec01_lambdaexpression.EX03_RefOfIntanceMethod_Typel_1;

interface A {
	void abc();
}

class B {
	void bcd() {
		System.out.println("메서드");
	}
}

public class RefOfIntanceMethod_Typel_1 {
	public static void main(String[] args) {
		// 1. 익명 이너 클래스
		A a1 = new A() {
			@Override
			public void abc() {
				B b = new B();
				b.bcd();
			}
		};

		// 2. 람다 표현식
		A a2 = () -> {
			B b = new B();
			b.bcd();
		};

		// 3. 정의된 인스턴스 메서드 참조
		B b = new B();
		A a3 = b::bcd;
		a1.abc();
		a2.abc();
		a3.abc();
	}
}
