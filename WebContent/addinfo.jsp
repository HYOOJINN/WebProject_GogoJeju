<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="jquery-3.2.1.min.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<jsp:include page="/header.jsp"></jsp:include>
<script>
	
</script>
</head>
<body style="margin-top: 30px">

	<div class="container">
		<p class="form-signin-heading" style="font-size: 2.5em;">여행지 정보
			등록하기</p>
		<input type="button" value="돌아가기"
			class="btn btn-lg btn-primary btn-block"
			onclick="location.href='tourlist.jsp'"
			style="width: 134px; margin-left: 1000px;">
		<form action="admin" class="form-signin">
			대분류 <input type="text" name="location" class="form-control"><br>
			중분류 <input type="text" name="theme_m" class="form-control"><br>
			소분류 <input type="text" name="theme_s" class="form-control"><br>
			이름 <input type="text" name="name" class="form-control"><br>
			설명 <input type="text" name="detail" class="form-control"><br>
			링크 <input type="text" name="link" class="form-control"><br>
			주소 <input type="text" name="address" class="form-control"><br>
			사진 <input type="file" name="image" class="form-control"><br>
			<input type=hidden name="move" value="addinfo"> <input
				type="submit" value="등록" class="btn btn-lg btn-primary btn-block"
				style="width: 334px; margin-left: 350px;">
		</form>
	</div>

</body>
</html>