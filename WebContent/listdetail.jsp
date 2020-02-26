<%@page import="dao.TourDAO"%>
<%@page import="vo.TourVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/header.jsp"></jsp:include>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
@import url(//fonts.googleapis.com/earlyaccess/jejuhallasan.css);
body{background-color: #E8FCFB}
table{border: 2px solid #5882FA;}
#img{text-align: center;}
tr{border: 2px solid #5882FA;}
td{border: 2px solid #5882FA;}


</style>
<script src="/jquery/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=bbd6a2cacbdfce9f9e94521adfd3d84e"></script>

</head>
<body style="
    margin-top: 0px;
    margin-left: 50px;
    margin-right: 50px;
    
">
<%
int tseq=Integer.parseInt(request.getParameter("tseq"));
TourDAO dao = new TourDAO();
TourVO vo = dao.getTourDetail(tseq);
%>
<h1 style="font-family:Jeju Hallasan;"><%= vo.getName()%></h1>
<div class="table-responsive">
<table class="table table-striped">
<%
out.println("<tr>");
out.println("<td rowspan=2 id='img' style='border-left-width: 2px; padding-left: 8px;'><img src=\"images/"+vo.getImage()+"\"width=\"350\" height=\"300\"></td>");
out.println("<td>"+vo.getAddress()+"</td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td id='map' style='width:400px;height:300px;'></td>");

out.println("</tr>");
out.println("<tr>");
out.println("<td colspan=2>"+vo.getDetail()+"</td>");
out.println("</tr>");

String name = vo.getName();
String x = vo.getX();
String y = vo.getY();
session.setAttribute("tseq",tseq);
session.setAttribute("name", name);
%>
</table>
</div>
<form action="reviewlist.jsp">
<input type=submit value="리뷰보기" name="goreview" id="goreview">
<input type=button value="글목록" onclick="location.href='tourlist.jsp'">
</form><br>


   <script>
      var name = "<%= name%>";
      var x = "<%= x %>";
      var y = "<%= y %>";
      
      var container = document.getElementById('map');
      var options = {
         center: new kakao.maps.LatLng(x,y),
         level: 3
      };

      var map = new kakao.maps.Map(container, options);
      
      // 마커가 표시될 위치
      var markerPosition  = new kakao.maps.LatLng(x,y); 
      // 마커를 생성
      var marker = new kakao.maps.Marker({
          position: markerPosition
      });
      // 마커가 지도 위에 표시되도록 설정
      marker.setMap(map);
      
       var iwContent = '<div style="padding:5px;">'+name+'<br><a href="https://map.kakao.com/link/to/'+name+','+x+','+y+'" style="color:blue" target="_blank">길찾기</a></div>',
      iwPosition = new kakao.maps.LatLng(x, y); //인포윈도우 표시 위치입니다

      // 인포윈도우를 생성합니다
      var infowindow = new kakao.maps.InfoWindow({
          position : iwPosition, 
          content : iwContent 
      });
        
      // 마커 위에 인포윈도우를 표시합니다. 두번째 파라미터인 marker를 넣어주지 않으면 지도 위에 표시됩니다
      infowindow.open(map, marker); 
         
   </script>

</body>
</html>