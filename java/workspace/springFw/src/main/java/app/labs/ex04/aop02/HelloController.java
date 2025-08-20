package app.labs.ex04.aop02;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.Signature;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

@Controller
public class HelloController {
	IHelloService helloService;
	
	@Autowired
	// 생성자로 helloService 초기화
	public HelloController(IHelloService helloService) {
		this.helloService = helloService;
	}
	
	public void hello(String name) {
		System.out.println("HelloController : " + helloService.sayHello(name));
	}
	
	public void goodbye(String name) {
		System.out.println("HelloController : " + helloService.sayGoodBye(name));
	}

}
