package sec01_lambdaexpression.EX01_OOPvsFP;

interface A {
	void abc();
}

class B implements A {
	@Override
	public void abc() {
		System.out.println("메서드 내용 1");
	}
}

class OOPvsFP {
	public static void main(String[] args) {

		// 객체 지향 프로그래밍 문법 1
		A a1 = new B();

		// 메서드 내용
		a1.abc();

		// 객체 지향 프로그래밍 문법 2
		A a2 = new A() {
			@Override
			public void abc() {
				System.out.println("메서드 내용 2");
			}
		};

		// 메서드 내용
		a2.abc();

		// 객체 지향 프로그래밍 문법 3
		A a3 = () -> {
			System.out.println("메서드 내용 3");
		};

		// 메서드 내용
		a3.abc();
	}
}
