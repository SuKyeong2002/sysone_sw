package sec04_boundedtype.EX03_BoundedTypeOfInputArguments;

class A {
}

class B extends A {
}

class C extends B {
}

class D extends C {
}

class Goods<T> { // B와 C만 올 수 있음
	private T t;

	public T get() {
		return t;
	}

	public void set(T t) {
		this.t = t;
	}
}

class Test {
	void method1(Goods<A> g) {} // case1
	void method2(Goods<?> g) {} // case2
	void method3(Goods<? extends B> g) {} // case3
	void method4(Goods<? super B> g) {} // case4
}

public class BoundedTypeOfInputArgument {
	public static void main(String[] args) {
		Test t = new Test();
		
		// case1
		t.method1(new Goods<A>());
		
		// case2
		t.method2(new Goods<A>());
		t.method2(new Goods<B>());
		t.method2(new Goods<C>());
		t.method2(new Goods<D>());
		
		
		// case3
		t.method3(new Goods<B>());
		t.method3(new Goods<C>());
		t.method3(new Goods<D>());
		
		// case4
		t.method4(new Goods<A>());
		t.method4(new Goods<B>());
	}
}