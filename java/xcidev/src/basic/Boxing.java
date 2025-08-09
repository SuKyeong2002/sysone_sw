package basic;

public class Boxing {
	public static void main(String[] args) {
		int i = 10;
		Integer old = Integer.valueOf(10); // Auto boxing
		Integer i2 = i; // Auto unboxing
		int i3 = i2;
		int i4 = (Integer)i2;
	}
}
