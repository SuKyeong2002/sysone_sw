package sec02_method.EX03_ArrayArgumrntMethod;

import java.util.Arrays;

public class ArrayArgumrntMethod {
	public static void main(String[] args) {
		int[] a = new int[] {1, 2, 3};
		printArray(a);
		printArray(new int[] {1, 2, 3});
	}
	
	public static void printArray(int[] a) {
		System.out.println(Arrays.toString(a));
	}
}
