package sec02_string.EX04_PlusOperationOfString;

public class PlusOperationOfString {
	public static void main(String[] args) {
		String str1 = "안녕" + "하세요" + "!";
		System.out.println(str1);
		
		String str2 = "반갑";
		str2 += "습니다";
		str2 += "!";
		System.out.println(str2);
		System.out.println();
		
		String str3 = "안녕" + 1;
		String str4 = "안녕" + String.valueOf(1);
		String str5 = "안녕" + "1";
		
		System.out.println(str3);
		System.out.println(str4);
		System.out.println(str5);
		System.out.println();
		
		System.out.println(1 + "안녕");
		System.out.println(1 + "안녕" + 2);
		System.out.println("안녕" + 1 + 2);
		System.out.println(1 + 2 + "안녕");
		
	}
}
