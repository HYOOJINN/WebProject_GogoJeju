package dao;


import static java.sql.DriverManager.getConnection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import vo.MemberVO;
import vo.TourVO;

public class AdminDAO {
	
	public ArrayList<MemberVO> userlist() {
		ArrayList<MemberVO> user = new ArrayList();
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection con = getConnection("jdbc:oracle:thin:@192.168.15.79:1521:xe", "hr", "hr");
			String sql = "select id, name, phone, email from tourmember where id <> 'admin'";
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				String id = rs.getString("id");
				String name = rs.getString("name");
				String phone = rs.getString("phone");
				String email = rs.getString("email");
				MemberVO vo = new MemberVO();
				vo.setId(id);
				vo.setName(name);
				vo.setPhone(phone);
				vo.setEmail(email);
				user.add(vo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return user;
	}
	
	public int deleteuser(String id) {
		int rs = 0;
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection con = getConnection("jdbc:oracle:thin:@192.168.15.79:1521:xe", "hr", "hr");
			String sql1 = "delete from tourreview where id = ?";
			String sql2 = "delete from tourmember where id = ?";
			PreparedStatement ps1 = con.prepareStatement(sql1);
			PreparedStatement ps2 = con.prepareStatement(sql2);
			ps1.setString(1, id);
			ps2.setString(1, id);
			ps1.executeUpdate();
			rs =ps2.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
			return rs;	
	}
	public int addinfo(TourVO vo) {
		int rs=0;
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection con = getConnection("jdbc:oracle:thin:@192.168.15.79:1521:xe", "hr", "hr");
			String sql = "insert into tour values(tour_seq.nextval,?,?,?,?,?,?,?,?,?,?)";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, vo.getLocation());
			ps.setString(2, vo.getTheme_m());
			ps.setString(3, vo.getTheme_s());
			ps.setString(4, vo.getName());
			ps.setString(5, vo.getDetail());
			ps.setString(6, vo.getLink());
			ps.setString(7, vo.getAddress());
			ps.setString(8, vo.getImage());
			ps.setString(9, vo.getY());
			ps.setString(10, vo.getX());
			rs = ps.executeUpdate();
		}catch(Exception e) {
		}
		return rs;
	}
}
