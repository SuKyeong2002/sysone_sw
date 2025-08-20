package app.labs.ex04.aop01;

public class HelloService implements IHelloService {

	@Override
	public String sayHello(String name) {
		System.out.println("HelloService.sayHello() 메서드 실행");
		// 1) 코드
		// System.out.println(">>> Log" + new java.util.Date());
		
		// 2) oop -> 코드 분류 후 분리 - 재활용
		// HelloLog.log();
		
		System.out.println("HelloService.sayHello() 실행");
		int rand = (int)(Math.random() * 10);
		if (rand < 5) {
			throw new RuntimeException("강제예외발생");
		}
		
		
		String message = "Hello~~~~~~ " + name;
		return message;
	}

	@Override
	public String sayGoodBye(String name) {
		String message = "GoodBye~~~~~~ " + name;
		return message;
	}

}
