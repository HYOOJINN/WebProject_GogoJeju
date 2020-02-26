<%@page import="vo.ReviewVO"%>
<%@page import="dao.ReviewDAO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="jquery-3.2.1.min.js"></script>
<script>
$(document).ready(function(){
   $("#addreviewbtn").on('click',function(){
      //alert("클릭");
      requestAjax();
   });
});
function requestAjax(){
   //id="pagenum" 입력값을 전달, get방식으로, boardadd.jsp에 요청
   //boardadd.jsp 파일은 pagenum에 해당하는 5개 목록 json 결과 응답
   //응답받은 이후에 id="addlist" 태그 내부 append/text/html 함수 출력
   $.ajax({
      url:'reviewsave.jsp',
      type:'get',
      data:{'review':$("#review").val()},
      dataType:'text',
      success:function(server_data){
         //obj = JSON.parse(server_data);
         server_array = JSON.parse(server_data);
      //   alert();
         for(var i=0; i<server_array.length; i++){
            
            if(server_array[server_array.length-1].result==1){
               $("tr:first").after("<tr><td>"+server_array[i].id
                     +"</td><td>"+server_array[i].review+"</td><td>"
                     +server_array[i].tseq+"</td><td>"+server_array[i].rseq+"</td></tr>");
               alert("리뷰가 작성되었습니다.");
               
            } else if(server_array[server_array.length-1].result==0){
               alert("한 ID당 하나의 리뷰만 작성 가능합니다.");
            }
         }
      },
      error:function(){},
      complete:function(){}
   });
}
</script>
</head>
<body>

<%

//리뷰테이블 리스트로 가져오기
ReviewDAO dao = new ReviewDAO();
int tseq = Integer.parseInt(session.getAttribute("tseq").toString());
ArrayList<ReviewVO> list = dao.getReviewList(tseq);
%>
<table border=3>
<caption></caption>
<tr><th>작성자</th><th>리뷰내용</th><th>투어코드</th><th>리뷰코드</th></tr>
<%
//가져온 리뷰리스트 보여주기 for문
for(int i=0; i<list.size(); i++){
   out.println("<tr><td>"+list.get(i).getId()+"</td><td>"+list.get(i).getReview()
         +"</td><td>"+list.get(i).getTseq()+"</td><td>"+list.get(i).getRseq()+"</td></tr>");
}

%>
<%=session.getAttribute("tseq")%>
<%=session.getAttribute("dbid")%>
<%=session.getAttribute("name")%>
</table>
리뷰작성:<br>

<textarea style="margin: 0px; height: 200px; width: 400px;" id="review" name="review"></textarea><br>
<input type="button" id="addreviewbtn" value="리뷰작성">


<!-- Ajax 안썻을때 
<form action=reviewsave.jsp>
<textarea style="margin: 0px; height: 200px; width: 400px;" id="review" name="review"></textarea><br>
<input type="submit" id="addreviewbtn" value="리뷰작성">
</form>
-->

</body>
</html>