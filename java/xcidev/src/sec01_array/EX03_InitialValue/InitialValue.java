package sec01_array.EX03_InitialValue;

public class InitialValue {
	public static void main(String[] args) {
		// 스택 메모리값 (강제 초기화 X)
		int value1;
		
		int[] value2;
		
		int value3 = 0;
		System.out.println(value3); // 0 으로 초기화 
		int[] value4 = null;
		System.out.println(value4); // null 로 초기화
		System.out.println();
		
		// 힙 메모리의 초깃값 (강제 초기화)
		boolean[] array1 = new boolean[3]; // false로 초기화 
		for (int i = 0; i < 3; i++) {
			System.out.print(array1[i] + " ");
		}
		System.out.println();
		
		
	}
}
