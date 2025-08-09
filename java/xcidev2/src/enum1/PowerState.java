package enum1;

public enum PowerState {
	OFF("전원이 꺼졌습니다."), ON("전원이 켜졌습니다."), SUSPEND("절전 모드입니다.");

	private final String message;

	PowerState(String message) {
		this.message = message;
	}

	public String getMessage() {
		return message;
	}

	void printSatus() {
		System.out.println("현재 상태는 " + name() + " ,[STATUS])" + message);

	}
}
