package oop5;

class Account {
	static int money1;
	int money2;

	Account(int money) {
		money1 += money;
		money2 += money;
	}
}

public class StaticTest {
	public static void main(String[] args) {
		System.out.println(Account.money1);
		
		Account a1 = new Account(1000);
		System.out.println(a1.money1 + " : " + a1.money2);

		Account a2 = new Account(1000);
		System.out.println(a2.money1 + " : " + a2.money2);

		Account a3 = new Account(1000);
		System.out.println(a3.money1 + " : " + a3.money2);
	}
}
