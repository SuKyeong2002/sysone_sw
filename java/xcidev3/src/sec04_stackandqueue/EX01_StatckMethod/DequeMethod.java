package sec04_stackandqueue.EX01_StatckMethod;

import java.util.ArrayDeque;
import java.util.Deque;
import java.util.concurrent.ConcurrentLinkedDeque;

public class DequeMethod {
	public static void main(String[] args) {
		// 양방향 하고 싶다면 ArrayDeque 사용
		Deque<String> deque = new ArrayDeque<>();

		deque.addFirst("밤");
		deque.addLast("별");
		deque.addFirst("달");

		System.out.println(deque); // [달, 밤, 별]
		deque.removeLast(); // "별" 제거
		System.out.println(deque); // [달, 밤]

		// 동기화 하고 싶다면 ConcurrentLinkedDeque 사용
		Deque<String> dequeSynch = new ConcurrentLinkedDeque<>(); 

		dequeSynch.add("사과");
		dequeSynch.addFirst("바나나");
		dequeSynch.addLast("딸기");

		System.out.println(dequeSynch);
		while (!dequeSynch.isEmpty()) {
			System.out.println(dequeSynch.pollFirst()); // FIFO 순으로 출력
		}
	}
}