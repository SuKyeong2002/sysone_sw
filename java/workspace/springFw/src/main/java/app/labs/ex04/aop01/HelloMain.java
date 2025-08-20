package app.labs.ex04.aop01;

import org.springframework.context.support.AbstractApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;

public class HelloMain {

	public static void main(String[] args) {
		AbstractApplicationContext context = new GenericXmlApplicationContext("classpath:config/aop01/application-config.xml");
		
		HelloController helloController = context.getBean("helloController", HelloController.class);
		helloController.hello("홍길동");
		
		context.close();
	}

}
