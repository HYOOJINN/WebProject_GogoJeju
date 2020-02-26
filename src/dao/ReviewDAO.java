package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import vo.ReviewVO;

public class ReviewDAO {
   //리뷰리스트
   public ArrayList<ReviewVO> getReviewList(int tseq) {
      ArrayList<ReviewVO> list = new ArrayList<ReviewVO>();
      try {
         Class.forName("oracle.jdbc.driver.OracleDriver");
         Connection con = DriverManager.getConnection("jdbc:oracle:thin:@192.168.15.79:1521:xe", "hr", "hr");
         String sql = "select * from tourreview where tseq=? order by rseq desc";
         
         PreparedStatement pt = con.prepareStatement(sql);
         pt.setInt(1, tseq);
         ResultSet rs = pt.executeQuery();
         while (rs.next()) {
            ReviewVO vo = new ReviewVO();
            vo.setId(rs.getString("id"));
            vo.setReview(rs.getString("review"));
            vo.setTseq(rs.getInt("tseq"));
            vo.setRseq(rs.getInt("rseq"));
      
            list.add(vo);
         }
         rs.close();
         pt.close();
         con.close();
      } catch (Exception e) {
         e.printStackTrace();
      }
      return list;
   }
   
   public int insertReview(ReviewVO vo){
      Connection con = null;
      PreparedStatement pt = null;
      ResultSet rs = null;
      int result = 0;
      String message = null;
      
      try {
      Class.forName("oracle.jdbc.driver.OracleDriver");
      con = DriverManager.getConnection
      ("jdbc:oracle:thin:@192.168.15.79:1521:xe","hr","hr");
      
      String id = vo.getId(); // DTO담겨있어서 장바구니에 있는거 get으로 꺼냈어
      //String review = vo.getReview();
      int tseq = vo.getTseq();
      //int rseq = vo.getRseq();
      
      // 중복검사
      String sql = "select * from tourreview where id=? and tseq=?";
      pt = con.prepareStatement(sql);
      pt.setString(1, id); // id=DTO(장바구니)에 담긴 아이디
      pt.setInt(2, tseq);
      rs = pt.executeQuery(); // 쿼리문 디비에 날려 ResultSet형태로 결과를 받음
      if (rs.next()) { // true:쿼리문결과인 rs에 컬럼담겨있다, false:쿼리문결과인 rs에 컬럼없다.
      // rs.next()=true면, 아이디중복!
         message = "아이디 중복!";
         System.out.println(message);
      } else { //아이디 중복X
         String sqlin = "insert into tourreview values(?,?,? ,(select max(rseq)+1 from tourreview))";
         pt = con.prepareStatement(sqlin);
         pt.setString(1, vo.getId());
         pt.setInt(2, vo.getTseq());
         pt.setString(3, vo.getReview());
         if (result == 1) {
            message = "insert 성공!";
         }
         System.out.println("#####"+vo.getReview());
         result = pt.executeUpdate();
      
         con.close();
      }
      }catch(Exception e) {
         e.printStackTrace();
         System.out.println("test");
      }
      return result;
      
   }
   
   public ArrayList<ReviewVO> afterInsertReview(int tseq) {
      ArrayList<ReviewVO> list = new ArrayList<ReviewVO>();
      try {
         Class.forName("oracle.jdbc.driver.OracleDriver");
         Connection con = DriverManager.getConnection("jdbc:oracle:thin:@192.168.15.79:1521:xe", "hr", "hr");
         String sql = "select * from tourreview"
               + " where tseq=? and rseq=(select max(rseq) from tourreview)"
               + " order by rseq desc";
         
         PreparedStatement pt = con.prepareStatement(sql);
         pt.setInt(1, tseq);
         ResultSet rs = pt.executeQuery();
         
         while (rs.next()) {
            ReviewVO vo = new ReviewVO();
            vo.setId(rs.getString("id"));
            vo.setReview(rs.getString("review"));
            vo.setTseq(rs.getInt("tseq"));
            vo.setRseq(rs.getInt("rseq"));
      
            list.add(vo);
         }
         rs.close();
         pt.close();
         con.close();
      } catch (Exception e) {
         e.printStackTrace();
      }
      return list;
   }
   
   
}