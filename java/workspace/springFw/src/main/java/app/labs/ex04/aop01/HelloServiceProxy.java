package app.labs.ex04.aop01;

// 잘만 응용하면 굉장히 좋음
public class HelloServiceProxy extends HelloService {
	
	@Override
	public String sayHello(String name) {
		HelloLog.log();
		
		String result = super.sayHello(name);
		
		return result;
	}
}
