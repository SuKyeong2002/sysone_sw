package control;

public class Star {
	public static void main(String[] args) {
		// 행
		int i = 1;
		while (i <= 5) {
			
			// 열
			int j = 1;
			while (j <= i) {
				System.out.print("*");
				j++;
			}
			System.out.println();
			i++;
		}
		
		System.out.println("----------");
		
		// 행
		int x = 5;
		while (x > 0) {
			
			// 열
			int y = 1;
			while (y <= x) {
				System.out.print("*");
				y++;
			}
			System.out.println();
			x--;
		}
		
		System.out.println("----------");

		// 행
		int x2 = 1;
		while (x2 <= 5) {
			
			// 열
			int y = 1;
			while (y <= 5) {
				if (x2 <= y) System.out.print("*");
				else System.out.print(" ");
				y++;
			}
			System.out.println();
			x2++;
		}
		
		System.out.println("----------");
		
		// 행
		int i2 = 1;
		while (i2 <= 5) {
			
			// 열
			int j = 1;
			while (j <= 5) {
				if (j >= 6-i2) System.out.print("*");
				else System.out.print(" ");
				j++;
			}
			System.out.println();
			i2++;
		}
	}
}
