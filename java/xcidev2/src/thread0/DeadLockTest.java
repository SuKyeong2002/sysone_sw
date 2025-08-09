package thread0;

class A {
    synchronized void area(B b) {
        String name = Thread.currentThread().getName();
        System.out.println(name + " : A.area()가 시작되었습니다.");

        try {
            Thread.sleep(1000);
        } catch (Exception e) {
            e.printStackTrace();
        }

        System.out.println(name + " B.last()를 호출합니다.");
        b.last();
    }

    synchronized void last() {
        System.out.println("A.last() 입니다.");
    }
}

class B {
    synchronized void area(A a) {
        String name = Thread.currentThread().getName();
        System.out.println(name + " : B.area()가 시작되었습니다.");

        try {
            Thread.sleep(1000);
        } catch (Exception e) {
            e.printStackTrace();
        }

        System.out.println(name + " A.last()를 호출합니다.");
        a.last();
    }

    synchronized void last() {
        System.out.println("B.last() 입니다.");
    }
}

class Deadlock implements Runnable {
    A a = new A();
    B b = new B();

    public Deadlock() {
        Thread.currentThread().setName("Thread-1");
        Thread t = new Thread(this, "Thread-2");
        t.start();

        a.area(b);
        System.out.println("DeadLock.DeadLock()");
    }

    public void run() {
        b.area(a);
        System.out.println("DeadLock.run()");
    }
}

public class DeadLockTest {
    public static void main(String args[]) {
        new Deadlock();
    }
}