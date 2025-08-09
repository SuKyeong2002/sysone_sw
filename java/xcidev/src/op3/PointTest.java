package op3;

public class PointTest {
	public static void main(String[] args) {
		Point p1 = new Point();
		Point p2 = new Point();
		p1.color = "RED";
		p1.draw();
		p2.color = "BLUE";
		p2.draw();
		
		System.out.println(p1 + " : " + p1.hashCode()); // 출력: 패키지명.클래스명@해시코드
		System.out.println(p2 + " : " + p2.hashCode());
		System.out.println("종료");
	}
}
