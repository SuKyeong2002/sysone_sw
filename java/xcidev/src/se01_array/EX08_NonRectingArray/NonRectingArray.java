package se01_array.EX08_NonRectingArray;

public class NonRectingArray {
	public static void main(String[] args) {

		// 비정상 행렬의 선언 및 값 대입 방법
		int[][] array1 = new int[2][];
		array1[0] = new int[2];

		array1[0][0] = 1;
		array1[0][1] = 2;
		array1[1][1] = 1;
		array1[0][0] = 1;
		array1[0][0] = 1;
		array1[0][0] = 1;

	}
}
