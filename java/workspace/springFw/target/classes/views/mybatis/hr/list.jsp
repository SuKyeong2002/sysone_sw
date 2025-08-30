<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- 필수 -> jsp는 템플릿으로 못만듦 -->
	<div style="width: 900px; margin-left: auto; margin-right: auto;">
		<h1>사원목록</h1>
		<!-- /hr/insert -->
		<a href="<c:url value='/hr/insert' />">신규사원등록</a> ${message }
		<table border="1">
			<thead>
				<tr>
					<th>EMPLOYEE_ID</th>
					<th>FIRST_NAME</th>
					<th>LAST_NAME</th>
					<th>EMAIL</th>
					<th>PHONE_NUMBER</th>
					<th>HIRE_DATE</th>
					<th>JOB_ID</th>
					<th>SALARY</th>
					<th>COMMISSION_PCT</th>
					<th>MANAGER_ID</th>
					<th>DEPARTMENT_ID</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="emp" items="${empList }">
					<tr>
						<!-- id로 상세조회 링크 걸기 -->
						<td><a href="<c:url value='/hr/${emp.employeeId}' />">${emp.employeeId}</td>
						<td>${emp.firstName}</td>
						<td>${emp.lastName}</td>
						<td>${emp.email}</td>
						<td>${emp.phoneNumber}</td>
						<td>${emp.hireDate}</td>
						<td>${emp.jobId}</td>
						<td>${emp.salary}</td>
						<td>${emp.commissionPct}</td>
						<td>${emp.managerId}</td>
						<td>${emp.departmentId}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
</body>
</html>