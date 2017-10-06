package common;

import java.sql.Connection; 
import java.sql.PreparedStatement; 
import java.sql.ResultSet; 
import java.text.SimpleDateFormat; 
import java.util.ArrayList; 
import java.util.Date;

import wh.Accessory;

public class CommonDAO extends DAO {

	public CommonDAO() {
		// TODO Auto-generated constructor stub
	}
	
	/********************
	 * Code
	 ********************/
	
	public Code getCodeInfo(String classCd, String cd) throws Exception {
		
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		Code code = null; 
		
		try { 
			StringBuffer sqlBuf=new StringBuffer(); 

			sqlBuf.append("		select  a.classCd, ");
			sqlBuf.append("				a.cd, ");
			sqlBuf.append("				a.cd1, ");
			sqlBuf.append("				a.cd2, ");
			sqlBuf.append("				a.cd3, ");
			sqlBuf.append("				a.cdNm, ");
			sqlBuf.append("				a.amt, ");
			sqlBuf.append("				a.note, ");
			sqlBuf.append("				a.sortNo, ");
			sqlBuf.append("				a.useYn, ");
			sqlBuf.append("				a.insertUserId, ");
			sqlBuf.append("				a.insertDatetime, ");
			sqlBuf.append("				a.updateUserId, ");
			sqlBuf.append("				a.updateDatetime  ");
			sqlBuf.append("		  from code a ");
			sqlBuf.append("		 where classCd = ? ");
			sqlBuf.append("		   and cd = ? ");
			sqlBuf.append("		   and useYn = 'Y'; ");
			
			pstmt = con.prepareStatement(sqlBuf.toString()); 
			pstmt.setString(1, classCd); 
			pstmt.setString(2, cd); 
//System.out.println(pstmt.toString());
			rs = pstmt.executeQuery(); 
			
			if(rs.next()) { 
				code = new Code(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getInt(7), rs.getString(8), rs.getInt(9), rs.getString(10), rs.getString(11), rs.getString(12), rs.getString(13), rs.getString(14)); 
			} 
		}catch(Exception e) { 
			throw e;
		}finally { 
			DBClose.close(con,pstmt,rs); 
		} 
		
		return code; 
	} 
	
	public ArrayList<Code> getCodeList(String classCd) throws Exception { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		
		ArrayList<Code> alist = new ArrayList<Code>(); 
		
		try { 
			StringBuffer sqlBuf=new StringBuffer(); 

			sqlBuf.append("		select  a.classCd, ");
			sqlBuf.append("				a.cd, ");
			sqlBuf.append("				a.cd1, ");
			sqlBuf.append("				a.cd2, ");
			sqlBuf.append("				a.cd3, ");
			sqlBuf.append("				a.cdNm, ");
			sqlBuf.append("				a.amt, ");
			sqlBuf.append("				a.note, ");
			sqlBuf.append("				a.sortNo, ");
			sqlBuf.append("				a.useYn, ");
			sqlBuf.append("				a.insertUserId, ");
			sqlBuf.append("				a.insertDatetime, ");
			sqlBuf.append("				a.updateUserId, ");
			sqlBuf.append("				a.updateDatetime  ");
			sqlBuf.append("		  from code a ");
			sqlBuf.append("		 where classCd = ? ");
			sqlBuf.append("		   and useYn = 'Y' ");
			sqlBuf.append("		 order by sortNo; ");
			
			pstmt = con.prepareStatement(sqlBuf.toString()); 
			pstmt.setString(1, classCd); 
//System.out.println(pstmt.toString());
			rs = pstmt.executeQuery(); 
			
			while(rs.next()) {
				Code code = new Code(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getInt(7), rs.getString(8), rs.getInt(9), rs.getString(10), rs.getString(11), rs.getString(12), rs.getString(13), rs.getString(14)); 
				alist.add(code);
			} 
			
		}catch(Exception e) { 
			throw e;
		}finally { 
			DBClose.close(con,pstmt,rs); 
		} 
		
		return alist; 
	} 
	
	
}
