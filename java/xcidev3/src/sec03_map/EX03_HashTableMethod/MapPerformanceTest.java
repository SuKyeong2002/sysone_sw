package sec03_map.EX03_HashTableMethod;

import static org.junit.jupiter.api.Assertions.assertTrue;

import java.util.Hashtable;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.junit.jupiter.api.Test;

public class MapPerformanceTest {

	private static final int THREAD_COUNT = 4;
	private static final int INSERT_COUNT = 100_000;

	@Test
	void comparePerformance_Hashtable_vs_ConcurrentHashMap() throws InterruptedException {
		// Hashtable 테스트
		Map<String, Integer> hashtable = new Hashtable<>();
		long hashtableTime = measureExecutionTime(hashtable);
		System.out.println("Hashtable 소요 시간: " + hashtableTime + "ms");

		// ConcurrentHashMap 테스트
		Map<String, Integer> concurrentMap = new ConcurrentHashMap<>();
		long concurrentTime = measureExecutionTime(concurrentMap);
		System.out.println("ConcurrentHashMap 소요 시간: " + concurrentTime + "ms");

		// ConcurrentHashMap이 더 빠를 것이라는 기대
		assertTrue(concurrentTime < hashtableTime * 1.2, "ConcurrentHashMap이 확실히 빠르지 않음!");
	}

	private long measureExecutionTime(Map<String, Integer> map) throws InterruptedException {
		Thread[] threads = new Thread[THREAD_COUNT];
		long start = System.currentTimeMillis();

		for (int i = 0; i < THREAD_COUNT; i++) {
			threads[i] = new Thread(new Runnable() {
				@Override
				public void run() {
					for (int j = 0; j < INSERT_COUNT; j++) {
						String key = "key" + j;
						map.put(key, j);
					}
				}
			});
		}

		for (Thread t : threads)
			t.start();
		for (Thread t : threads)
			t.join();

		return System.currentTimeMillis() - start;
	}
}