<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<!-- jQuery 라이브러리 추가 (Ajax 요청 등에 활용 -->
	<script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
	</head>
	<body>
		<h3>Ajax 계산기</h3>
		<!-- 계산 입력 폼 -->
		<!-- form의 action은 calc2.jsp이나 
			jQuery에서 e.preventDefault() 로 실제 이동은 막고 Ajax로 처리 -->
		<form name="form1" id="form1" action="calc2.jsp" method="post">
			<input type="number" name="num1" size="5" required>
			<select name="operator">
				<option value="+" selected>+</option>
				<option value="-">-</option>
				<option value="*">*</option>
				<option value="/">/</option>
			</select>
			<input type="number" name="num2" size="5" required>
			<button type="submit">계산</button>
			<button type="reset">초기화</button>
		</form>
		<h3 id="result"></h3>
		<script>
			$("#form1").on("submit", function(e) {
				e.preventDefault();
				$.post('${pageContext.request.contextPath}/CalcAPIServlet',
						$('#form1').serialize(), function() {
					console.log("처리중입니다.");
				})
				.done(function(data) {
					$('#result').text(data.result);
					console.log("완료되었습니다.");
				});
			});
		</script>
	</body>
</html>