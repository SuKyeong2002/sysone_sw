package oop10;

class Point {}

public class HashCodeTest {
	public static void main(String[] args) {
		Point p = new Point();
		System.out.printf("%x", p.hashCode());
	}
}
