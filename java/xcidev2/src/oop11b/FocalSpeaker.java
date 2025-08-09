package oop11b;

// Speaker 인터페이스 구현
public class FocalSpeaker implements Speaker {

	public FocalSpeaker() {
		System.out.println("FocalSpeaker : 제품이 생성됨");
	}

	@Override
	public void soundUp() {
		System.out.println("FocalSpeaker : 소리를 키웁니다.");
	}

	@Override
	public void soundDown() {
		System.out.println("FocalSpeaker : 소리를 줄입니다.");
	}

}
