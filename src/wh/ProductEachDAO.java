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
			sql = "select ifnull(max(productEachNo),0)+1 from productEach"; 
			
			pstmt = con.prepareStatement(sql); 
			rs = pstmt.executeQuery(); 
			//System.out.println(sql);
			
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

	public ProductEach getProductEachInfo(int productEachNo) throws Exception { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		ProductEach productEach = null; 
		
		try { 
			StringBuffer sqlBuf = new StringBuffer(); 

			sqlBuf.append("		select  a.productEachNo, ");
			sqlBuf.append("				a.productNo, ");
			sqlBuf.append("				a.serialNo, ");
			sqlBuf.append("				a.prodDt, ");
			sqlBuf.append("				a.certDt, ");
			sqlBuf.append("				a.registerNo, ");
			sqlBuf.append("				a.clientNo, ");
			
			sqlBuf.append("				a.productCost, ");
			sqlBuf.append("				a.salesDt, ");
			sqlBuf.append("				a.salesAmt, ");
			sqlBuf.append("				a.addSalesAmt, ");
			sqlBuf.append("				a.payDt, ");
			sqlBuf.append("				a.payAmt, ");
			sqlBuf.append("				a.creditSalesAmt, ");
			sqlBuf.append("				a.note, ");
			
			sqlBuf.append("				a.insertUserId, ");
			sqlBuf.append("				a.insertDatetime, ");
			sqlBuf.append("				a.updateUserId, ");
			sqlBuf.append("				a.updateDatetime  ");
			sqlBuf.append("				, ifnull(b.clientNm, '') ");			
			sqlBuf.append("				, b.location ");
			sqlBuf.append("		  from productEach a ");
			sqlBuf.append("		  left join client b ");
			sqlBuf.append("		    on a.clientNo = b.clientNo ");
			sqlBuf.append("		 where productEachNo = ?");
			
			pstmt = con.prepareStatement(sqlBuf.toString());
			
			pstmt.setInt(1, productEachNo); 
			
			rs = pstmt.executeQuery(); 
			//System.out.println(sqlBuf.toString());
			
			if(rs.next()) { 
				productEach = new ProductEach(rs.getInt(1), rs.getInt(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getInt(7), 
						rs.getInt(8), rs.getString(9), rs.getInt(10), rs.getInt(11), rs.getString(12), rs.getInt(13), rs.getInt(14), rs.getString(15), 
						rs.getString(16), rs.getString(17), rs.getString(18), rs.getString(19), 
						rs.getString(20), rs.getString(21));
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

			sqlBuf.append("		select  a.productEachNo, ");
			sqlBuf.append("				a.productNo, ");
			sqlBuf.append("				a.serialNo, ");
			sqlBuf.append("				a.prodDt, ");
			sqlBuf.append("				a.certDt, ");
			sqlBuf.append("				a.registerNo, ");
			sqlBuf.append("				a.clientNo, ");
			
			sqlBuf.append("				a.productCost, ");
			sqlBuf.append("				a.salesDt, ");
			sqlBuf.append("				a.salesAmt, ");
			sqlBuf.append("				a.addSalesAmt, ");
			sqlBuf.append("				a.payDt, ");
			sqlBuf.append("				a.payAmt, ");
			sqlBuf.append("				a.creditSalesAmt, ");
			sqlBuf.append("				a.note, ");
			
			sqlBuf.append("				a.insertUserId, ");
			sqlBuf.append("				a.insertDatetime, ");
			sqlBuf.append("				a.updateUserId, ");
			sqlBuf.append("				a.updateDatetime  ");
			sqlBuf.append("				, ifnull(b.clientNm, '') ");			
			sqlBuf.append("				, b.location ");
			sqlBuf.append("		  from productEach a ");
			sqlBuf.append("		  left outer join client b ");
			sqlBuf.append("		    on a.clientNo = b.clientNo ");
			sqlBuf.append("		 order by a.serialNo");
			
			pstmt = con.prepareStatement(sqlBuf.toString()); 
			rs = pstmt.executeQuery();
			//System.out.println(sqlBuf.toString());
			
			while(rs.next()) {
				
				ProductEach productEach = new ProductEach(rs.getInt(1), rs.getInt(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getInt(7), 
						rs.getInt(8), rs.getString(9), rs.getInt(10), rs.getInt(11), rs.getString(12), rs.getInt(13), rs.getInt(14), rs.getString(15), 
						rs.getString(16), rs.getString(17), rs.getString(18), rs.getString(19), 
						rs.getString(20), rs.getString(21));
				
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
			sql = "insert into productEach (productEachNo, productNo, serialNo, prodDt, certDt, registerNo, clientNo, "
					+ "productCost, salesDt, salesAmt, addSalesAmt, payDt, payAmt, creditSalesAmt, note, "
					+ "insertUserId, insertDatetime) VALUES (?,?,?,?,?,?,?,?, ?,?,?,?,?,?,?,?, current_timestamp())"; 
			
			pstmt = con.prepareStatement(sql); 

			pstmt.setInt(1, productEach.getProductEachNo());
			pstmt.setInt(2, productEach.getProductNo());
			pstmt.setString(3, productEach.getSerialNo()); 
			pstmt.setString(4, productEach.getProdDt()); 
			pstmt.setString(5, productEach.getCertDt());
			pstmt.setString(6, productEach.getRegisterNo());
			pstmt.setInt(7, productEach.getClientNo());
			
			pstmt.setInt(8, productEach.getProductCost());
			pstmt.setString(9, productEach.getSalesDt());
			pstmt.setInt(10, productEach.getSalesAmt());
			pstmt.setInt(11, productEach.getAddSalesAmt());
			pstmt.setString(12, productEach.getPayDt());
			pstmt.setInt(13, productEach.getPayAmt());
			pstmt.setInt(14, productEach.getCreditSalesAmt());
			pstmt.setString(15, productEach.getNote());
			
			pstmt.setString(16, productEach.getInsertUserId());
			
			pstmt.execute(); 
			//System.out.println(sql);
			
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
			sql = "update productEach "
					+ "set productNo=?, serialNo=?, prodDt=?, certDt=?, registerNo=?, clientNo=?, "
					+ "productCost=?, salesDt=?, salesAmt=?, addSalesAmt=?, payDt=?, payAmt=?, creditSalesAmt=?, note=?, "
					+ "updateUserId=?, updateDatetime=current_timestamp() "
					+ "where productEachNo=?";
			
			pstmt = con.prepareStatement(sql);

			pstmt.setInt(1, productEach.getProductNo());
			pstmt.setString(2, productEach.getSerialNo());
			pstmt.setString(3, productEach.getProdDt()); 
			pstmt.setString(4, productEach.getCertDt());
			pstmt.setString(5, productEach.getRegisterNo());
			pstmt.setInt(6, productEach.getClientNo());
			
			pstmt.setInt(7, productEach.getProductCost());
			pstmt.setString(8, productEach.getSalesDt());
			pstmt.setInt(9, productEach.getSalesAmt());
			pstmt.setInt(10, productEach.getAddSalesAmt());
			pstmt.setString(11, productEach.getPayDt());
			pstmt.setInt(12, productEach.getPayAmt());
			pstmt.setInt(13, productEach.getCreditSalesAmt());
			pstmt.setString(14, productEach.getNote());
			
			pstmt.setString(15, productEach.getUpdateUserId());
			pstmt.setInt(16, productEach.getProductEachNo());
			
			pstmt.executeUpdate();
			//System.out.println(sql);
			
		}catch(Exception e) { 
			throw e;
		}finally { 
			DBClose.close(con,pstmt); 
		} 
	} 
		

	public void deleteProductEach(int productEachNo) throws Exception { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null;
		
		try {
			sql = "delete from productEach where productEachNo=?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, productEachNo); 
			pstmt.executeUpdate();
			//System.out.println(sql);
			
		}catch(Exception e) { 
			throw e;
		}finally { 
			DBClose.close(con,pstmt); 
		} 
	} 
	
}



