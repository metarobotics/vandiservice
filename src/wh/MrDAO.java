package wh; 

import java.sql.Connection; 
import java.sql.PreparedStatement; 
import java.sql.ResultSet; 
import java.text.SimpleDateFormat; 
import java.util.ArrayList; 
import java.util.Date; 

public class MrDAO extends DAO { 
//	DBConnect dbconnect = null; 
	//String sql=""; 
	
	public MrDAO() {
		// TODO Auto-generated constructor stub
	}
	
	
	/*
	 * Company
	 */
	
	public Company getCompanyInfo(int companyNo) { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		Company company = null; 
		
		try { 
			StringBuffer sqlBuf=new StringBuffer(); 

			sqlBuf.append("		select * ");
			sqlBuf.append("		from company a ");
			sqlBuf.append("		 where companyNo = ?;");
			
			pstmt = con.prepareStatement(sqlBuf.toString()); 
			pstmt.setInt(1, companyNo); 
			rs = pstmt.executeQuery(); 
			
			if(rs.next()) { 
				company = new Company(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7), rs.getString(8), rs.getString(9), rs.getString(10), rs.getString(11), rs.getString(12), rs.getString(13), rs.getString(14), rs.getString(15), rs.getString(16)); 
			} 
		}catch(Exception e) { 
			
		}finally { 
			DBClose.close(con,pstmt,rs); 
		} 
		
		return company; 
	} 
	
	
	/*
	 * Product
	 */
	
	public Product getProductInfo(int productNo) { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		Product product = null; 
		
		try { 
			StringBuffer sqlBuf=new StringBuffer(); 

			sqlBuf.append("		select * ");
			sqlBuf.append("		from product a ");
			sqlBuf.append("		 where productNo = ?;");
			
			pstmt = con.prepareStatement(sqlBuf.toString()); 
			pstmt.setInt(1, productNo); 
			rs = pstmt.executeQuery(); 
			
			if(rs.next()) { 
				product = new Product(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7), rs.getString(8), rs.getString(9)); 
			} 
		}catch(Exception e) { 
			
		}finally { 
			DBClose.close(con,pstmt,rs); 
		} 
		
		return product; 
	} 
		
	/*
	 * ProductItem
	 */
	
	public ArrayList<ProductItem> getProductItemList(int productNo) throws Exception { 
		
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		
		ArrayList<ProductItem> alist = new ArrayList<ProductItem>(); 
		
		try { 
			StringBuffer sqlBuf=new StringBuffer(); 

			sqlBuf.append("		select a.*, ifnull(b.itemNm, ''), ifnull(b.itemNmKor, '') ");
			sqlBuf.append("		from productItem a ");
			sqlBuf.append("		left join item b ");
			sqlBuf.append("		on a.itemId = b.itemId ");
			sqlBuf.append("		 where a.productNo = ?");
			sqlBuf.append("		 and a.itemCnt > 0");
			
			pstmt = con.prepareStatement(sqlBuf.toString()); 
			pstmt.setInt(1, productNo); 
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ProductItem productItem = new ProductItem(rs.getInt(1), rs.getString(2), rs.getInt(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7), rs.getString(8), rs.getString(9)); 
				alist.add(productItem); 
			} 
		}catch(Exception e) { 
			throw e;
		}finally { 
			DBClose.close(con,pstmt,rs); 
		} 
		
		return alist; 
	} 
	
	
	/*
	 * Product
	 */
	
	public ArrayList<Product> getProductList() { 
		
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		
		ArrayList<Product> alist = new ArrayList<Product>(); 
		
		try { 
			/*

	private int productNo;//1
	
	private String productId;//2
	private String productNmKor;
	private String productNmEng;
	private String createDt;//5
	
	private String insertUserId;//6
	private String insertDatetime;
	private String updateUserId;
	private String updateDatetime;//9
		
					 */
			sql = "select * from product order by productNo"; 
			pstmt = con.prepareStatement(sql); 
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Product product = new Product(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7), rs.getString(8), rs.getString(9)); 
				alist.add(product); 
			} 
		}catch(Exception e) { 
			
		}finally { 
			DBClose.close(con,pstmt,rs); 
		} 
		
		return alist; 
	} 
	
	
	/*
	 * Wh
	 */
	
	public ArrayList<Wh> getWhList() { 
		
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		
		ArrayList<Wh> alist = new ArrayList<Wh>(); 
		
		try { 
			sql = "select * from wh where useYn = 'Y' order by whNo"; 
			pstmt = con.prepareStatement(sql); 
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Wh wh = new Wh(rs.getInt(1), rs.getString(2), rs.getString(3)); 
				alist.add(wh); 
			} 
		}catch(Exception e) { 
			
		}finally { 
			DBClose.close(con,pstmt,rs); 
		} 
		
		return alist; 
	} 

	
	/*
	 * ItemGrp
	 */
	
	public ArrayList<ItemGrp> getItemGrpList() {
		
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		
		ArrayList<ItemGrp> alist = new ArrayList<ItemGrp>(); 
		
		try { 
			sql = "select * from itemGrp order by itemGrpId"; 
			pstmt = con.prepareStatement(sql); 
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ItemGrp itemGrp = new ItemGrp(rs.getInt(1), rs.getString(2), rs.getInt(3), rs.getInt(4), rs.getInt(5), rs.getString(6), rs.getString(7), rs.getString(8), rs.getString(9), rs.getString(10), rs.getString(11), rs.getString(12), rs.getString(13)); 
				alist.add(itemGrp); 
			} 
		}catch(Exception e) { 
			
		}finally { 
			DBClose.close(con,pstmt,rs); 
		} 
		
		return alist; 
	} 

	
	public int countItemGrp() { 
		
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		int cnt = 0; 
		
		try { 
			sql = "SELECT COUNT(*) FROM itemGrp"; 
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
		
}