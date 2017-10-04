package wh;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList; 

//---------------------
// 창고 자재갯수 관리 
//---------------------

public class WhItemDAO extends DAO {
	
	// whItem 테이블에 해당 item이 없으면 insert. 있으면 count를 더하여 update 
	// itemCnt는 +,- 모두 가능  
	public void addWhItemCnt(WhItem whItem) throws Exception {
		
		if(isExistWhItem(whItem.getWhNo(), whItem.getItemNo()))
			updateWhItemCnt(whItem);
		else
			insertWhItem(whItem);
	}
	
	// 해당 row가 존재하면 true, 없으면 false 
	private boolean isExistWhItem(int whNo, int itemNo) throws Exception { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		int cnt = 0; 
		
		try { 
			StringBuffer sqlBuf = new StringBuffer(); 

			sqlBuf.append("		select count(0) ");
			sqlBuf.append("		  from whItem ");
			sqlBuf.append("		 where whNo = ? ");
			sqlBuf.append("		   and itemNo = ? ");
			
			pstmt = con.prepareStatement(sqlBuf.toString()); 
			pstmt.setInt(1, whNo); 
			pstmt.setInt(2, itemNo); 
			
			rs = pstmt.executeQuery(); 
System.out.println(pstmt.toString());
			
			if(rs.next()) { 
				cnt=rs.getInt(1); 
			}
			
			if(cnt == 0)
				return false;
			else
				return true;
			
		}catch(Exception e) { 
			throw e;
		}finally { 
			DBClose.close(con,pstmt,rs); 
		} 
	} 
	
	// whItem insert 
	private void insertWhItem(WhItem whItem) throws Exception { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		
		try { 
			sql = "insert into whItem (whNo, itemNo, itemCnt, insertUserId, insertDatetime) VALUES (?,?,?,?, current_timestamp())"; 
			
			pstmt = con.prepareStatement(sql); 

			pstmt.setInt(1, whItem.getWhNo()); 
			pstmt.setInt(2, whItem.getItemNo()); 
			pstmt.setInt(3, whItem.getItemCnt()); 
			pstmt.setString(4, whItem.getInsertUserId());
			
			pstmt.execute(); 
System.out.println(pstmt.toString());
			
		}catch(Exception e) { 
			throw e;
		}finally { 
			DBClose.close(con,pstmt); 
		} 
	} 
	
	// item count 증가 
	private void updateWhItemCnt(WhItem whItem) throws Exception {
		
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		
		try { 
			StringBuffer sqlBuf = new StringBuffer(); 

			sqlBuf.append("	update whItem ");
			sqlBuf.append("	   set itemCnt = itemCnt + ? ");
			sqlBuf.append("      , updateUserId = ?");
			sqlBuf.append("		 , updateDatetime = current_timestamp() ");
			sqlBuf.append("  where whNo = ? ");
			sqlBuf.append("    and itemNo = ? ");
			
			pstmt = con.prepareStatement(sqlBuf.toString()); 
			
			pstmt.setInt(1, whItem.getItemCnt());
			pstmt.setString(2, whItem.getUpdateUserId());
			pstmt.setInt(3, whItem.getWhNo());
			pstmt.setInt(4, whItem.getItemNo());
						
			pstmt.executeUpdate();
System.out.println(pstmt.toString());
			
		}catch(Exception e) { 
			throw e;
		}finally { 
			DBClose.close(con,pstmt); 
		} 
	} 	
	
	
}
