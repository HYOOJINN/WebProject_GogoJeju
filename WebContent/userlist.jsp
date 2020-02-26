<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
 
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

 <jsp:include page="/header.jsp"></jsp:include>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="jquery-3.2.1.min.js"></script>
<script>
function deleteuser(id){
	var logoutFlag = confirm("선택한 회원을 탈퇴시키겠습니까?");
	if(logoutFlag) {
		$.ajax({
    		url : '/gogojeju/admin?id='+ id+'&move=delete',
    		type : 'get',
    		dataType : 'json',
    		success : function(data) {
    			if(data.result>0) {
    				console.log(id);
    				alert("탈퇴되었습니다.");
    				location.href='/gogojeju/admin?move=userlist&id=admin';
        			
    			}else{
    				alert("탈퇴 실패했습니다.");
    			}
    			}, error : function(e) {
    					console.log(e);
    			}
    		});
	}
}

</script>
</head>
<body style="margin-top: 50px; margin-left: 50px; margin-right: 50px;">


<h1>회원정보</h1>

<div class="table-responsive">
<table class="table table-striped"><tr><th>아이디</th><th>이름</th><th>전화번호</th><th>이메일</th><th>관리</th></tr>
<c:forEach items="${userlist }" var="membervo"> 
<h3><tr><td>${membervo.id }
</td><td>${membervo.name }
</td><td>${membervo.phone }
</td><td> ${membervo.email }

</td><td> <input type="button" value="탈퇴" onclick="deleteuser('${membervo.id}')">
</td></tr>
</h3>
</c:forEach>
</table></div>
<input type="button" value="관리자 메뉴" onclick="location.href='admin.jsp'">
</body>
</html>