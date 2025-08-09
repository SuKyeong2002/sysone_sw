package sec01_accessmodifier.EX01_AccessModifierOfMember;

import sec01_accessmodifier.EX01_AccessModifierOfMember.pack1.B;
import sec01_accessmodifier.EX01_AccessModifierOfMember.pack2.C;
import sec01_accessmodifier.EX01_AccessModifierOfMember.pack2.D;
import sec02_externalclass.EX01_ExternalClass_2.pack1.A;

public class AccessModifierOfMember {
	public static void main(String[] args) {
		A a = new A();
		B b = new B();
		C c = new C();
		D d = new D();

		a.print();
		b.print();
		c.print();
		d.print();
	}
}
