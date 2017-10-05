package wh; 

import java.sql.Connection; 
import java.sql.PreparedStatement; 
import java.sql.ResultSet; 
import java.text.SimpleDateFormat; 
import java.util.ArrayList; 
import java.util.Date; 

public class ProductDAO extends DAO { 
	
	public ProductDAO() {
		// TODO Auto-generated constructor stub
	}
	
	public int getNextProductNo() throws Exception {
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		int no = 0; 
		
		try { 
			sql = "select ifnull(max(productNo),0)+1 from product"; 
			
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

	public Product getProductInfo(int productNo) throws Exception { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		Product product = null; 
		
		try { 
			StringBuffer sqlBuf = new StringBuffer(); 

			sqlBuf.append("		select  a.productNo, ");
			sqlBuf.append("				a.modelNo, ");
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
			sqlBuf.append("		  from product a ");
			sqlBuf.append("		  left join client b ");
			sqlBuf.append("		    on a.clientNo = b.clientNo ");
			sqlBuf.append("		 where productNo = ?");
			
			pstmt = con.prepareStatement(sqlBuf.toString());
			
			pstmt.setInt(1, productNo); 
			
//System.out.println(pstmt.toString());
			rs = pstmt.executeQuery(); 
			
			if(rs.next()) { 
				product = new Product(rs.getInt(1), rs.getInt(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getInt(7), 
						rs.getInt(8), rs.getString(9), rs.getInt(10), rs.getInt(11), rs.getString(12), rs.getInt(13), rs.getInt(14), rs.getString(15), 
						rs.getString(16), rs.getString(17), rs.getString(18), rs.getString(19), 
						rs.getString(20), rs.getString(21));
			} 
		}catch(Exception e) { 
			throw e;
		}finally { 
			DBClose.close(con,pstmt,rs); 
		} 
		
		return product; 
	} 
	
	public ArrayList<Product> getProductList() throws Exception { 
		
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		
		ArrayList<Product> alist = new ArrayList<Product>(); 
		
		try { 
			StringBuffer sqlBuf = new StringBuffer(); 

			sqlBuf.append("		select  a.productNo, ");
			sqlBuf.append("				a.modelNo, ");
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
			sqlBuf.append("		  from product a ");
			sqlBuf.append("		  left outer join client b ");
			sqlBuf.append("		    on a.clientNo = b.clientNo ");
			sqlBuf.append("		 order by a.serialNo");
			
			pstmt = con.prepareStatement(sqlBuf.toString()); 
			rs = pstmt.executeQuery();
			//System.out.println(sqlBuf.toString());
			
			while(rs.next()) {
				
				Product product = new Product(rs.getInt(1), rs.getInt(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getInt(7), 
						rs.getInt(8), rs.getString(9), rs.getInt(10), rs.getInt(11), rs.getString(12), rs.getInt(13), rs.getInt(14), rs.getString(15), 
						rs.getString(16), rs.getString(17), rs.getString(18), rs.getString(19), 
						rs.getString(20), rs.getString(21));
				
				alist.add(product); 
			} 
		}catch(Exception e) { 
			throw e;
		}finally { 
			DBClose.close(con,pstmt,rs); 
		} 
		
		return alist; 
	} 
		
	public ArrayList<Product> getProductList(int modelNo) throws Exception { 
		
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		
		ArrayList<Product> alist = new ArrayList<Product>(); 
		
		try { 
			StringBuffer sqlBuf = new StringBuffer(); 

			sqlBuf.append("		select  a.productNo, ");
			sqlBuf.append("				a.modelNo, ");
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
			sqlBuf.append("		  from product a ");
			sqlBuf.append("		  left outer join client b ");
			sqlBuf.append("		    on a.clientNo = b.clientNo ");
			sqlBuf.append("		 where a.modelNo = ? ");
			sqlBuf.append("		 order by a.serialNo");
			
			pstmt = con.prepareStatement(sqlBuf.toString());
			pstmt.setInt(1, modelNo);
			rs = pstmt.executeQuery();
			//System.out.println(sqlBuf.toString());
			
			while(rs.next()) {
				
				Product product = new Product(rs.getInt(1), rs.getInt(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getInt(7), 
						rs.getInt(8), rs.getString(9), rs.getInt(10), rs.getInt(11), rs.getString(12), rs.getInt(13), rs.getInt(14), rs.getString(15), 
						rs.getString(16), rs.getString(17), rs.getString(18), rs.getString(19), 
						rs.getString(20), rs.getString(21));
				
				alist.add(product); 
			} 
		}catch(Exception e) { 
			throw e;
		}finally { 
			DBClose.close(con,pstmt,rs); 
		} 
		
		return alist; 
	} 
	
	public void insertProduct(Product product) throws Exception { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		
		try { 
			sql = "insert into product (productNo, modelNo, serialNo, prodDt, certDt, registerNo, clientNo, "
					+ "productCost, salesDt, salesAmt, addSalesAmt, payDt, payAmt, creditSalesAmt, note, "
					+ "insertUserId, insertDatetime) VALUES (?,?,?,?,?,?,?,?, ?,?,?,?,?,?,?,?, current_timestamp())"; 
			
			pstmt = con.prepareStatement(sql); 

			pstmt.setInt(1, product.getProductNo());
			pstmt.setInt(2, product.getModelNo());
			pstmt.setString(3, product.getSerialNo()); 
			pstmt.setString(4, product.getProdDt()); 
			pstmt.setString(5, product.getCertDt());
			pstmt.setString(6, product.getRegisterNo());
			pstmt.setInt(7, product.getClientNo());
			
			pstmt.setInt(8, product.getProductCost());
			pstmt.setString(9, product.getSalesDt());
			pstmt.setInt(10, product.getSalesAmt());
			pstmt.setInt(11, product.getAddSalesAmt());
			pstmt.setString(12, product.getPayDt());
			pstmt.setInt(13, product.getPayAmt());
			pstmt.setInt(14, product.getCreditSalesAmt());
			pstmt.setString(15, product.getNote());
			
			pstmt.setString(16, product.getInsertUserId());
			
			pstmt.execute(); 
			//System.out.println(sql);
			
		}catch(Exception e) { 
			throw e;
		}finally { 
			DBClose.close(con,pstmt); 
		} 
	} 
	
	
	public void modifyProduct(Product product) throws Exception { 
		
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		
		try { 
			sql = "update product "
					+ "set modelNo=?, serialNo=?, prodDt=?, certDt=?, registerNo=?, clientNo=?, "
					+ "productCost=?, salesDt=?, salesAmt=?, addSalesAmt=?, payDt=?, payAmt=?, creditSalesAmt=?, note=?, "
					+ "updateUserId=?, updateDatetime=current_timestamp() "
					+ "where productNo=?";
			
			pstmt = con.prepareStatement(sql);

			pstmt.setInt(1, product.getModelNo());
			pstmt.setString(2, product.getSerialNo());
			pstmt.setString(3, product.getProdDt()); 
			pstmt.setString(4, product.getCertDt());
			pstmt.setString(5, product.getRegisterNo());
			pstmt.setInt(6, product.getClientNo());
			
			pstmt.setInt(7, product.getProductCost());
			pstmt.setString(8, product.getSalesDt());
			pstmt.setInt(9, product.getSalesAmt());
			pstmt.setInt(10, product.getAddSalesAmt());
			pstmt.setString(11, product.getPayDt());
			pstmt.setInt(12, product.getPayAmt());
			pstmt.setInt(13, product.getCreditSalesAmt());
			pstmt.setString(14, product.getNote());
			
			pstmt.setString(15, product.getUpdateUserId());
			pstmt.setInt(16, product.getProductNo());
			
			pstmt.executeUpdate();
			//System.out.println(sql);
			
		}catch(Exception e) { 
			throw e;
		}finally { 
			DBClose.close(con,pstmt); 
		} 
	} 
		

	public void deleteProduct(int productNo) throws Exception { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null;
		
		try {
			sql = "delete from product where productNo=?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, productNo); 
			pstmt.executeUpdate();
			//System.out.println(sql);
			
		}catch(Exception e) { 
			throw e;
		}finally { 
			DBClose.close(con,pstmt); 
		} 
	} 
	
}



