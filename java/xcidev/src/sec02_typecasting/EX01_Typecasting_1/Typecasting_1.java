package sec02_typecasting.EX01_Typecasting_1;

class A {}
class B extends A {}
class C extends B {}
class D extends C {}

public class Typecasting_1 {
		public static void main(String[] args) {
			A ac = (A) new C();
			B bc = (B) new C();
			
			B bb = new B ();
			A a = (A) bb;
			
			A ab = new B();
			B b = (B) ab;
			
			B bd = new D();
			D d = (D) bd;
			
			A ad = new D();
			B b1 = (B) ad;
			D d1 = (D) ad;
		}
}
