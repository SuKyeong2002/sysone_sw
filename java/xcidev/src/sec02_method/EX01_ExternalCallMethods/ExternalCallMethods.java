package sec02_method.EX01_ExternalCallMethods;

class A{
	void print() {
		System.out.println("안녕");
	}

	int data() {
		return 3;
	}

	double sum(int m, double n) {
		return m + n;
	}
	
	void printMonth(int m) {
		if (m < 0 || m > 12) {
			System.out.println("잘못된 입력");
			return;
		} 
		System.out.println(m + "월입니다.");
	}
}

public class ExternalCallMethods {
	public static void main(String[] args) {
		A a = new A();
		a.print();
		int k = a.data();
		a.data();
		System.out.println(k);
		double result = a.sum(3, 5.2);
		System.out.println(result);
		a.printMonth(5);
		a.printMonth(15);
		
	}
}
