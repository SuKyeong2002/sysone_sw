package control;

public class DoWhileTest2 {
	public static void main(String[] args) {

		int dice1, dice2;

		dice1 = (int) (Math.random() * 6) + 1;
		do {
			dice2 = (int) (Math.random() * 6) + 1;
		} while (dice2 == dice1);
		System.out.println(dice1 + ", " + dice2);

		System.out.println("종료");
	}
}
