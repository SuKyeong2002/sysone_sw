package sec03_methodoverriding.EX02_MethodOverriding_2;

class Animal {
	void cry() {
		
	}
}

class Bird extends Animal {
	@Override
	void cry() {
		System.out.println("짹짹");
	}
}

class Cat extends Animal {
	@Override
	void cry() {
		System.out.println("야옹");
	}
}

class Dog extends Animal {
	@Override
	void cry() {
		System.out.println("멍멍");
	}
}


public class MethodOverriding_2 {
	public static void main(String[] args) {
		Animal aa = new Animal();
		Bird bb = new Bird();
		Cat cc = new Cat();
		Dog dd = new Dog();
		aa.cry();
		bb.cry();
		cc.cry();
		dd.cry();
		System.out.println();
		
		Bird ab = new Bird();
		Cat ac = new Cat();
		Dog ad = new Dog();
		ab.cry();
		ac.cry();
		ad.cry();
		System.out.println();
		
		Animal[] animals = {ab, ac, ad};
		for(Animal animal : animals) {
			animal.cry();
		}
	}
}
