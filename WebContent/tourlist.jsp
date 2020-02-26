<%@page import="vo.TourVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.TourDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<meta charset="UTF-8">
<title>Insert title here</title>
<style>
@import url(//fonts.googleapis.com/earlyaccess/jejuhallasan.css);
table{border : 2px solid #5882FA;}
td, th{border : 2px solid #5882FA;}
</style>
<jsp:include page="/header.jsp"></jsp:include>
<script src="jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=bbd6a2cacbdfce9f9e94521adfd3d84e"></script>
<script type="text/javascript">
$(document).ready(function(){

});

function change_l(){
      form = document.tour;
      if(document.tour.location.value == "선택하세요"){
         form.theme_m.length=1;
      }
      if(document.tour.location.value == "제주시" || document.tour.location.value == "서귀포시" ){
         form.theme_m.length=1;
         form.theme_m.options[1] = new Option("전체");
         form.theme_m.options[1].value = "전체";
         form.theme_m.options[2] = new Option("음식");
         form.theme_m.options[2].value = "음식";
         form.theme_m.options[3] = new Option("축제");
         form.theme_m.options[3].value = "축제";
         form.theme_m.options[4] = new Option("관광");
         form.theme_m.options[4].value = "관광";
      }
   }

function change_m(){
   form = document.tour;
   if(document.tour.theme_m.value == "전체"){
      form.theme_s.length=1;
      form.theme_s.options[0] = new Option("전체");
      form.theme_s.options[0].value = "전체";
   }
   if(document.tour.theme_m.value == "음식"){
      form.theme_s.length=1;
      form.theme_s.options[0] = new Option("전체");
      form.theme_s.options[0].value = "전체";
      form.theme_s.options[1] = new Option("식당");
      form.theme_s.options[1].value = "식당";
      form.theme_s.options[2] = new Option("카페");
      form.theme_s.options[2].value = "카페";
   }
   if(document.tour.theme_m.value == "축제"){
      form.theme_s.length=1;
      form.theme_s.options[0] = new Option("전체");
      form.theme_s.options[0].value = "전체";
      form.theme_s.options[1] = new Option("축제");
      form.theme_s.options[1].value = "축제";
      form.theme_s.options[2] = new Option("체험");
      form.theme_s.options[2].value = "체험";
   }
   if(document.tour.theme_m.value == "관광"){
      form.theme_s.length=1;
      form.theme_s.options[0] = new Option("전체");
      form.theme_s.options[0].value = "전체";
      form.theme_s.options[1] = new Option("자연");
      form.theme_s.options[1].value = "자연";
      form.theme_s.options[2] = new Option("인문");
      form.theme_s.options[2].value = "인문";
   }
}

</script>
</head>
<body style="background-color: #E8FCFB">


<%
TourDAO dao = new TourDAO();
TourVO vo = new TourVO();

String location = request.getParameter("location");
String theme_m = request.getParameter("theme_m");
String theme_s = request.getParameter("theme_s");
String searchword = request.getParameter("searchword");

String input_themeM = "";
String input_themeS= "";
if(theme_m != null){
   if(theme_m.equals("전체")){
      input_themeM = "total";
   }else{
      input_themeM = theme_m;
   }
}

if(theme_s != null){
   if(theme_s.equals("전체")){
      input_themeS = "total";
   }else{
      input_themeS = theme_s;
   }
}

%>
<div class="container" style="margin-top: 30px;">
<form id="tour" name="tour" 
action="tourlist.jsp?location=<%=location%>&theme_m=<%=input_themeM%>&theme_s=<%=input_themeS%>&searchword=<%=searchword%>"
style="margin-left: 120px; margin-right: 400px;">
<h3><span class="label label-primary"> 대분류 </span></h3>
<select class="form-control" name ="location" onchange='change_l()'>
<option>선택하세요</option>
<option>제주시</option>
<option>서귀포시</option>
</select>


<h3><span class="label label-primary"> 중분류 </span></h3>
<select class="form-control" name ="theme_m" onchange='change_m()'>
<option></option>
</select>


<h3><span class="label label-primary"> 소분류 </span></h3> 
<select class="form-control" name ="theme_s">
<option></option>
</select><br>

<div style="float:left; width:500px">
<input  class="form-control"type="text" name="searchword">
</div>
<div style="float:right;">
<input style="height:35px;width:100px" class="btn btn-sm btn-default" type="submit" id="btn" value="검색하기">
</div></form></div>
<%if(session.getAttribute("dbid").equals("admin")) {
   %>   
   <br><div id="adminbtn2" style="margin-left: 1000px;">
   <input class="btn btn-default" type="button" value="여행지 정보 추가하기" style="margin-right: 5px;"  onclick="location.href='addinfo.jsp'">
   <input class="btn btn-default" type="button" value="관리자 메뉴 선택" onclick="location.href='admin.jsp'" 
   style="padding-left: 30px;  padding-right: 30px;"></div><%
} %>
<%
if(location == null){
%>
<div id="margin" style="
    margin-left: 180px;
    margin-right: 180px;">
<h3 style="font-family:Jeju Hallasan;">전체 여행지 정보 보기</h3>
<div class="table-responsive">
<table id="total" class="table table-striped">

<tr> <th>대분류</th> <th>중분류</th> <th>소분류</th> <th>관광지 이름</th> <th>주소</th> <th>정보 확인하기</th></tr>
<%
String pageString = request.getParameter("pagenum");
if(pageString == null){
   pageString = "1";
}
int currentpage = Integer.parseInt(pageString);
int recordPerPage = 10;
ArrayList<TourVO> totallist = dao.getTourList(currentpage, recordPerPage); 
for(int i = 0; i<totallist.size(); i++){
   vo = totallist.get(i);
   out.println("<tr>");
      out.println("<td>" + vo.getLocation() +"</td>");
      out.println("<td>" + vo.getTheme_m() +"</td>");
      out.println("<td>" + vo.getTheme_s() +"</td>");
      out.println("<td>"+ vo.getName() +"</td>");
      out.println("<td>" + vo.getAddress() +"</td>");
      out.println("<td><a href ="+"listdetail.jsp?tseq="+vo.getTseq()+">상세정보 확인하기</a></td>");
      out.println("</tr>");
}
%>
</table>
</div>
<%
int total = dao.getTotalTour();
int pagenum = total / 10;
if( total % 10 != 0){
   pagenum = pagenum + 1;
}
for(int i = 1; i<=pagenum; i++){
%>
 <a href="/gogojeju/tourlist.jsp?pagenum=<%=i %>"><%=i %></a> &nbsp;
<%
}
%>

<%
}//if end
else{
%>
<div style="width:50%;float:left;" class="table-responsive">
<h3 style="font-family:Jeju Hallasan;">선택한 여행지 정보 보기</h3>
<table class="table table-striped" id="select">
<tr> <th>대분류</th> <th>중분류</th> <th>소분류</th> <th>관광지 이름</th> <th>주소</th> <th>정보 확인하기</th></tr>
<%
ArrayList<TourVO> selectlist = dao.getTourList(location, input_themeM, input_themeS, searchword);
if(selectlist.size() == 0){
   out.println("<script>alert('조회 결과가 없습니다.'); location.href='/gogojeju/tourlist.jsp';</script>");
}

out.println("<h3 style=\"font-family:Jeju Hallasan;\">조회 결과 : " +selectlist.size() +"개</h3>");

for(int j = 0; j < selectlist.size(); j++){
   vo = selectlist.get(j);
   out.println("<tr>");
   out.println("<td>" + vo.getLocation() +"</td>");
   out.println("<td>" + vo.getTheme_m() +"</td>");
   out.println("<td>" + vo.getTheme_s() +"</td>");
   out.println("<td>" + vo.getName() +"</td>");
   out.println("<td>" + vo.getAddress() +"</td>");
   out.println("<td><a href ="+"listdetail.jsp?tseq="+vo.getTseq()+">상세정보 확인하기</a></td>");
   out.println("</tr>");
/*    String name = vo.getName();
   String x = vo.getX();
   String y = vo.getY(); */
}

//TourVO를 arraylist 에서 array로 바꿔줌       
TourVO [] array = selectlist.toArray(new TourVO[selectlist.size()]);
String[] arrname = new String[selectlist.size()];
String[] arrx = new String[selectlist.size()];
String[] arry = new String[selectlist.size()];
   

%>
</table>
</div>

<%
} //else end
%>


<!-- 선택항목 지도 표시 -->
<h3 style="font-family:Jeju Hallasan; color:white;">지도</h3>
<h3 style="font-family:Jeju Hallasan;">지도확인하기</h3>
<div id="map" style="width:50%;height:350px;float:right;"></div>
<p>
    <input type="checkbox" id="chkTerrain" onclick="setOverlayMapTypeId()" /> 지형정보 보기     
    <input type="checkbox" id="chkBicycle" onclick="setOverlayMapTypeId()" /> 자전거도로 정보 보기
</p>

<div style="display:none">
<%
ArrayList<TourVO> selectlist = dao.getTourList(location, input_themeM, input_themeS, searchword);
TourVO [] array = selectlist.toArray(new TourVO[selectlist.size()]);
String[] arrname = new String[selectlist.size()];
String[] arrx = new String[selectlist.size()];
String[] arry = new String[selectlist.size()];
   
   for(int k=0; k<array.length;k++){
         vo= array[k];
         
          arrname[k] = vo.getName();
          arrx[k]= vo.getX();
          arry[k]= vo.getY();
          
            out.println("<h6 id=name"+k+">" +arrname[k]+"</h6>");
            out.println("<h6 id=x"+k+">" +arrx[k]+"</h6>");
            out.println("<h6 id=y"+k+">" +arry[k]+"</h6>");
            out.println("<h6 id='length'>" +array.length+"</h6>");
    }
%>
</div>

<script>
var arrname  = new Array(parseInt(document.getElementById('length').innerHTML));
for (var i=0; i<document.getElementById('length').innerHTML;i++){
   arrname[i] = document.getElementById('name'+i).innerHTML;
}

var arrx  = new Array(parseInt(document.getElementById('length').innerHTML));
for (var i=0; i<document.getElementById('length').innerHTML;i++){
   arrx[i] = document.getElementById('x'+i).innerHTML;
}

var arry  = new Array(parseInt(document.getElementById('length').innerHTML));
for (var i=0; i<document.getElementById('length').innerHTML;i++){
   arry[i] = document.getElementById('y'+i).innerHTML;
} 


var mapContainer = document.getElementById('map'), // 지도를 표시할 div  
    mapOption = { 
        center: new kakao.maps.LatLng(33.362849, 126.529124), // 지도의 중심좌표
        level: 10 // 지도의 확대 레벨
    };

var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다


// 마커 이미지의 이미지 주소입니다
var imageSrc = "http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
    
for (var i = 0; i < document.getElementById('length').innerHTML; i ++) {
    
    // 마커 이미지의 이미지 크기 입니다
    var imageSize = new kakao.maps.Size(24, 35); 
    
    // 마커 이미지를 생성합니다    
    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
    
    // 마커를 생성합니다
     var marker = new kakao.maps.Marker({
        map: map, // 마커를 표시할 지도
        position: new kakao.maps.LatLng(arrx[i],arry[i]), // 마커를 표시할 위치
        title : arrname[i],// 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다 
        image : markerImage // 마커 이미지 
    }); 
var iwContent = '<div style="padding:5px;">'+arrname[i]+'</div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
iwPosition = new kakao.maps.LatLng(arrx[i],arry[i]); //인포윈도우 표시 위치입니다

//인포윈도우를 생성합니다
var infowindow = new kakao.maps.InfoWindow({
position : iwPosition, 
content : iwContent 
});

//마커 위에 인포윈도우를 표시합니다. 두번째 파라미터인 marker를 넣어주지 않으면 지도 위에 표시됩니다
infowindow.open(map, marker); 
}



var mapTypes = {
       terrain : kakao.maps.MapTypeId.TERRAIN,    
       bicycle : kakao.maps.MapTypeId.BICYCLE
   };

   // 체크 박스를 선택하면 호출되는 함수입니다
   function setOverlayMapTypeId() {
       var chkTerrain = document.getElementById('chkTerrain'),  
           chkBicycle = document.getElementById('chkBicycle');

       
       // 지도 타입을 제거합니다
       for (var type in mapTypes) {
           map.removeOverlayMapTypeId(mapTypes[type]);    
       }

       
       // 지형정보 체크박스가 체크되어있으면 지도에 지형정보 지도타입을 추가합니다
       if (chkTerrain.checked) {
           map.addOverlayMapTypeId(mapTypes.terrain);    
       }
       

       // 자전거도로정보 체크박스가 체크되어있으면 지도에 자전거도로정보 지도타입을 추가합니다
       if (chkBicycle.checked) {
           map.addOverlayMapTypeId(mapTypes.bicycle);    
       }
       
   }  
   


</script>

<input type=hidden name="tseq" value="<%=vo.getTseq()%>">

</div>
</body>
</html>