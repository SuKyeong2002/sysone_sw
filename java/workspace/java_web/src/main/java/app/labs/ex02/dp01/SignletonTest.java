package app.labs.ex02.dp01;

public class SignletonTest {
	public static void main(String[] args) {
		
		// class method -> class 
		Singleton singleton = Singleton.getInstance();
		
		// instance 생성 후 사용 가능
		singleton.showCount();
		
		// class method -> class 
		Singleton singleton1 = Singleton.getInstance();
		
		// instance 생성 후 사용 가능
		singleton1.showCount();
		
		// class method -> class 
		Singleton singleton2 = Singleton.getInstance();
		
		// instance 생성 후 사용 가능
		singleton2.showCount();
				
	}
}
