package sec04_stackandqueue.EX01_StatckMethod;

import java.util.Stack;

public class StatckMethod {
	public static void main(String[] args) {
		Stack<Integer> stack = new Stack<Integer>();
		
		// 1. E push(E element)
		stack.push(2);
		stack.push(5);
		stack.push(3);
		stack.push(7);
		
		// 2. E peak();
		System.out.println(stack.peek());
		System.out.println(stack.size());
		System.out.println();
		
		// 3. search(Object o)
		System.out.println(stack.search(7));
		System.out.println(stack.search(3));
		System.out.println(stack.search(5));
		System.out.println(stack.search(2));
		System.out.println(stack.search(9));  // 없으면 -1
		System.out.println();
		
		// 4. E pop()
		System.out.println(stack.pop());
		System.out.println(stack.pop());
		System.out.println(stack.pop());
		System.out.println(stack.pop());
		System.out.println();
		
		// 5. boolean empty()
		System.out.println(stack.empty());
	}
}
