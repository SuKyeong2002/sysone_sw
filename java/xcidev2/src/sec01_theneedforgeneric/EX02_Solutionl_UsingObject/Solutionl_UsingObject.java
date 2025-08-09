package sec01_theneedforgeneric.EX02_Solutionl_UsingObject;

// Apple, Pencil 클래스 모두 저장하거나 꺼낼 수 있는 클래스

class Apple {
}

class Pencil {
}

class Goods {
	private Object object = new Object();

	// 저장된 필드값을 가져오는 getter 메서드
	public Object getObject() {
		return object;
	}

	// 필드값을 저장하는 setter 메서드
	public void setObject(Object object) {
		this.object = object;
	}
}

public class Solutionl_UsingObject {
	public static void main(String[] args) {
		// Goods를 이용해 Apple 객체를 추가하거나 가져오기
		Goods goods1 = new Goods();

		// Apple 타입만 입력 가능
		goods1.setObject(new Apple());

		// Apple 타입 리턴
		Apple apple = (Apple) goods1.getObject();

		// Goods를 이용해 Pencil 객체를 추가하거나 가져오기
		Goods goods2 = new Goods();

		// Pencil 타입만 입력 가능
		goods2.setObject(new Pencil());

		// Pencil 타입 리턴
		Pencil pencil = (Pencil) goods2.getObject();

	}
}
