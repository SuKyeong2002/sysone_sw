package sec03_localinnerclass.EX01_AccessMemberAndLocalVariable;


class A {
	int a = 3;
	void abc() {
		int b = 5;
		
		class B {
			void bcd() {
				System.out.println(a);
				System.out.println(b);
				a = 5;
			}
		}
		
		B bb = new B ();
		bb.bcd();
	}
}

public class AccessMemberAndLocalVariable {
	public static void main(String[] args) {
		A a = new A ();
		a.abc();
	}
}
