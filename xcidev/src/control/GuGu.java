package control;

public class GuGu {
	public static void main(String[] args) {
		for (int i = 2; i <= 9; i = i + 4) {
			for (int j = 1; j <= 9; j++) {
				for (int k = i; k < i + 4; k++) {
					System.out.print(k + "x" + j + "=" + (k * j) + "\t");
				}
				System.out.println();
			}
			System.out.println();
		}

		System.out.println("=== while문으로 구구단 짜기 ===");

		int i = 2;
		while (i <= 9) {
			int j = 1;
			while (j <= 9) {
				int k = i;
				while (k < i + 4) {
					System.out.print(k + "x" + j + "=" + (k * j) + "\t");
					k++;
				}
				System.out.println();
				j++;
			}
			System.out.println();
			i++;
		}
	}
}
