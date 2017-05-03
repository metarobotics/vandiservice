package wh; 

import java.sql.Connection; 
import java.sql.PreparedStatement; 
import java.sql.ResultSet; 
import java.text.SimpleDateFormat; 
import java.util.ArrayList; 
import java.util.Date; 

public class ItemDAO extends DAO { 
//	DBConnect dbconnect = null; 
	//String sql=""; 
	
	public ItemDAO() {
		// TODO Auto-generated constructor stub
	}
	
	public int countItem() { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		int cnt = 0; 
		
		try { 
			sql = "SELECT COUNT(*) FROM item"; 
			pstmt = con.prepareStatement(sql); 
			rs = pstmt.executeQuery(); 
			
			if(rs.next()) { 
				cnt=rs.getInt(1); 
			} 
		}catch(Exception e) { 
			
		}finally { 
			DBClose.close(con,pstmt,rs); 
		} 
		return cnt; 
	} 
	
	public String pasing(String data) { 
		try { 
			data = new String(data.getBytes("8859_1"), "euc-kr"); 
		}catch (Exception e){ } 
		return data; 
	} 
	
	public ArrayList<Item> getItemList() { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		ArrayList<Item> alist = new ArrayList<Item>(); 
		
		try { 
			sql = "SELECT ITEM_NO, ITEM_NM, INSERT_USER_NO, INSERT_DATETIME from item order by ITEM_NO"; 
			pstmt = con.prepareStatement(sql); 
			rs = pstmt.executeQuery(); 
			while(rs.next()) { 
				Item item = new Item(); 
				//boolean dayNew = false; 
				item.setItemNo(rs.getInt(1)); 
				item.setItemNm(rs.getString(2)); 
				item.setInsertUserNo(rs.getInt(3)); 
				item.setInsertDatetime(rs.getString(4).toString()); 
				
				//Date date = new Date(); 
				//SimpleDateFormat simpleDate = new SimpleDateFormat("yyyy-MM-dd"); 
				//String year = (String)simpleDate.format(date); 
				//String yea = rs.getString(4).substring(0,10); 
				
				//if(year.equals(yea)){ 
				//	dayNew = true; 
				//} 
				
				//item.setTime(yea); item.setHit(rs.getInt(5)); item.setIndent(rs.getInt(6)); 
				//item.setDayNew(dayNew); 
				
				alist.add(item); 
			} 
		}catch(Exception e) { 
			
		}finally { 
			DBClose.close(con,pstmt,rs); 
		} return alist; 
	} 
	/*
	public int getMax() { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		int max = 0; 
		
		try { 
			sql = "SELECT MAX(NUM) FROM board1"; 
			pstmt = con.prepareStatement(sql); 
			rs = pstmt.executeQuery(); 
			
			if(rs.next()) { 
				max=rs.getInt(1); 
			} 
		}catch(Exception e) { 
			
		}finally { 
			DBClose.close(con,pstmt,rs); 
		} return max; 
	} 
	*/
	
	public void insertItem(Item item, int max) { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		
		try { 
			sql = "INSERT INTO item (ITEM_NO, ITEM_NM, INSERT_USER_NO, INSERT_DATETIME) VALUES (?,?,?, current_timestamp())"; 
			pstmt = con.prepareStatement(sql); 
			pstmt.setInt(1, max+1); 
			pstmt.setString(2, pasing(item.getItemNm())); 
			pstmt.setInt(3, item.getInsertUserNo()); 
			//pstmt.setString(3, pasing(item.getTitle())); 
			//pstmt.setString(4, pasing(item.getMemo())); 
			pstmt.execute(); 
		}catch(Exception e) { 
			
		}finally { 
			DBClose.close(con,pstmt); 
		} 
	} 
	
	public Item getItemInfo(int idx) { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		Item item = null; 
		
		try { 
			sql = "SELECT ITEM_NO, ITEM_NM, INSERT_USER_NO, INSERT_DATETIME FROM item WHERE ITEM_NO = ?"; 
			pstmt = con.prepareStatement(sql); 
			pstmt.setInt(1, idx); 
			rs = pstmt.executeQuery(); 
			
			if(rs.next()) { 
				item = new Item(); 
				item.setItemNo(rs.getInt(1)); 
				item.setItemNm(rs.getString(2)); 
				item.setInsertUserNo(rs.getInt(3)); 
				item.setInsertDatetime(rs.getString(4).toString()); 
				/*item.set(rs.getString(3)); 
				item.setTime(rs.getString(4)); 
				item.setHit(rs.getInt(5)+1); 
				item.setPassword(rs.getString(6)); 
				item.setRef(rs.getInt(7)); 
				item.setIndent(rs.getInt(8)); 
				item.setStep(rs.getInt(9)); */
			} 
		}catch(Exception e) { 
			
		}finally { 
			DBClose.close(con,pstmt,rs); 
		} 
		
		return item; 
	} 
	
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
			pstmt.setString(1, pasing(item.getItemNm())); 
			//pstmt.setString(2, pasing(item.getMemo())); 
			pstmt.setInt(2, idx); 
			pstmt.executeUpdate(); 
		}catch(Exception e) { 
			
		}finally { 
			DBClose.close(con,pstmt); 
		} 
	} 
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
			pstmt.setString(1, pasing(item.getName())); 
			pstmt.setString(2, pasing(item.getPassword())); 
			pstmt.setString(3, pasing(item.getTitle())); 
			pstmt.setString(4, pasing(item.getMemo())); 
			pstmt.setInt(5, ref); pstmt.setInt(6, indent+1); 
			pstmt.setInt(7, step+1); 
			pstmt.execute(); 
		}catch(Exception e) { 
			
		}finally { 
			DBClose.close(con,pstmt); 
		} 
	}*/
	
	
}



