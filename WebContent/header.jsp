<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="jquery-3.2.1.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
</head>
<body>

   
<% if(session.getAttribute("dbid")==null){
%>
   <div id=divv style="float:right;">
   <form style="text-align:right">
      <input type="button" value="로그인" onclick="location.href='login.jsp'">
      <input type="button" value="회원가입" onclick="location.href='join.jsp'">
   </form>
   </div>

<%
} else {
%>    
<div id=frm style="float:right;margin-right: 100px;">
<%=session.getAttribute("dbid")%>님 환영합니다!&nbsp;
<input class="btn btn-default" type='button' value='로그아웃' onclick='logout()'>
 </div>
<%} 
%>
</body>
<script>


function logout() {
   var logoutFlag = confirm("로그아웃 하시겠습니까?");
   if(logoutFlag) {
      location.href="invalidate.jsp"
   }
};
</script>
</html>