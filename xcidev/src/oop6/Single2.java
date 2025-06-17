package oop6;

// 싱글톤 패턴 (외우는 게 좋음)
public class Single2 {
	// Eager Initialization : 조기 초기화
	private static final Single2 single = new Single2(); // 사용전 인스턴스 생성
	
	public static Single2 getInstance() {
		return single;
	}
}
