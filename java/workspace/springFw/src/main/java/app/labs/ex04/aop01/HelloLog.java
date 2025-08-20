package app.labs.ex04.aop01;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.Signature;

public class HelloLog {
	
	/*
	 *  코드분리는 메서드까지
	 *  static(정적): 클래스 메서드 -> 사용: 클래스이름.메서드이름
	 *  util: 공동 사용 (PL이 결정)
	 */
	
	public static void log() {
		System.out.println(">>> Log" + new java.util.Date());
	}
	
	public void resultLog(JoinPoint jointPoint, Object resultObject) {
		Signature signature = jointPoint.getSignature();
		String methodName = signature.getName();
		System.out.println(">>> RESULT 핵심코드 메서드명: " + methodName);
		System.out.println(">>> 핵심코드 반환값: " + resultObject.toString());
	}

	
	public void exceptionLog(JoinPoint jointPoint, Exception exception) {
		Signature signature = jointPoint.getSignature();
		String methodName = signature.getName();
		System.out.println(">>> EXCEPTION LOG <<< : 핵심코드 메서드명 - " + methodName);
		System.out.println("예외 발생 - 메시지: " + exception.getMessage());
	}
	
	public Object aroundLog(ProceedingJoinPoint jointPoint) {
		Object result = null;
		Signature signature = jointPoint.getSignature();
		String methodName = signature.getName();
		System.out.println(">>> BEFORE LOG <<< : 메서드 이름 - " + methodName);
		try {
			result = jointPoint.proceed();
		} catch(Throwable e) {
			System.out.println(">>> EXCEPTION LOG <<< : 예외 메시지 - " + e.getMessage());;
		} finally {
			System.out.println(">>> FINALLY <<<");
		}
		return result;
	}
	
}
