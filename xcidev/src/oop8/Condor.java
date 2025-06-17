package oop8;

public class Condor extends Bird{
	
	@Override
	public String toString() {
		return "Condor 입니다.";
	}
	
	public String attack() {
		return "부리와 발톱으로 공격!";
	}
}
