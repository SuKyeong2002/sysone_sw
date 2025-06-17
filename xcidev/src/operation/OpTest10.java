package operation;

public class OpTest10 {
	public static void main(String[] args) {
		int a = 10;
		int b = 5;
		
		b += (++a); // b = b + (++a)
		System.out.println(a + ", " + b);
		
		b += a++; 
		System.out.println(a + ", " + b);
	}
}
