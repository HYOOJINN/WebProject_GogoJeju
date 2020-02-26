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

<script>

function erchk() {
	var flag =validation(); // 유효성 검사를 한 값
	if(flag){
		
		document.sub1.submit();
	}
};

$(function(){
	    $('#userPw').keyup(function(){
       		$('#chkNotice').html('');
    	});
	      
    $('#userPwChk').keyup(function(){

        if($('#userPw').val() != $('#userPwChk').val()){
          $('#chkNotice').text('비밀번호 일치하지 않음');
          $('#chkNotice').css('color', 'red');
          $("#chkNotice").css("font-size", "13px");
          $('#join').prop('disabled', true); 

        } else{
          $('#chkNotice').text('비밀번호 일치함');
          $('#chkNotice').css('color', 'blue');
          $("#chkNotice").css("font-size", "13px");
          $('#join').prop('disabled', false);
        }

    });
    
    //아이디 유효성 검사(1 = 중복 / 0 != 중복)
    $("#id").keyup(function() {
    	var id = $('#id').val();
    	$.ajax({
    		url : '/gogojeju/login?id='+ id+'&move=idCheck',
    		type : 'post',
    		dataType : 'json',
    		success : function(data) {
    			console.log("1 = 중복o / 0 = 중복x : "+ data);							
    			if (data.result == 1) {
    					// 1 : 아이디가 중복되는 문구
    					$("#id_check").text("사용중인 아이디입니다");
    					$("#id_check").css("color", "red");
    					$("#id_check").css("font-size", "13px");
    					$("#join").attr("disabled", true);
    				} else {
    						$('#id_check').text('사용가능한 아이디입니다.');
    						$('#id_check').css('color', 'blue');
    						$("#id_check").css("font-size", "13px");
    						$("#join").attr("disabled", true);				
    				}
    			}, error : function(e) {
    					console.log(e);
    			}
    		});
    	});
});
//validation 체크 (유효성 검사) -- 데이터가 정확히 들어갔는지
 function  validation(){
	 var flag = false;
	if($("#id").val() == "" ){
		alert("아이디칸이 비었습니다");
	}else if($("#userPw").val() == "" ){
		alert("비밀번호칸이 비었습니다");
	}else if($("#name").val() == "" ){
		alert("이름칸이 비었습니다");
	}else if($("#phone").val() == "" ){
		alert("전화번호칸이 비었습니다");
	}else if($("#email").val() == "" ){
		alert("이메일칸이 비었습니다");
	}else{
		flag = true;
	} return flag;
}
</script>
</head>
<body>
<div class="container">
<h2 class="form-signin-heading">회원가입 화면</h2>
<form action="login" method="post" name="sub1" class="form-signin">
아이디 : <input type="text" id="id" name="id" class="form-control">&nbsp;
<span id="id_check"></span><br>
비밀번호 : <input type="password" id="userPw" name="pw" class="form-control"><br>
비밀번호 확인 : <input type="password" id="userPwChk" class="form-control">&nbsp; 
<span id="chkNotice"></span><br>
이름 : <input type="text" name="name" id="name" class="form-control"><br>
전화번호 : <input type="text" name="phone" id="phone" class="form-control"><br> 
이메일 : <input type="email" name="email" id="email" class="form-control"><br>
<input type="hidden" name="move" value="join">
<div style="float: left;width:45%;">
<input type="button" value="회원가입" id="join" disabled="disabled"
onclick="erchk()" class="btn btn-lg btn-primary btn-block">
</div>
<div style="float: right;width:45%;">
<input type="button" value="로그인 하러 가기" 
onclick="location.href='login.jsp'" class="btn btn-lg btn-primary btn-block">
</div>
</form>
</div>
</body>
</html>