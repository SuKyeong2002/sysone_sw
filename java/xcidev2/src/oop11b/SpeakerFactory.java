package oop11b;

// Simple factory pattern
public class SpeakerFactory {
	public static Speaker getSpeaker() {
		String speakerClassName = null;
		try {
			speakerClassName = productHeader.getValue("speaker");
			return (Speaker) Class.forName(speakerClassName).getDeclaredConstructor().newInstance();
		} catch (Exception e) {
			System.out.println(speakerClassName + "클래스가 존재하지 않거나 에러입니다.");
			return null;
		}
	}
}
