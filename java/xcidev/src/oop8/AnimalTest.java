package oop8;

public class AnimalTest {
	public static void main(String[] args) {
		// 클래스 사이의 형변환
		/*
		 1. 반드시 extends, implements 관계에서 가능
		 2. 업캐스팅은 무조건 가능
		 3. 다운캐스팅은 원 인스턴스가 현재 다운 캐스팅 하려는 타입 또는 
		 	서브타입인 경우 가능
		 4. 현재 참조하려는 타입에 정의되었거나 상속받은 멤버에만 접근 가능
		 */
		
		Animal a = new Animal();
		System.out.println(a);
		
		Animal a2 = new Bird(); // 1단계 up casting
		System.out.println(a2);
		// System.out.println(a2.wings()); : Animal에 wings()가 없기 때문
		
		Animal a3 = new Condor(); // 2단계 up casting
		System.out.println(a3);
		
		Bird b = new Condor(); // 1단계 up casting
		System.out.println(b);
		
		Bird b2 = (Bird) a2; // (Bird) new Animal(); : 에러나지만, 원래 내거(new Bird())는 가능
		System.out.println(b2);
		System.out.println(b2.wings());
		
		Bird b3 = (Bird) a3; 
		System.out.println(b3);
		System.out.println(b3.wings());
		
		Bird b4 = new Bird();
		System.out.println(b4);
		
		// Condor c1 = (Condor) b4; : 3번 위반
		Condor c2 = (Condor) b;
		System.out.println(c2);
		System.out.println(c2.attack());
		System.out.println(c2.wings());
		
		Condor c3 = (Condor) a3;
		System.out.println(c3);
		
		Animal a4 = new Cat(); // 1단계 up casting
		System.out.println(a4); 
		
		Cat c = (Cat) a4; // 1단계 down casting
		System.out.println(c);
		
		Bird b5 = (Bird) a4;
		
	}
}
