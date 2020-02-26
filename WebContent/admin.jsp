<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<jsp:include page="/header.jsp"></jsp:include>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="jquery-3.2.1.min.js"></script>
<script>
$(document).ready(function() {
	
});

</script>
</head>
<body>
	<div id="adminbtn"
		style="border-top-width: 300px; padding-top: 200px; padding-left: 500px;">
		<div class="col-xs-6 col-sm-3 placeholder">
			<img onclick="location.href='admin?move=userlist'"
				data-src="holder.js/200x200/auto/sky" class="img-responsive"
				alt="회원 정보 관리" src="images/admin1.jpg" data-holder-rendered="true">

		</div>
		<div class="col-xs-6 col-sm-3 placeholder">
			<img onclick="location.href='tourlist.jsp'"
				data-src="holder.js/200x200/auto/vine" class="img-responsive"
				alt="여행지 정보 관리" src="images/admin2.jpg" data-holder-rendered="true">

		</div>
	</div>


</body>
</html>