<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
	</head>
	<body>
		${message}
		<c:url var="actiontUrl" value="/upload/updateDir" />	
		<form name="form01" id="form01" action="${actiontUrl }" method="post">
		<table border="1">
			<thead>
				<tr>
					<th>ID</th>
					<th>경로</th>
					<th>파일명</th>
					<th>크기</th>
					<th>유형</th>
					<th>날짜</th>
					<th>삭제</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach var="file" items="${fileList}">
				<tr>
					<td>
						<label><input type="checkbox" name="fileIds" value="${file.fileId}"/>
							${file.fileId}
						</label>
					</td>
					<td>${file.directoryName}</td>
					<td>
						<c:url var="contentUrl" value="/file/${file.fileId}" />	
						<%-- 확장자 --%>
						<c:set var="len" value="${fn:length(file.fileName)}" />
						<c:set var="filetype" value="${fn:toUpperCase(fn:substring(file.fileName, len-4, len))}" />
						<c:choose>
							<c:when test="${(filetype eq '.JPG') or (filetype eq '.GIF') or (filetype eq '.PNG') }">
								<img src="" style="width: 100px;">${file.fileName}
							</c:when>
							<c:otherwise>
								<a href="${contentUrl}">${file.fileName}</a>
							</c:otherwise>
						</c:choose>
					</td>
					<td><fmt:formatNumber value="${file.fileSize / 1024}" pattern="###,###,###"/>KB</td>
					<td>${file.fileContentType}</td>
					<td><fmt:formatDate value="${file.fileUploadDate}" pattern="yyyy-MM-dd" /></td>
					<td>
						<c:url var="deleteUrl" value="/upload/delete/${file.fileId}" />	
						<a href="${deleteUrl}" class="delete">삭제</a>
					</td>
				</tr>
			</tbody>
			</c:forEach>
		</table>
		
		<div>
			선택한 파일을
			<select name="directoryName">
	            <option value="/">/</option>
	            <option value="/images">/이미지</option>
	            <option value="/data">/자료실</option>
	            <option value="/bigdata">/빅데이터</option>
	            <option value="/common">/공통</option>
        		</select>(으)로 <input type="submit" value="이동">
		</div>
		</form>
		
		<p>
			<a href='<c:url value="/upload/new"/>'>업로드</a>
      		<a href='<c:url value="/upload"/>'>처음으로</a>
		</p>
		
		<!-- DOM 이 완성된 이후 실행되는 것을 보장하기 위함 -->
		<script>
			// 요소 선택자
			$('.delete').on('click', function(){
				// alert($(this).attr('href'));
				if (confirm('이 작업은 되돌릴 수 없습니다. 파일을 삭제하시겠습니까?')) {
					return true;
				} else {
					return false;	
				}
			});
			
			// 아무것도 선택 안됐을 경우 or 됐을 경우
			$('#form01').on('submit', function(e){
				// 더이상 서버로 데이터 이동 X (submit 중단)
				e.preventDefault();
				let cnt = $('input[name="fileIds"]:checked').length;
				console.log(cnt);
				
				if (cnt > 0) {
					$(this).unbind('submit').submit();
				} else {
					alert('이동할 파일을 선택해주세요.');
				}
				
			})
		</script>
	</body>
</html>