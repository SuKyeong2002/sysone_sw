# List
a = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
print(a)

# indexing
print(a[0], a[-1], a[-2])

# slicing
print(a[0:2], a[6:-1])
print(a[:2], a[-3:]) 
print(a[::3], a[::-1]) # 3칸씩 건너뛰기, 역순

print([1, 2, 3] + [3, 4, 5])
print([1, 2] * 2)

print(sum(a), len(a), max(a), min(a), sum(a)/len(a))
print(sorted(a))

b = list(range(1, 11, 2))
print(b)

b = list(n*2 for n in range(1, 11, 2))
print(b)

# tuple
# list 와 동일 -> 불변형
a = (1, 2, 3, 4, 5, 6, 7, 8, 9, 10)

# a[0] = 3
print(a[:2], a[-3:])

# dictionary 
a = {"name": "Full HD TV", "price": 1000000, "제조국": "대한민국", "price": "110000"}
print(a['제조국'], a['price'])
# print(a['maker'])
print(a.get('maker', '없음'))
a['maker'] = '전자회사'
a['price'] = 20000
print(a)

# 집합
a = {1, 2, 3, 4, 5}
print(a)

# print(a[0]) # 요소 선택 불가능
a = {1, 3, 4, 2, 5}
b = {5, 6, 7}

print(a | b) # 합집합
print(a & b) # 교집합
print(a - b) # 차집합
print(a >= {2, 3}) # 부분집합