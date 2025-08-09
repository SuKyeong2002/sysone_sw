package array;

public class ArrayTest4 {
	public static void main(String[] args) {
		int[][][]  score = {
				{
					{100, 90, 80, 70},
					{90, 80, 70, 60},
					{80, 70, 60, 50},
				},
				{
					{100, 90, 80, 70},
					{90, 80, 70, 60},
					{80, 70, 60, 50},
				}
		};
		
		for(int num = 0; num < score.length; num++) {
			System.out.println((num + 1) + "학기");
			System.out.println("국어\t영어\t수학\t철학\t총점\t평균");
			for (int row=0; row <  score[num].length; row++) {
				int sum = 0;
				for (int col = 0; col < score[num][row].length; col++) {
					System.out.print(score[num][row][col] + "\t");
					sum += score[num][row][col];
				}
				System.out.println(sum + "\t" + sum/score[num][row].length);
			}
		}
		System.out.println("종료");
	}
}
