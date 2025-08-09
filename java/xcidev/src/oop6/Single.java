package oop6;

// 싱글톤 패턴
public class Single {
	// Lazy Initialization : 지연 초기화
	private static Single single; 
	private Single() {}
	
	public static Single getInstance() {
		if (single == null) { // 최초 실행 시 인스턴스 생성
			single = new Single();
		}
		return single;
	}
}
