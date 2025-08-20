package app.labs.ex03.di03;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;

// 의존성 생성방법
@Controller
public class HelloController {
	/*
	 *  1) 기본 - 멤버필드 이용 
	 *  @Autowired: 순환참조 발생 시 무한...
	 *  -> 해결방안: 생성자에 final 추가
	 */
	@Autowired
	private IHelloService helloService;
	
	// @Qualifier: default id 사용 안할 경우 
	// @Autowired
	// @Qualifier("niceService")
	// private IHelloService niceService;
	
	/*
	 *  2) 생성자 이용
	 *  해결방안: final private IHelloService helloService;
	 */
	// @Autowired
	public HelloController(IHelloService helloService) {
		// this.helloService = helloService;
		// this.niceService = helloService;
	}
	
	// 3) Setter
	public HelloController() {}
	// @Autowired
	public void setHelloService(IHelloService helloService) {
		// this.helloService = helloService;
		// this.niceService = helloService;
	}
	
	public void hello(String name) {
		System.out.println("HelloController: " + helloService.sayHello(name));
	}
}
