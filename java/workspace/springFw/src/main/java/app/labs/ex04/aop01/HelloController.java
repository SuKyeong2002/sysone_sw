package app.labs.ex04.aop01;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.Signature;

public class HelloController {
	IHelloService helloService;
	
	// 생성자로 helloService 초기화
	public HelloController(IHelloService helloService) {
		this.helloService = helloService;
	}
	
	public void hello(String name) {
		System.out.println("HelloController : " + helloService.sayHello(name));
	}

}
