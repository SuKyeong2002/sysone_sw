package sec01_lambdaexpression.EX07_RefOfInstanceMethod_Type2_2;

interface A {
	String abc(String str);
}

public class RefOfInstanceMethod_Type2_2 {
	public static void main(String[] args) {
		// 익명 이너 클래스
		A a1 = new A() {
			@Override
			public String abc(String str) {
				return str.toLowerCase();
			}
		};

		// 람다식
		A a2 = (String str) -> str.toLowerCase();

		// 직접 정의한 인스턴스 메서드 참조
		A a3 = String::toUpperCase;

		System.out.println(a1.abc("HELLO"));
		System.out.println(a2.abc("HELLO"));
		System.out.println(a3.abc("hello"));
	}
}
