package sec01_lambdaexpression.EX01_OOPvsFP;

public class LambdaVsAnonymous {
    public static final long ITERATIONS = 100_000_000_000L;

    public static void main(String[] args) {
        System.out.println("성능 테스트 시작...");

        // 람다식 테스트
        Runnable lambdaRunnable = () -> {};
        long startLambda = System.nanoTime();
        for (long i = 0; i < ITERATIONS; i++) {
            lambdaRunnable.run();
        }
        long endLambda = System.nanoTime();
        System.out.printf("람다식 실행 시간: %,.2f ms%n", (endLambda - startLambda) / 1_000_000.0);

        // 익명 내부 클래스 테스트
        Runnable anonymousRunnable = new Runnable() {
            @Override
            public void run() {
            }
        };
        long startAnon = System.nanoTime();
        for (long i = 0; i < ITERATIONS; i++) {
            anonymousRunnable.run();
        }
        long endAnon = System.nanoTime();
        System.out.printf("익명 내부 클래스 실행 시간: %,.2f ms%n", (endAnon - startAnon) / 1_000_000.0);
    }
}
