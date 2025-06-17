package stringclass;

public class StringTest1 {
	public static void main(String[] args) {
		System.out.println("Hello World");
		
		// String 객체를 생성하는 2가지 방법
		// 우측 먼저 실행 
		String str = new String("안녕");
		System.out.println(str);
		
		String str2 = "";
		for (int i = 1; i <= 3; i++ ) {
			str2 += "ABC";
		}
		System.out.println(str2);
	}
}
