package wh; 

import java.sql.Connection; 
import java.sql.PreparedStatement; 
import java.sql.ResultSet; 
import java.text.SimpleDateFormat; 
import java.util.ArrayList; 
import java.util.Date; 

public class UserDAO extends DAO { 
	//DBConnect dbconnect = null; 
	//String sql=""; 
	
	public UserDAO() {
		// TODO Auto-generated constructor stub
	}
	
	public String incoding(String data) { 
		try { 
			data = new String(data.getBytes("8859_1"), "euc-kr"); 
		}catch (Exception e){ } 
		return data; 
	} 
	
	public User getUserInfo(String id, String pwd) { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		User user = null; 
		
		try { 
			sql = "select userNo, userNm from user where userId = ? AND pwd = ?"; 
			pstmt = con.prepareStatement(sql); 
			pstmt.setString(1, id); 
			pstmt.setString(2, pwd); 
			rs = pstmt.executeQuery(); 
			
			if(rs.next()) { 
				user = new User(); 
				user.setUserNo(rs.getInt(1)); 
				user.setUserNm(rs.getString(2)); 
				//item.setInsertUserNo(rs.getInt(3)); 
				//item.setInsertDatetime(rs.getString(4).toString()); 
				/*item.set(rs.getString(3)); 
				item.setTime(rs.getString(4)); 
				item.setHit(rs.getInt(5)+1); 
				item.setPassword(rs.getString(6)); 
				item.setRef(rs.getInt(7)); 
				item.setIndent(rs.getInt(8)); 
				item.setStep(rs.getInt(9)); */
			} 
		}catch(Exception e) { 
			System.out.println(e.toString());
		}finally { 
			DBClose.close(con,pstmt,rs); 
		} 
		
		return user; 
	} 
	/*
	public void deleteItem(int idx) { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		try { 
			sql = "DELETE FROM item WHERE item_no = ?"; 
			pstmt = con.prepareStatement(sql); 
			pstmt.setInt(1, idx); 
			pstmt.executeUpdate(); 
		}catch(Exception e) { 
		
		}finally { 
			DBClose.close(con,pstmt); 
		} 
	} 
	
	public void modifyItem(Item item, int idx) { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		try { 
			sql = "UPDATE item SET ITEM_NM=? where item_no=?"; 
			pstmt = con.prepareStatement(sql); 
			pstmt.setString(1, incoding(item.getItemNm())); 
			//pstmt.setString(2, incoding(item.getMemo())); 
			pstmt.setInt(2, idx); 
			pstmt.executeUpdate(); 
		}catch(Exception e) { 
			
		}finally { 
			DBClose.close(con,pstmt); 
		} 
	} 
	*/
	/*
	public void UpdateStep(int ref, int step) { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		try { 
			sql = "UPDATE board1 SET STEP=STEP+1 where REF=? and STEP>?"; 
			pstmt = con.prepareStatement(sql); 
			pstmt.setInt(1, ref); 
			pstmt.setInt(2, step); 
			pstmt.executeUpdate(); 
		}catch(Exception e) { 
			
		}finally { 
			DBClose.close(con,pstmt); 
		} 
	} 
	*/
	/*
	public void insertReply(Item item, int ref, int indent, int step) { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		try { 
			sql = "INSERT INTO board1(USERNAME, PASSWORD, TITLE, MEMO, REF, INDENT, STEP) "+ "VALUES(?,?,?,?,?,?,?)"; 
			pstmt = con.prepareStatement(sql); 
			pstmt.setString(1, incoding(item.getName())); 
			pstmt.setString(2, incoding(item.getPassword())); 
			pstmt.setString(3, incoding(item.getTitle())); 
			pstmt.setString(4, incoding(item.getMemo())); 
			pstmt.setInt(5, ref); pstmt.setInt(6, indent+1); 
			pstmt.setInt(7, step+1); 
			pstmt.execute(); 
		}catch(Exception e) { 
			
		}finally { 
			DBClose.close(con,pstmt); 
		} 
	}*/
	
	
}



