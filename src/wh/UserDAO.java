package wh; 

import java.sql.Connection; 
import java.sql.PreparedStatement; 
import java.sql.ResultSet; 
import java.text.SimpleDateFormat; 
import java.util.ArrayList; 
import java.util.Date; 

public class UserDAO extends DAO { 
	
	public UserDAO() {
		// TODO Auto-generated constructor stub
	}
	
	public User getUserInfo(String id, String pwd) throws Exception { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		User user = null; 
		
		try { 
			StringBuffer sqlBuf = new StringBuffer(); 
			
			sqlBuf.append("		select a.userNo, a.userId, a.userNm, a.authLvl, ifnull(a.whNo,-1) as whNo"); 
			sqlBuf.append("            , ifnull(b.whId, '') as whId, ifnull(b.whNm, '') as whNm ");
			sqlBuf.append("       from user a ");
			sqlBuf.append("       left outer join wh b ");
			sqlBuf.append("         on a.whNo = b.whNo   ");
			sqlBuf.append("      where userId = ? AND pwd = ?");
			
			pstmt = con.prepareStatement(sqlBuf.toString()); 
			pstmt.setString(1, id); 
			pstmt.setString(2, pwd); 
			rs = pstmt.executeQuery(); 
			//System.out.println(sqlBuf.toString());
			
			while(rs.next()) { 
				user = new User(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getInt(5), rs.getString(6), rs.getString(7));
			}
			
		}catch(Exception e) { 
			throw e;
		}finally { 
			DBClose.close(con,pstmt,rs); 
		} 
		
		return user; 
	} 
	
	public void setLoginDatetime(String id) throws Exception { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		
		try { 
			sql = "update user set lastLoginDatetime = current_timestamp() where userid = ?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id); 
			pstmt.executeUpdate(); 
			//System.out.println(sql);
			
		}catch(Exception e) { 
			throw e;
		}finally { 
			DBClose.close(con,pstmt); 
		} 
	} 
	
}



