package oop11b;

// 표준 TV
public interface TV {
	
	public default void setSpeaker(Speaker speaker) {}

	
	public void powerOn();

	public void powerOff();

	public void channelUp();

	public void channelDown();

	public void soundUp();

	public void soundDown();
}
