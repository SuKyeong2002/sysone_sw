package app.labs.ex04.aop02;

import org.springframework.context.support.AbstractApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;

public class HelloMain {

	public static void main(String[] args) {
		AbstractApplicationContext context = new GenericXmlApplicationContext("classpath:config/aop02/application-config.xml");
		
		HelloController helloController = context.getBean("helloController", HelloController.class);
		helloController.hello("홍길동");
		helloController.goodbye("고길동");
		
		context.close();
	}

}
