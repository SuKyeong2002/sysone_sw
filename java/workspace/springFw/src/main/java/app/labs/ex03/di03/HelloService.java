// 패키지명 중요함
package app.labs.ex03.di03;

import org.springframework.stereotype.Service;

@Service
public class HelloService implements IHelloService {

	@Override
	public String sayHello(String name) {
		System.out.println("HelloService.sayHello() 메서드 실행");
		String message = "Hello~~~~~~ " + name;
		return message;
	}

}
