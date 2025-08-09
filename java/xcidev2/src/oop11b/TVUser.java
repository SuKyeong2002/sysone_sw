package oop11b;

public class TVUser {
	public static void main(String[] args) {
		TV tv = TVFactory.getTV(); // new LgTV();
		tv.setSpeaker(SpeakerFactory.getSpeaker()); // new HarmanSpeaker();
		tv.powerOn();
		tv.channelUp();
		tv.channelUp();
		tv.soundUp();
		tv.soundUp();
		tv.soundDown();
		tv.powerOff();
	}
}
