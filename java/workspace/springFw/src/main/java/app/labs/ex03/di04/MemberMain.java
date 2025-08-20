package app.labs.ex03.di04;

import org.springframework.context.support.AbstractApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;

public class MemberMain {

	public static void main(String[] args) {
		AbstractApplicationContext context = new GenericXmlApplicationContext("classpath:config/di04/application-config.xml");

		MemberController controller = context.getBean("memberController", MemberController.class);
		controller.printInfo();
		
		context.close();

	}

}
