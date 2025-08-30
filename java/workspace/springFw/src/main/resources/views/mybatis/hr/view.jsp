<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	</head>
	<body>
		<h1>사원정보 상세</h1>
		<table border="1">
			<tr>
			    <th>FIRST_NAME</th>
			    <td>${emp.firstName}</td>
			</tr>
			<tr>
			    <th>LAST_NAME</th>
			    <td>${emp.lastName}</td>
			</tr>
			<tr>
			    <th>EMAIL</th>
			    <td>${emp.email}</td>
			</tr>
			<tr>
			    <th>PHONE_NUMBER</th>
			    <td>${emp.phoneNumber}</td>
			</tr>
			<tr>
			    <th>HIRE_DATE</th>
			    <td>${emp.hireDate}</td>
			</tr>
			<tr>
			    <th>JOB_ID</th>
			    <td>${emp.jobId}</td>
			</tr>
			<tr>
			    <th>SALARY</th>
			    <td>${emp.salary}</td>
			</tr>
			<tr>
			    <th>COMMISSION_PCT</th>
			    <td>${emp.commissionPct}</td>
			</tr>
			<tr>
			    <th>MANAGER_ID</th>
			    <td>${emp.managerId}</td>
			</tr>
			<tr>
			    <th>DEPARTMENT_ID</th>
			    <td>${emp.departmentId}</td>
			</tr>
		</table>
		
		<!-- href="#" : history 객체 사용 X 각각의 위치(페이지)마다 마킹 O -->
		<a href="<c:url value='/hr/update?empid=${emp.employeeId}' />">수정하기</a> &nbsp
		<a href="<c:url value='/hr/delete?empid=${emp.employeeId}' />">삭제하기</a> &nbsp
		<a href="<c:url value='/hr/list' />">리스트</a>
	</body>
</html>