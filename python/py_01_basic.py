'''
주석
'''

# 주석

# 변수 선언
a = 10
b = None 
c = True
d = '문자열'

a, b, c = 1, [2, 3], 4
print(a, b, c)

# 상수
def CONST_PI():
    return 3.14

print(5 * CONST_PI())

import sys

a = sys.maxsize
print(a)
b = sys.maxsize + 100000
print(b)

# 문자열
str1 = '홍길동'
msg = f'{str1}님 안녕하세요.'
print(msg)

'''
연산자
'''
# 사칙 연산자
a = 3; b = 25; c = 2
print(a/c)
print(c/a)
print(a//c)
print(a%c)

# 부동소수점 연산 때문에 다른 값 발생 (5.551115123125783e-17)
d = 0.1 + 0.1 + 0.1 - 0.3
print(d)

# decimal로 10진수 맞춰서 해결 (0.0)
import decimal
print(decimal.Decimal('0.1') + decimal.Decimal('0.1') + decimal.Decimal('0.1') - decimal.Decimal('0.3'))

# 논리 연산자
a = True; b = False
print(a and b)
print(a or b)
print(not a)

# 삼항 연산자
a = 3
print('짝수') if a % 2 == 0 else print('홀수')
print((a % 2 == 0) and '짝수' or '홀수')

# 제어문
if a%2 == 0 :
    print('짝수')
else:
    print('홀수')

print ('*' + '*' , '*'*2)

a = 0
while a < 10:
    a += 1
    print('*'*a)

for a in range(1, 11):
    print('*'*a)

'''
과일 문제
'''

a = [('사과', 2, 1000), ('배', 1, 2000), ('멜론', 2, 3000)]
total = 0
for (b, c, d) in a:
    print(f'{b}({c}개), {c*d}')
    total += c*d
print(f'총합: {total}')

