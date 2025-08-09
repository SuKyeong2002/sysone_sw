package operation;

public class OpTest16 {
	public static void main(String[] args) {
		int dice = (int) (Math.random() * 12) + 4; // 1 ~ 6 정수

		// 4 ~ 15 중의 숫자만 출력
		System.out.println((int) (Math.random() * 12) + 4); // 12: 숫자 범위 갯수, 4: 시작하는 숫자
		System.out.println((int) (Math.random() * 12) + 4);
		System.out.println((int) (Math.random() * 12) + 4);
		System.out.println((int) (Math.random() * 12) + 4);

		System.out.println();

		// 600, 700, 800, ..., 2300 중의 숫자만 출력
		System.out.println((int) (Math.random() * 18 + 6) * 100);
		System.out.println((int) (Math.random() * 18 + 6) * 100);
		System.out.println((int) (Math.random() * 18 + 6) * 100);
		System.out.println((int) (Math.random() * 18 + 6) * 100);
		System.out.println((int) (Math.random() * 18 + 6) * 100);

	}
}
