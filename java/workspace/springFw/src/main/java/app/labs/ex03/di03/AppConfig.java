package app.labs.ex03.di03;

import org.springframework.beans.factory.annotation.Configurable;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;

/*
 * @Configurable : AOP
 * @Configuration: Bean
 */

@Configuration
@Configurable
@ComponentScan(basePackages = {"app.labs.ex03.di03"})
public class AppConfig {
	@Bean
	IHelloService hellosService() {
		return new HelloService();
	}
}
