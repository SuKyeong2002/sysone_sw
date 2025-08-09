package oop9;

public class ShapeTest {
	public static void main(String[] args) {
		printArea(new Circle());
		printArea(new Rectangle());
		printArea(new Triangle());
	}
	
	private static void printArea(Shape s) {
		s.area();
		if(s instanceof Circle) {
			Circle c = (Circle)s;
			System.out.println("반지름 " + c.r + "인 원의 넓이는 " + c.res + " 입니다.");
		} else if (s instanceof Rectangle) {
			Rectangle rec = (Rectangle)s;
			System.out.println("가로가 " + rec.w + "이고 세로가 " + rec.h + "인 사각형의 넓이는 " + rec.res + " 입니다.");
		} else if (s instanceof Triangle) {
			Triangle Tri = (Triangle)s;
			System.out.println("가로가 " + Tri.w + "이고 세로가 " + Tri.h + "인 삼각형의 넓이는 " + Tri.res + " 입니다.");
		} 
	}
}
