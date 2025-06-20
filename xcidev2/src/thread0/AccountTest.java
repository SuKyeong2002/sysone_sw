package thread0;

class Account {

    private int money;

    public Account(int m) {
        money = m;
    }

    synchronized void deposit(int amount, String name) { // 입금
        money += amount;
        System.out.println(name + ": 입금 금액 : " + amount + getmoney());
    }

    synchronized void withdraw(int amount, String name) {
        if (money >= amount) { // 출금 가능하면
            Thread.yield();
            money -= amount;
            System.out.println(name + ": 출금 금액 : " + amount + getmoney());
        } else {
            System.out.println(name + ": 출금 못함 (잔액이 부족)" + amount + getmoney());
        }
    }

    public String getmoney() {
        return ", 계좌 잔액:" + this.money;
    }
}

class AccountUser extends Thread {
    boolean flag = false; // 입금/인출
    Account obj;

    public AccountUser(Account obj, String name) {
        setName(name);
        this.obj = obj;
    }

    public void run() {
        for (int i = 0; i < 2; i++) {
            try {
                sleep(500);
            } catch (InterruptedException e) {
            }

            if (flag) {
                obj.deposit((int) (Math.random() * 23 + 6) * 100, getName());
            } else {
                obj.withdraw((int) (Math.random() * 23 + 6) * 100, getName());
            }
            flag = !flag;
        }
    }
}

public class AccountTest {
    public static void main(String[] args) {
        Account account = new Account(2000);
        AccountUser au1 = new AccountUser(account, "유재하");
        AccountUser au2 = new AccountUser(account, "조하문");
        AccountUser au3 = new AccountUser(account, "신해철");
        au1.start();
        au2.start();
        au3.start();
    }
}