package method;

public class MethodTest3 {
	public static void main(String[] args) {
		System.out.println("주사위 값은: " + dice());
	}

	private static int dice() {
		return (int)(Math.random()*6);
	}
}
