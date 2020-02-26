package dao;

import static java.sql.DriverManager.getConnection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import vo.MemberVO;

public class MemberDAO {

	public String login(MemberVO vo) {
		// null 과 "" 는 다르다.
		String dbid = null;
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection con = getConnection("jdbc:oracle:thin:@192.168.15.79:1521:xe", "hr", "hr");
			String sql = "select id from tourmember where id = ? and pw = ?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, vo.getId());
			ps.setString(2, vo.getPw());
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				dbid = rs.getString("id");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dbid;
	}

	public int join(MemberVO vo) {
		int result = 0;
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection con = getConnection("jdbc:oracle:thin:@192.168.15.79:1521:xe", "hr", "hr");
			String sql = "insert into tourmember values(?,?,?,?,?)";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, vo.getId());
			ps.setString(2, vo.getPw());
			ps.setString(3, vo.getName());
			ps.setString(4, vo.getPhone());
			ps.setString(5, vo.getEmail());
			result = ps.executeUpdate();

			if (result == 1) {
				result = 1;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	public int idCheck(String id) {
		int count = 0;
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection con = getConnection("jdbc:oracle:thin:@192.168.15.79:1521:xe", "hr", "hr");
			String sql = "select id from tourmember where id = ?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, id);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				count=1;
			}

		} catch (Exception e) {
			e.printStackTrace();
		} return count;
	
	}
}
