package control;

import java.util.Calendar;

public class CalendarTest {
	public static void main(String[] args) {
		Calendar c = Calendar.getInstance();
		c.set(2025, 2-1, 1);
		int week = c.get(Calendar.DAY_OF_WEEK);
		System.out.println(week);
		
		int end = c.getActualMaximum(Calendar.DAY_OF_MONTH);
		System.out.println(end);
	}
}
   