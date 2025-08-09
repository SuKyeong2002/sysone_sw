package oop6;

public class SingleTest {
	public static void main(String[] args) {
		Single s1 = Single.getInstance();
		Single s2 = Single.getInstance();
		System.out.println(s1.hashCode());
		System.out.println(s2.hashCode());
		
		Single2 s3 = Single2.getInstance();
		Single2 s4 = Single2.getInstance();
		System.out.println(s3.hashCode());
		System.out.println(s4.hashCode());
	}
}
