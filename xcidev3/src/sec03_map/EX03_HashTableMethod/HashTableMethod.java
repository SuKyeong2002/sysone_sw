package sec03_map.EX03_HashTableMethod;

import java.util.HashMap;
import java.util.Hashtable;
import java.util.Map;
import java.util.Set;

public class HashTableMethod {
	public static void main(String[] args) {
		Map<Integer, String> hTable1 = new Hashtable<Integer, String>();

		// 1. put (K key, V value)
		hTable1.put(2, "나다라");
		hTable1.put(1, "가나다");
		hTable1.put(3, "다라마");
		System.out.println(hTable1.toString());

		// 12. putAll(다른 앱 객체)
		Map<Integer, String> hTable2 = new HashMap<Integer, String>();
		hTable2.putAll(hTable1);
		System.out.println(hTable2.toString());
		System.out.println();

		// 3. replace(K key, V value)
		hTable2.replace(1, "가가가");
		hTable2.replace(4, "라라라"); // 동작 x
		System.out.println(hTable2.toString());
		System.out.println();

		// 4. replace(K key, V oldValue, V newValue
		hTable2.replace(1, "가가가", "나나나");
		hTable2.replace(2, "다다다", "라라라"); // 동작 x
		System.out.println(hTable2.toString());
		System.out.println();

		// 5. V get(Object key)
		System.out.println(hTable2.get(1));
		System.out.println(hTable2.get(2));
		System.out.println(hTable2.get(3));
		System.out.println();

		// 6. containsKey(Object key)
		System.out.println(hTable2.containsKey(1));
		System.out.println(hTable2.containsKey(5));
		System.out.println();

		// 7. containsValue(Object value)
		System.out.println(hTable2.containsValue("나나나"));
		System.out.println(hTable2.containsValue("다다다"));
		System.out.println();

		// 8. Set<K> keyset()
		Set<Integer> keySet = hTable2.keySet();
		System.out.println(keySet.toString());

		// 9. Set<Map.Entry<K,V> entrySet()
		Set<Map.Entry<Integer, String>> entrySet = hTable2.entrySet();
		System.out.println(entrySet.toString());
		System.out.println();

		// 10. size();
		System.out.println(hTable2.size());
		System.out.println();

		// 11. remove(Object key)
		hTable2.remove(1);
		hTable2.remove(4); // 동작 x
		System.out.println(hTable2.toString());
		System.out.println();

		// 12. remove(Object key, Object value)
		hTable2.remove(2, "나다라");
		hTable2.remove(3, "다다다"); // 동작 x
		System.out.println(hTable2.toString());
		System.out.println();

		// 13. clear()
		hTable2.clear();
		System.out.println(hTable2.toString());
	}
}
