/*
let admin;
let name;

name = 'John';
admin = name;

alert(admin); 

let age = prompt('나이를 입력해주세요.', 100);
alert(`당신의 나이는 ${age}살 입니다.`); // 당신의 나이는 100살입니다.

let isBoss = confirm("당신이 주인인가요?");
alert( isBoss ); // 확인 버튼을 눌렀다면 true가 출력됩니다.



let userName = prompt('이름을 입력해주세요.', "");
alert(`당신의 이름은 ${userName}입니다.`); // 당신의 이름은 John입니다.

*/

let number = prompt('숫자 하나를 입력해주세요', '');

if(number < 0) {
	alert('-1');
} else if (number == 0) {
	alert('0');
} else {
	alert('1');
}