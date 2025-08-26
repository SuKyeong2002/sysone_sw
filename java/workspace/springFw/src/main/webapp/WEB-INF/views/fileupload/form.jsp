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
	<c:url var="actionUrl" value="/upload/new" />
		<form action="${actionUrl }" method="post" enctype="multipart/form-data">
			<select name="dir">
				<option value="/">/</option>
	            <option value="/images">/이미지</option>
	            <option value="/data">/자료실</option>
	            <option value="/bigdata">/빅데이터</option>
	            <option value="/common">/공통</option>
			</select>
			<input type="file" name="file">
			<button type="submit">등록</button>
			<button type="reset">초기화</button>
		</form>
	</body>
</html>