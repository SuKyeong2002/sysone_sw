package array;

import java.util.Scanner;

public class TypeingGame {
	public static void main(String[] args) {
		String[] words = {
				"Java",
				"James Gosling",
				"Green Project",
				"Spring Framework",
				"React",
				"Node.js",
				"Write once, Run anywhere",
				"sysone",
				"oracle database"
		};
		
		Scanner sc = new Scanner(System.in);
		long startTime = System.currentTimeMillis();
		for (int i = 1; i <= 5; i++) {
			int randomNumber = (int)(Math.random() * words.length);
			do {
				System.out.print(i + " : " + words[randomNumber] + " > ");
				String keyword = sc.nextLine();
				
				// 정확하게 입력했는지 확인
				if (!keyword.equals(words[randomNumber])) {
					System.out.println("오타입니다. 다시 입력하세요.");
				} else {
					break;
				}
			} while (true); // 타이핑 미스 시 다시 입력 
		}
		long endTime = System.currentTimeMillis();
		double runningTime = ((double)endTime - startTime)/1000;
		System.out.println("총 소요 시간은 " +  runningTime + "초 입니다.");
		
		try {
			 
		} catch (Exception e) {
			
		}
	}
}
