package servelt;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import dao.AdminDAO;
import vo.MemberVO;
import vo.TourVO;

@WebServlet("/admin")
public class AdminServlet extends HttpServlet {

   protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      request.setCharacterEncoding("utf-8");
      response.setContentType("text/html; charset=utf-8");
      String path = "";
      String move = request.getParameter("move");
      AdminDAO dao = new AdminDAO();
      String id = request.getParameter("id");
      if(move.equals("userlist")) {
         ArrayList<MemberVO> user = dao.userlist();
         request.setAttribute("userlist", user);
         path="userlist.jsp";
         RequestDispatcher rd = request.getRequestDispatcher(path);
         rd.forward(request, response);
         
      }else if(move.equals("delete")) {
         int rs = dao.deleteuser(id);
         JSONObject obj = new JSONObject();
         if(rs>0) {
            obj.put("result", 1);
         }else {
            obj.put("result", 0);
         }
         response.setContentType("application/x-json; charset=UTF-8");
         response.getWriter().print(obj);
      }else if(move.equals("addinfo")) {
         PrintWriter out = response.getWriter();
         TourVO vo = new TourVO();
         vo.setLocation(request.getParameter("location"));
         vo.setTheme_m(request.getParameter("theme_m"));
         vo.setTheme_s(request.getParameter("theme_s"));
         vo.setName(request.getParameter("name"));
         vo.setDetail(request.getParameter("detail"));
         vo.setLink(request.getParameter("link"));
         vo.setAddress(request.getParameter("address"));
         vo.setImage(request.getParameter("image"));
         GetLocation getLoc = new GetLocation();
         TourVO tourvo = getLoc.getlocation(request.getParameter("address"));
         vo.setX(tourvo.getX());
         vo.setY(tourvo.getY());
         int rs = dao.addinfo(vo);
         if(rs>0) {
            
            out.println("<script>alert('등록되었습니다'); location.href='tourlist.jsp';</script>");
            
         }else {
            out.println("<script>alert('등록 실패했습니다');location.href='addinfo.jsp'; </script>");
            
         }
      }
      
      
   }

}