package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import vo.TourVO;

public class TourDAO {
	
	   
   
   //선택 게시물 조회(검색어 없을 경우 / 있을 경우)
      public ArrayList<TourVO> getTourList(String location, String theme_m, String theme_s, String searchword){
         
         ArrayList<TourVO> list = new ArrayList<TourVO>();
         
         try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection con = DriverManager.getConnection("jdbc:oracle:thin:@192.168.15.79:1521:xe", "hr", "hr");
            
            String sql = "";
            PreparedStatement pt = null;
            ResultSet rs = null;
            
            if(searchword.equals("")) {
               
               if(theme_s.equals("total")) {
                  
                  if(theme_m.equals("total")) {
                     sql = "select tseq, location, theme_m, theme_s, name, address,x,y from Tour where location = ?";
                      pt = con.prepareStatement(sql);
                      pt.setString(1, location);
                      rs = pt.executeQuery();
                      }else {
                     sql = "select tseq, location, theme_m, theme_s, name, address,x,y from Tour where location = ? and theme_m = ?";
                      pt = con.prepareStatement(sql);
                      pt.setString(1, location);
                      pt.setString(2, theme_m);
                      rs = pt.executeQuery();
                  }
                                    
               }else {
                  sql = "select tseq, location, theme_m, theme_s, name, address,x,y from Tour where location = ? and theme_m = ? and theme_s = ?";
                   pt = con.prepareStatement(sql);
                   pt.setString(1, location);
                   pt.setString(2, theme_m);
                   pt.setString(3, theme_s);
                   rs = pt.executeQuery();
                  }
                
            }else {
               
               if(theme_s.equals("total")) {
                  
                  if(theme_m.equals("total")) {
                     sql = "select tseq, location, theme_m, theme_s, name, address,x,y from "
                           + "(select tseq, location, theme_m, theme_s, name, address, detail,x,y from tour where location = ?) T "
                           + "where T.address like('%'||?||'%') or T.name like('%'||?||'%') or T.detail like('%'||?||'%')";
                      pt = con.prepareStatement(sql);
                      pt.setString(1, location);
                      pt.setString(2, searchword);
                      pt.setString(3, searchword);
                      pt.setString(4, searchword);
                      rs = pt.executeQuery();
                  }else {
                     sql = "select tseq, location, theme_m, theme_s, name, address,x,y from "
                           + "(select tseq, location, theme_m, theme_s, name, address, detail,x,y from tour where location = ? and theme_m = ?) T "
                           + "where T.address like('%'||?||'%') or T.name like('%'||?||'%') or T.detail like('%'||?||'%')";
                      pt = con.prepareStatement(sql);
                      pt.setString(1, location);
                      pt.setString(2, theme_m);
                      pt.setString(3, searchword);
                      pt.setString(4, searchword);
                      pt.setString(5, searchword);
                      rs = pt.executeQuery();
                  }
                  
               }else {
                  sql = "select tseq, location, theme_m, theme_s, name, address,x,y from "
                        + "(select tse%q, location, theme_m, theme_s, name, address, detail,x,y from tour where location = ? and theme_m = ? and theme_s = ?) T "
                        + "where T.address like('%'||?||'') or T.name like('%'||?||'%') or T.detail like('%'||?||'%')";
                  pt = con.prepareStatement(sql); 
                  pt.setString(1, location);
                   pt.setString(2, theme_m);
                   pt.setString(3, theme_s);
                   pt.setString(4, searchword);
                   pt.setString(5, searchword);
                   pt.setString(6, searchword);
                   rs = pt.executeQuery();
               }
   
            }
                     
            while(rs.next()) {
               TourVO vo = new TourVO();
               vo.setTseq(rs.getInt("tseq"));
               vo.setLocation(rs.getString("location"));
               vo.setTheme_m(rs.getString("theme_m"));
               vo.setTheme_s(rs.getString("theme_s"));
               vo.setName(rs.getString("name"));
               vo.setAddress(rs.getString("address"));
               vo.setX(rs.getString("x"));
               vo.setY(rs.getString("y"));
               list.add(vo);
            }
            rs.close();
            pt.close();
            con.close(); 
            
         }catch(Exception e) {
            e.printStackTrace();
         }
         return list;
      }
   
   
   //페이징 처리 전체 게시물 조회
      public ArrayList<TourVO> getTourList(int currentPage, int recordPerPage){
         
         ArrayList<TourVO> list = new ArrayList<TourVO>();
         
         try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection con = DriverManager.getConnection("jdbc:oracle:thin:@192.168.15.79:1521:xe", "hr", "hr");
            
            String sql = "select * from Tour where tseq >= ? and tseq <= ?";
            PreparedStatement pt = con.prepareStatement(sql);
            int start = (currentPage-1)*recordPerPage+1;
            int end = currentPage * recordPerPage;
            pt.setInt(1, start);
            pt.setInt(2, end);
            ResultSet rs = pt.executeQuery();
            while(rs.next()) {
               TourVO vo = new TourVO();
               vo.setTseq(rs.getInt("tseq"));
               vo.setLocation(rs.getString("location"));
               vo.setTheme_m(rs.getString("theme_m"));
               vo.setTheme_s(rs.getString("theme_s"));
               vo.setName(rs.getString("name"));
               vo.setDetail(rs.getString("detail"));
               vo.setLink(rs.getString("link"));
               vo.setAddress(rs.getString("address"));
               vo.setImage(rs.getString("image"));
               vo.setX(rs.getString("x"));
               vo.setY(rs.getString("y"));
               list.add(vo);
            }
            rs.close();
            pt.close();
            con.close(); 
            
         }catch(Exception e) {
            e.printStackTrace();
         }
         return list;
      }
      
   //전체 게시물 갯수(페이징처리할 때 사용) 
   public int getTotalTour() {
      int total = 0;
      try {
         Class.forName("oracle.jdbc.driver.OracleDriver");
         Connection con = DriverManager.getConnection("jdbc:oracle:thin:@192.168.15.79:1521:xe", "hr", "hr");
         
         String sql ="select count(*) tseq from tour";
         PreparedStatement pt = con.prepareStatement(sql);
         ResultSet rs = pt.executeQuery();
         rs.next();
         total = rs.getInt("tseq");
         
         rs.close();
         pt.close();
         con.close();
      }catch(Exception e) {
         e.printStackTrace();
      }
      return total;
   }
      
   
   public TourVO getTourDetail(int tseq){
         TourVO vo = new TourVO();
         try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
         Connection con = DriverManager.getConnection("jdbc:oracle:thin:@192.168.15.79:1521:xe","hr","hr");
      
         //게시물내용 보이기
         String sql="select * from tour where tseq=?";
         PreparedStatement pt = con.prepareStatement(sql);
         pt.setInt(1, tseq);
         ResultSet rs = pt.executeQuery();
         
         rs.next();
         vo.setName(rs.getString("name"));
         vo.setDetail(rs.getString("detail"));
         vo.setImage(rs.getString("image"));
         vo.setLocation(rs.getString("location"));
         vo.setAddress(rs.getString("address"));
         vo.setX(rs.getString("x"));
         vo.setY(rs.getString("y"));

         rs.close();
         pt.close();
         con.close();
         } catch(Exception e) {
            e.printStackTrace();
         }
         return vo;
      }

}