package app.labs.ex05.jdbc01;

import org.springframework.context.support.AbstractApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;

public class EmpMain {

	public static void main(String[] args) {
		AbstractApplicationContext context = new GenericXmlApplicationContext("classpath:config/jdbc01/application-config.xml");

		IEmpService empService = context.getBean("empService", IEmpService.class);
		
		System.out.println("=== 사원수 조회 ===");
		System.out.println(empService.getEmpCount());
		
		System.out.println("=== 50번인 사원수 조회 ===");
		System.out.println(empService.getEmpCount(50));
		
		System.out.println("=== 500 사원 조회 ===");
		System.out.println(empService.getEmpInfo(500));
		
//		System.out.println("=== 500 사원 급여률 10% 인상 ===");
//		EmpVO emp500 = empService.getEmpInfo(500);
//		System.out.println(emp500.getSalary() * 1.1);
//		emp500.setSalary(emp500.getSalary() * 1.1);
//			empService.updateEmp(emp500);	
		
		System.out.println("=== 500 사원 삭제 ===");
		int cnt = empService.deleteEmp(500, "email");
		System.out.println(cnt + "개의 데이터를 삭제하였습니다.");
		
		System.out.println("=== 부서 조회 ===");
		System.out.println(empService.getAllDeptId());
		
		System.out.println("=== 직업 조회 ===");
		System.out.println(empService.getAllJobId());
		
		System.out.println("=== 매니저 조회 ===");
		System.out.println(empService.getAllManagerId());

		
		context.close();
	}

}
