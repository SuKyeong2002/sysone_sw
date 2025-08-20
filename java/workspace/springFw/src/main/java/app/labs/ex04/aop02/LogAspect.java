package app.labs.ex04.aop02;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.Signature;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.stereotype.Component;

// Component 스캔 시 빈 등록 -> Aspect 작업 시작 [POJO]
@Component
@Aspect
public class LogAspect {

	// 핵심코드(Pointcut)
	// 빈 등록: ex04.aop02.HelloService. -> ex04..HelloService. 
	@Pointcut(value="execution(* app.labs.ex04..HelloService.sayHello(..))")
	private void helloPointCut() {}
	
	@Pointcut(value="execution(* app.labs.ex04..HelloService.sayGoodBye(..))")
	private void goodbyePointcut() {}
	
	// 공통코드(Aspect + Advice = Advisor)
	// @Before: helloPointCut 실행 전 시작 (지정)
	@Before(value = "helloPointCut()")	// Advice
	public void beforeLog(JoinPoint joinpoint) {
		System.out.println(">>> log : " + new java.util.Date());
	}
	
	// 공통코드(Aspect + Advice = Advisor)
	// @AfterReturning: helloPointCut 실행 후 시작 (지정)
	@AfterReturning(pointcut="goodbyePointcut()", returning="msg")
	public void afterLog(JoinPoint jointpoint, Object msg) {
		System.out.println(">>> log : " + new java.util.Date());
		System.out.println(">>> msg : " + msg.toString());
	}
	
	// @Around: 실행시간 계산
	@Around(value = "helloPointCut() || goodbyePointcut()")
	public Object trace(ProceedingJoinPoint joinpoint) throws Throwable {
		Signature signature = joinpoint.getSignature();
		String methodName = signature.getName();
		System.out.println("[Log] Before: " + methodName + " start");
		
		long startTime= System.nanoTime();
		
		Object result = null;
		
		try {
			result = joinpoint.proceed();
		} catch(Exception e) {
			System.out.println("[Log] Exception: " + methodName + e.getMessage());
		} finally {
			System.out.println("[Log] Finally: " + methodName);
		}
		
		long endTime= System.nanoTime();
		
		System.out.println("[Log] After: " + methodName + " end");
		System.out.println("[Log] " + (endTime - startTime) + " ns");
		
		return result;
	}
	
}
