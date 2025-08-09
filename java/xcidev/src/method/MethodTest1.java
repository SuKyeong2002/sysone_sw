package method;

public class MethodTest1 {
	public static void main(String[] args) {
		print("신해철");
		print("서태지"); 
		print(); // overload (메소드 중복 정의)
	}
	
	private static void print() {
		System.out.println("안녕하세요");
	}
	
	private static void print(String name) { // behavior
		System.out.println("+--------+");
		System.out.println("| " + name + " |");
		System.out.println("+--------+");
	}
}
