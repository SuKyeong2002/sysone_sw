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
		<li><a href="<c:url value='/upload/new' />">파일 업로드</a></li>
		<li><a href="<c:url value='/upload/list' />">파일 전체 목록</a></li>
		<li><a href="<c:url value='/upload/list/bigdata' />">빅데이터</a></li>
		<li><a href="<c:url value='/upload/gallery' />">갤러리</a></li>
	</body>
</html>