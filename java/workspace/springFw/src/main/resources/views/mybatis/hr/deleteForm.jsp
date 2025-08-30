<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	</head>
	<body>
	<h1>사원정보 삭제</h1>
	<form action="./delete" method="post">
	${message}
	<p>
		${emp.employeeId}사원의 사원명 ${emp.firstName} ${emp.lastName}의 사원정보를 삭제하겠습니다.<br/>
		삭제 후 데이터는 복구할 수 없습니다. 이메일을 입력해주세요.
	</p>
		<table border="1">
			<tr>
			    <th>EMPLOYEE_ID</th>
			    <td><input type="number" name="empid" max="99999" value="${emp.employeeId}" readonly></td>
			</tr>
			<tr>
			    <th>EMAIL</th>
			    <td><input type="email" name="email" value="" required></td>
			</tr>
			<tr>
				<td></td>
				<td>
					<button type="submit">사원삭제</button>
				</td>
			</tr>
		</table>
	</form>
	</body>
</html>