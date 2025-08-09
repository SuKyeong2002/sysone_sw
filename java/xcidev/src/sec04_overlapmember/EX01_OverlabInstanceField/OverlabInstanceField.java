package sec04_overlapmember.EX01_OverlabInstanceField;

class A {
	int m = 3;
}

class B extends A{
	int m = 4;
}

public class OverlabInstanceField {
	public static void main(String[] args) {
		A aa = new A();
		B bb = new B();
		A ab = new B();
		
		System.out.println(aa.m);
		System.out.println(bb.m);
		System.out.println(ab.m);
	}
}
