package sec04_stackandqueue.EX02_QueueMethod;

import java.util.LinkedList;
import java.util.Queue;


// Queue: 선입선출
// Stack: 후입선출
public class QueueMethod {
	public static void main(String[] args) {
		// 1. 예외 처리 가능 미포함 메서드
		Queue<Integer> queue1 = new LinkedList<Integer>();
		
		queue1.add(3);
		queue1.add(4);
		queue1.add(5);
		
		// 1-2. element()
		System.out.println(queue1.element());
		
		// 1-3. E remove()
		System.out.println(queue1.remove());
		System.out.println(queue1.remove());
		System.out.println(queue1.remove());
		System.out.println();
		
		// 2. 예외 처리 가능 포함 메서드
		Queue<Integer> queue2 = new LinkedList<Integer>();
		
		// 2-1. offer(E item)
		queue2.offer(3);
		queue2.offer(4);
		queue2.offer(5);
		
		// 2-2. E peek();
		System.out.println(queue2.peek()); // 첫번째 요소인 3 출력
		
		// 2-3. E poll();
		System.out.println(queue2.poll()); // 3 제거 후 반환
		System.out.println(queue2.poll()); // 4 제거 후 반환
		System.out.println(queue2.poll()); // 5 제거 후 반환
		System.out.println(queue2.poll()); // 비어 있으므로 null 반환
		
	}
}
