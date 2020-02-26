package servelt;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;

import dao.MemberDAO;
import vo.MemberVO;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
   protected void doPost(HttpServletRequest request, HttpServletResponse response)
         throws ServletException, IOException {
      request.setCharacterEncoding("utf-8");

      String move = request.getParameter("move");
      String id = request.getParameter("id");
      String pw = request.getParameter("pw");
      String rememberId = request.getParameter("rememberId");
      String path = "";
      HttpSession session = request.getSession();
      Cookie cookie = null;
      response.setContentType("text/html; charset=utf-8");
      PrintWriter out = response.getWriter();
      // System.out.println(rememberId);

      if (move.equals("login")) {// 로그인일때
         MemberVO vo = new MemberVO();
         vo.setId(id);
         vo.setPw(pw);
         MemberDAO dao = new MemberDAO();
         String dbid = dao.login(vo);
         if (dbid == null || dbid.equals("")) {
            // 로그인 실패시 로그인화면으로 이동

            out.println(
                  "<script>alert('아이디 혹은 비밀번호를 확인하여 주십시오.');" + " location.href='/gogojeju/login.jsp'</script>");
         } else { // 로그인 성공
            if (dbid.equals("admin") || id.equals("admin")) {
               path = "admin.jsp";
            } else {
               path = "/tourlist.jsp";
            }
            session.setAttribute("dbid", dbid); // dbid=로그인 된 아이디
            if (rememberId != null && rememberId.equals("on")) {
               cookie = new Cookie("cooid", id);

            } else {
               cookie = new Cookie("cooid", id);
               cookie.setMaxAge(0);
            }
            response.addCookie(cookie);
            RequestDispatcher rd = request.getRequestDispatcher(path);
            rd.forward(request, response);

         }
      } else if (move.equals("join")) {// 회원가입일때
         id = request.getParameter("id");
         pw = request.getParameter("pw");
         String name = request.getParameter("name");
         String phone = request.getParameter("phone");
         String email = request.getParameter("email");
         path = null;
         MemberVO vo = new MemberVO();
         vo.setId(id);
         vo.setPw(pw);
         vo.setName(name);
         vo.setPhone(phone);
         vo.setEmail(email);

         MemberDAO dao = new MemberDAO();
         int rs = dao.join(vo);

         if (rs == 1) { // 회원가입 성공
            out.println(
                  "<script>alert('회원가입 성공했습니다. 로그인을 해주세요.');" + " location.href='/gogojeju/login.jsp'</script>");
         } else {
            path = "/join.jsp";
         }
         response.setCharacterEncoding("utf-8");
         RequestDispatcher rd = request.getRequestDispatcher(path);
         rd.forward(request, response);

      } else if (move.equals("idCheck")) {// 아이디중복검사
         int i = 0;
         id = request.getParameter("id");
         path = null;
         String result = null;
         JSONObject obj = new JSONObject();
         MemberDAO dao = new MemberDAO();
         int rs = dao.idCheck(id);
         if (rs != 0) { // 아이디 중복일때
            i = 1;
            obj.put("result", i);
            response.setContentType("application/x-json; charset=UTF-8");
            response.getWriter().print(obj);
         } else {
            obj.put("result", i);
            response.setContentType("application/x-json; charset=UTF-8");
            response.getWriter().print(obj);
         }
      } else {

      }

   }

}