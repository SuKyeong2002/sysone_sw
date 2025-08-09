package oop8;

public class Bird extends Animal{
	
	@Override
	public String toString() {
		return "Bird 입니다.";
	}
	
	public String wings() {
		return "날개짓을 합니다.";
	}
}
