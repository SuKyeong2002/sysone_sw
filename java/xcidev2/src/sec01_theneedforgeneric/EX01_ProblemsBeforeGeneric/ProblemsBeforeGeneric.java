package sec01_theneedforgeneric.EX01_ProblemsBeforeGeneric;

// Apple 클래스와 Apple 클래스를 담을 수 있는 Goods1 클래스
class Apple {
}

class Goods1 {

	// Apple 타입의 필드
	private Apple apple = new Apple();

	// 저장된 필드값을 가져오는 getter 메서드
	public Apple getApple() {
		return apple;
	}

	// 필드값을 저장하는 setter 메서드
	public void setApple(Apple apple) {
		this.apple = apple;
	}
}

// Pencil 클래스와 Pencil 클래스를 담을 수 있는 Goods2 클래스
class Pencil {
}

class Goods2 {

	// Pencil 타입의 필드
	private Pencil pencil = new Pencil();

	// 저장된 필드값을 가져오는 getter 메서드
	public Pencil getPencil() {
		return pencil;
	}

	// 필드값을 저장하는 setter 메서드
	public void setPencil(Pencil pencil) {
		this.pencil = pencil;
	}
}

public class ProblemsBeforeGeneric {
	public static void main(String[] args) {
		// Goods1을 이용해 Apple 객체를 추가하거나 가져오기
		Goods1 goods1 = new Goods1();

		// Apple 타입만 입력 가능
		goods1.setApple(new Apple());

		// Apple 타입 리턴
		Apple apple = goods1.getApple();

		// Goods2을 이용해 Pencil 객체를 추가하거나 가져오기
		Goods2 goods2 = new Goods2();

		// Pencil 타입만 입력 가능
		goods2.setPencil(new Pencil());

		// Pencil 타입 리턴
		Pencil pencil = goods2.getPencil();

	}
}
