<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="dao.ReviewDAO"%>
<%@page import="vo.ReviewVO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%--
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
    --%>
<%
String id=session.getAttribute("dbid").toString();
String review = request.getParameter("review");
   //out.println(review);
int tseq=Integer.parseInt(session.getAttribute("tseq").toString());
   //out.println(tseq);

ReviewVO vo = new ReviewVO();

vo.setId(id);
vo.setReview(review);
vo.setTseq(tseq);


ReviewDAO dao = new ReviewDAO();
int result=dao.insertReview(vo);




ArrayList<ReviewVO> list = dao.afterInsertReview(tseq);

JSONArray array = new JSONArray();

for(int i = 0; i < list.size(); i++){
   JSONObject one_json = new JSONObject();
   ReviewVO vo2 = list.get(i);
   one_json.put("id", vo2.getId());
   one_json.put("tseq", vo2.getTseq());
   one_json.put("review", vo2.getReview()); 
   one_json.put("rseq", vo2.getRseq());
   one_json.put("result", result);
   array.add(one_json);
}
%>

<%=array.toJSONString() %>

<%//response.sendRedirect("reviewlist.jsp");%>
<%--
 </body>
</html>
 --%>