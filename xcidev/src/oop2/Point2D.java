package oop2;

public class Point2D {
	int x;
	int y;
//	public Point2D() {} // default constructor

	public Point2D() {
		this(1, 2); // constructor overrode 먼저 수행!
		System.out.println("Point2D() 수행");
	}

	public Point2D(int x, int y) {
		this.x = x;
		this.y = y;
		System.out.println("Point2D(x, y) 수행");
	}
}
