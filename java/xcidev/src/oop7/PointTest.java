package oop7;

public class PointTest {
	public static void main(String[] args) {
		Point2D p1 = new Point2D();
		p1.x = 100;
		p1.y = 200;

		Point2D p2 = new Point3D(); // 업 캐스팅 (독수리는 새야)
		p2.x = 1000;
		p2.y = 2000;
//		p2.z = 3000; // 접근 X
		
		Point3D p2 = (Point3D) p2; // 다운 캐스팅 (독수리는 새야)
		p2.x = 1000;
		p2.y = 2000;
//		p2.z = 3000; // 접근 X
	}
}
