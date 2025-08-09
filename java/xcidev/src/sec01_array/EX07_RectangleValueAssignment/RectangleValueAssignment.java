package sec01_array.EX07_RectangleValueAssignment;

public class RectangleValueAssignment {
	public static void main(String[] args) {
		// 배열 객체의 생성 및 원소 값 대입 
		int [][] array1 = new int[2][3];
		array1[0][0] = 1;
		array1[0][1] = 2;
		array1[0][2] = 3;
		array1[1][0] = 4;
		array1[1][1] = 5;
		array1[1][2] = 6;
		
		System.out.println(array1[0][0] + " " + array1[0][1] + " " + array1[0][2] + " ");
		System.out.println(array1[1][0] + " " + array1[1][1] + " " + array1[1][2] + " ");
		System.out.println();
		
		int [][] array2;
		array2 = new int[2][3];
		array2[0][0] = 1;
		array2[0][1] = 2;
		array2[0][2] = 3;
		array2[1][0] = 4;
		array2[1][1] = 5;
		array2[1][2] = 6;
		
		System.out.println(array2[0][0] + " " + array2[0][1] + " " + array2[0][2] + " ");
		System.out.println(array2[1][0] + " " + array2[1][1] + " " + array2[1][2] + " ");
		System.out.println();
		
		int [][] arrayy3 = new int[][] {{1, 2, 3}, {4, 5, 6}};
		
		System.out.println(arrayy3[0][0] + " " + arrayy3[0][1] + " " + arrayy3[0][2] + " ");
		System.out.println(arrayy3[1][0] + " " + arrayy3[1][1] + " " + arrayy3[1][2] + " ");
		System.out.println();
		
		
		int [][] array5= {{1, 2, 3}, {4, 5, 6}};
		
		System.out.println(array5[0][0] + " " + array5[0][1] + " " + array5[0][2] + " ");
		System.out.println(array5[1][0] + " " + array5[1][1] + " " + array5[1][2] + " ");
		System.out.println();
	}
}
