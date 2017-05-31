package wh; 

import java.sql.Connection; 
import java.sql.PreparedStatement; 
import java.sql.ResultSet; 
import java.text.SimpleDateFormat; 
import java.util.ArrayList; 
import java.util.Date; 

public class ProductEachDAO extends DAO { 
	
	public ProductEachDAO() {
		// TODO Auto-generated constructor stub
	}
	
	public int getNextProductEachNo() throws Exception {
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		int no = 0; 
		
		try { 
			sql = "select ifnull(max(clientNo),0)+1 from client"; 
			pstmt = con.prepareStatement(sql); 
			rs = pstmt.executeQuery(); 
			
			if(rs.next()) { 
				no = rs.getInt(1); 
			} 
		}catch(Exception e) { 
			throw e;
		}finally { 
			DBClose.close(con,pstmt,rs); 
		} 
		return no; 
	}
	
	
	public String incoding(String data) { 
		try { 
			//data = new String(data.getBytes("8859_1"), "euc-kr");
			//data = new String(data.getBytes("KSC5601"), "8859_1");
			
//			sql = new String(",  statusNm ".getBytes("8859_1"), "euc-kr");
//			sql = new String(",  statusNm ".getBytes("KSC5601"), "8859_1");
			
		}catch (Exception e){ } 
		return data; 
	} 
	
	
	/*
	 * ProductEach
	 */
	
	public ProductEach getProductEachInfo(int productNo, String serialNo) throws Exception { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		ProductEach productEach = null; 
		
		try { 
			StringBuffer sqlBuf = new StringBuffer(); 

			sqlBuf.append("		select a.*, ifnull(b.clientNm, '') ");
			sqlBuf.append("		from productEach a ");
			sqlBuf.append("		left join client b ");
			sqlBuf.append("		on a.clientNo = b.clientNo ");
			sqlBuf.append("		 where productNo = ?");
			sqlBuf.append("		 and serialNo = ?");
			
			pstmt = con.prepareStatement(sqlBuf.toString());
			
			pstmt.setInt(1, productNo); 
			pstmt.setString(2, serialNo);
			
			rs = pstmt.executeQuery(); 
			
			if(rs.next()) { 
				productEach = new ProductEach(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getInt(6), 
						rs.getString(7), rs.getString(8), rs.getString(9), rs.getString(10), 
						rs.getString(11));
			} 
		}catch(Exception e) { 
			throw e;
		}finally { 
			DBClose.close(con,pstmt,rs); 
		} 
		
		return productEach; 
	} 
	
	public ArrayList<ProductEach> getProductEachList() throws Exception { 
		
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		
		ArrayList<ProductEach> alist = new ArrayList<ProductEach>(); 
		
		try { 
			StringBuffer sqlBuf = new StringBuffer(); 

			sqlBuf.append("		select a.*, ifnull(b.clientNm, '') ");
			sqlBuf.append("		from productEach a ");
			sqlBuf.append("		left outer join client b ");
			sqlBuf.append("		on a.clientNo = b.clientNo ");
			
			pstmt = con.prepareStatement(sqlBuf.toString()); 
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ProductEach productEach = new ProductEach(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getInt(6), 
						rs.getString(7), rs.getString(8), rs.getString(9), rs.getString(10), 
						rs.getString(11));
				
				alist.add(productEach); 
			} 
		}catch(Exception e) { 
			throw e;
		}finally { 
			DBClose.close(con,pstmt,rs); 
		} 
		
		return alist; 
	} 
		
	
	
	
	
	public void insertProductEach(ProductEach productEach) throws Exception { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		
		try { 
			
			sql = "insert into productEach (productNo, serialNo, prodDt, certDt, registerNo, clientNo, insertUserId, insertDatetime) VALUES (?,?,?,?,?,?,?, current_timestamp())"; 
			pstmt = con.prepareStatement(sql); 

			pstmt.setInt(1, productEach.getProductNo());
			pstmt.setString(2, productEach.getSerialNo()); 
			pstmt.setString(3, productEach.getProdDt()); 
			pstmt.setString(4, productEach.getCertDt());
			pstmt.setString(5, productEach.getRegisterNo());
			pstmt.setInt(6, productEach.getClientNo());
			pstmt.setString(7, productEach.getInsertUserId());
			
			pstmt.execute(); 
			
		}catch(Exception e) { 
			throw e;
		}finally { 
			DBClose.close(con,pstmt); 
		} 
	} 
	
	
	public void modifyProductEach(ProductEach productEach) throws Exception { 
		
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		
		try { 
			sql = "update productEach set prodDt=?, certDt=?, registerNo=?, clientNo=?, updateUserId=?, updateDatetime=current_timestamp() where productNo=? and serialNo=?";
			
			pstmt = con.prepareStatement(sql);

			pstmt.setString(1, productEach.getProdDt()); 
			pstmt.setString(2, productEach.getCertDt());
			pstmt.setString(3, productEach.getRegisterNo());
			pstmt.setInt(4, productEach.getClientNo());
			pstmt.setString(5, productEach.getUpdateUserId());
			pstmt.setInt(6, productEach.getProductNo());
			pstmt.setString(7, productEach.getSerialNo()); 
			
			pstmt.executeUpdate();
			
		}catch(Exception e) { 
			throw e;
		}finally { 
			DBClose.close(con,pstmt); 
		} 
	} 
		

	public void deleteProductEach(int productNo, String serialNo) throws Exception { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null;
		
		try {
			
			sql = "delete from productEach where productNo=? and serialNo=?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, productNo); 
			pstmt.setString(2, serialNo); 
			
			pstmt.executeUpdate();
		}catch(Exception e) { 
			throw e;
		}finally { 
			DBClose.close(con,pstmt); 
		} 
	} 
	
}



