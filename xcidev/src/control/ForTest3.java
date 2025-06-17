package control;

import java.util.Scanner;

public class ForTest3 {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);

		int computer = (int) (Math.random() * 3) + 1;

		System.out.print("가위: 1, 바위: 2, 보: 3 중 하나를 입력하세요 > ");
		int me = sc.nextInt();

		switch (computer) {
		case 1:
			if (me == 1) {
				System.out.println("computer: " + computer + " me: " + me + " 결과: 무승부입니다.");
			} else if (me == 2) {
				System.out.println("computer: " + computer + " me: " + me + " 결과: 이겼습니다.");
			} else {
				System.out.println("computer: " + computer + " me: " + me + " 결과: 졌습니다.");
			}
			break;
		case 2:
			if (me == 1) {
				System.out.println("computer: " + computer + " me: " + me + " 결과: 졌습니다.");
			} else if (me == 2) {
				System.out.println("computer: " + computer + " me: " + me + " 결과: 무승부입니다.");
			} else {
				System.out.println("computer: " + computer + " me: " + me + " 결과: 이겼습니다.");
			}
			break;
		case 3:
			if (me == 1) {
				System.out.println("computer: " + computer + " me: " + me + " 결과: 이겼습니다.");
			} else if (me == 2) {
				System.out.println("computer: " + computer + " me: " + me + " 결과: 졌습니다.");
			} else {
				System.out.println("computer: " + computer + " me: " + me + " 결과: 무승부입니다.");
			}
			break;
		}

		System.out.println("종료");
	}
}