package wh; 

import java.sql.Connection; 
import java.sql.PreparedStatement; 
import java.sql.ResultSet; 
import java.text.SimpleDateFormat; 
import java.util.ArrayList; 
import java.util.Date;

import util.Encryptor; 

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
			
			if(!chkPwd(id, pwd))
				return null; 
			
			StringBuffer sqlBuf = new StringBuffer(); 
			
			sqlBuf.append("		select a.userNo, a.userId, a.userNm, a.authLvl, ifnull(a.whNo,-1) as whNo"); 
			sqlBuf.append("            , ifnull(b.whId, '') as whId, ifnull(b.whNm, '') as whNm ");
			sqlBuf.append("       from user a ");
			sqlBuf.append("       left outer join wh b ");
			sqlBuf.append("         on a.whNo = b.whNo   ");
			sqlBuf.append("      where userId = ?");
			
			pstmt = con.prepareStatement(sqlBuf.toString()); 
			pstmt.setString(1, id); 
//System.out.println(pstmt.toString());
			rs = pstmt.executeQuery(); 
			
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
	
	private boolean chkPwd(String id, String pwd) throws Exception {
	
		String pwdEnc = getUserPwd(id);
		String pwdDec = Encryptor.decrypt(pwdEnc);
		
		if(pwdDec.equals(pwd))
			return true;
		else
			return false;
	}
	
	private String getUserPwd(String userId) throws Exception {
		
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		
		String pwd = null;
		
		try { 
			
			StringBuffer sqlBuf = new StringBuffer(); 
			
			sqlBuf.append("		select pwd ");
			sqlBuf.append("       from user a ");
			sqlBuf.append("      where userId = ? ");
			
			pstmt = con.prepareStatement(sqlBuf.toString()); 
			pstmt.setString(1, userId); 
//System.out.println(pstmt.toString());

			rs = pstmt.executeQuery(); 
			
			while(rs.next()) { 
				pwd = rs.getString(1);
			}
			
		}catch(Exception e) { 
			throw e;
		}finally { 
			DBClose.close(con,pstmt,rs); 
		} 
		
		return pwd; 	
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
	
	
	public void modifyUserPwd(User user, String newPwd) throws Exception { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		
		try { 
			
			String pwdEnc = Encryptor.encrypt(newPwd);
			
			sql = "update user set pwd=?, updateUserId=?, updateDatetime=current_timestamp() where userNo=?";
			
			pstmt = con.prepareStatement(sql);

			pstmt.setString(1, pwdEnc); 
			pstmt.setString(2, user.getUserId());
			pstmt.setInt(3, user.getUserNo()); 
			
//System.out.println(pstmt.toString());
			pstmt.executeUpdate();
			
		}catch(Exception e) { 
			throw e;
		}finally { 
			DBClose.close(con,pstmt); 
		} 
	} 
			
}



