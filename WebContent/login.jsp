<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
@import url(//fonts.googleapis.com/earlyaccess/nanumbrushscript.css);
@import url(//fonts.googleapis.com/earlyaccess/jejuhallasan.css);
body{
<!--background-image:url('images/jeju.png');-->
background-repeat: repeat;
background-size: cover; 
background-position: center; 

}

</style>
<script src="jquery-3.2.1.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<script>

$(document).ready(function() {
   $("#join").on("click", function() {
      location.href="join.jsp";
      
   });
});



</script>
</head>
<body background="images/jeju.jpg">

<%   String cooid = "";
Cookie[] cookie =request.getCookies(); 
if(cookie != null){
	
   for(int i=0; i<cookie.length; i++) {
      if(cookie[i].getName().equals("cooid")){
    	
         cooid=cookie[i].getValue();
      }
   }
}
%>


<div>
<div class="container" style="margin-top: 30px;">
<h1 style="font-family:Jeju Hallasan;" class="form-signin-heading">자연이 빚어낸 환상의 섬 제주도에 오신 걸 환영합니다!</h1>
<h1 style="font-family: Nanum Brush Script;"> 혼저옵서예~~~</h1>
<form action="login" method="post" class="form-signin" style="margin-left: 0px; margin-right: 800px;margin-top: 20px;width: 300px;">
아이디  <input type="text" name="id" class="form-control" value="<%=cooid%>"><br>
비밀번호  <input type="pass

word" name="pw" class="form-control"><br>
<div style="float:right;">
<input type="checkbox" name="rememberId"> 아이디 기억하기 </div>
<input type="hidden" name="move" value="login">
<input type="submit" value="로그인" class="btn btn-lg btn-primary btn-block">
<input type="button" value="회원가입하기" id="join" class="btn btn-lg btn-primary btn-block">
</form>
</div>
</div>

</body>
</html>