package app.labs.servlet;

import java.util.HashMap;
import java.util.Map;
import java.util.function.BinaryOperator;

// 빈(=자바) 관례
/*
 * 1. 모든 멤버변수는 private이어야 한다.
 * 2. 기본 생성자가 제공되어야 한다.
 * 3. getter, setter가 제공되어야 한다. 
 */
public class CalcBean {
	// 입력받는 멤버변수 
	private String num1;
	private String num2;
	private String operator;
	
	// 결과값 멤버변수
	private int result;
	
	// 생성자
	public CalcBean() {}

	public String getNum1() {
		return num1;
	}

	public void setNum1(String num1) {
		this.num1 = num1;
	}

	public String getNum2() {
		return num2;
	}

	public void setNum2(String num2) {
		this.num2 = num2;
	}

	public String getOperator() {
		return operator;
	}

	public void setOperator(String operator) {
		this.operator = operator;
	}

	public int getResult() {
		return result;
	}
	
	public void calculate() {
        if (this.num1 == null) this.num1 = "0";
        if (this.num2 == null) this.num2 = "0";
        if (this.operator == null) this.operator = "+";

        CalcService calc = new CalcService(Integer.parseInt(num1), Integer.parseInt(num1), this.operator);
        this.result = calc.getResult();

        /* 함수지향형
        Map<String, BinaryOperator<Integer>> calcMap = new HashMap<>();

        calcMap.put("+", (a, b) -> a + b);
        calcMap.put("-", (a, b) -> a - b);
        calcMap.put("*", (a, b) -> a * b);
        calcMap.put("/", (a, b) -> a / b);

        this.result = calcMap.get(operator)
        			.apply(Integer.parseInt(num1), Integer.parseInt(num2));
        */
    }
}
