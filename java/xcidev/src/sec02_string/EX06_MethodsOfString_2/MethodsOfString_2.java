package sec02_string.EX06_MethodsOfString_2;

import java.util.Arrays;

public class MethodsOfString_2 {
	public static void main(String[] args) {
		String str1 = "Java Study";
		System.out.println(str1.toLowerCase());
		System.out.println(str1.toUpperCase());
		
		System.out.println(str1.replace("Study", "공부"));
		System.out.println(str1.substring(0, 5));
		
		
		String[] strArray = "abc/def=ghi jkl".split("/|-| ");
				System.out.println(Arrays.toString(strArray));
		
		System.out.println("     abc     ".trim());
		
		System.out.println();
		
		
		String str2 = new String("Java");
		String str3 = new String("Java");
		String str4 = new String("java");
		
		System.out.println(str2 == str3);
		System.out.println(str3 == str4);
		System.out.println(str4 == str2);
		
		System.out.println(str2.equals(str3));
		System.out.println(str3.equals(str4));
		System.out.println(str3.equalsIgnoreCase(str4));
		
	}
}
