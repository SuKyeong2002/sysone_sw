package app.labs.ex03.di03;

import org.springframework.context.annotation.AnnotationConfigApplicationContext;
import org.springframework.context.support.AbstractApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;

public class HelloMain {

	public static void main(String[] args) {
		// AbstractApplicationContext context = new GenericXmlApplicationContext("classpath:config/di03/application-config.xml");
		AbstractApplicationContext context = new AnnotationConfigApplicationContext(AppConfig.class);

		HelloController controller = context.getBean("helloController", HelloController.class);
		controller.hello("홍길동");
		
		context.close();
	}

}
