package sec05_innerinterfacce.EX02_ButtonAPIExample;


class Button {
	onClickListener ocl;
	void setOnCLickListener (onClickListener ocl) {
		this.ocl = ocl;
	}
	
	interface onClickListener {
		public abstract void onClick();
	}
}

public class ButtonAPIExample {
	public static void main(String[] args) {
		Button btn1 = new Button();
	}
}
