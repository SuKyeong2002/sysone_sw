package enum1;

public class ComputerTest extends Object {
	public static void main(String[] args) {
		Computer computer = new Computer();
		System.out.println(computer.getPowerState());
		computer.turnOn();
		System.out.println(computer.getPowerState());
	}
}