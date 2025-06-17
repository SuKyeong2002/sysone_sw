package control;

import java.util.Calendar;
import java.util.Scanner;

public class MyCanlendar {
	public static void main(String[] args) {

		Scanner sc = new Scanner(System.in);
		System.out.print("년 입력 > ");
		int year = sc.nextInt();
		System.out.print("월 입력 > ");
		int month = sc.nextInt();

		// 현재 날짜와 시간 정보를 가진 Calendar 객체 생성
		Calendar c = Calendar.getInstance(); 
		
		// 사용자가 입력한 월의 1일로 날짜 설정
		// month-1인 이유: Calendar 클래스의 월은 0부터 시작
		c.set(2025, month - 1, 1); 
		
		// 설정한 날짜의 요일 구함 (일요일 = 1, 월요일 = 2, ... , 토요일 =7)
		int week = c.get(Calendar.DAY_OF_WEEK); 
		
		// 해당 월의 마지막 날짜 구함 
		int end = c.getActualMaximum(Calendar.DAY_OF_MONTH); 
		
		System.out.println("일 월 화 수 목 금 토");
		
		// 1일이 시작하기 전까지 공백으로 채움
		for(int w  = 1; w < week; w++) {
			System.out.print("   ");
		}
		
		for (int d = 1, w = week; d <= end; d++, w++) {
			// 한 자리 수인 일의 경우 앞의 공백 추가 
			System.out.print(d < 10 ? " " + d + " " : d + " ");
			// 토요일에서 줄바꿈
			if(w % 7 == 0) System.out.println();
		}
	}
}
