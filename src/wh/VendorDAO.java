package wh; 

import java.sql.Connection; 
import java.sql.PreparedStatement; 
import java.sql.ResultSet; 
import java.text.SimpleDateFormat; 
import java.util.ArrayList; 
import java.util.Date;

import common.DAO;
import common.DBClose; 

public class VendorDAO extends DAO { 
	
	public VendorDAO() {
		// TODO Auto-generated constructor stub
	}
	
	public int getNextVendorNo() throws Exception {
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		int no = 0; 
		
		try { 
			sql = "select ifnull(max(vendorNo),0)+1 from vendor"; 
			
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
	
	public int countVendor() throws Exception { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		int cnt = 0; 
		
		try { 
			sql = "SELECT COUNT(0) FROM vendor";
			
			pstmt = con.prepareStatement(sql); 
			rs = pstmt.executeQuery(); 
			//System.out.println(sql);
			
			if(rs.next()) { 
				cnt=rs.getInt(1); 
			} 
		}catch(Exception e) { 
			throw e;
		}finally { 
			DBClose.close(con,pstmt,rs); 
		} 
		return cnt; 
	} 
	
	public Vendor getVendorInfo(int vendorNo) throws Exception { 
		
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		Vendor vendor = null; 
		
		try { 
			StringBuffer sqlBuf=new StringBuffer(); 

			sqlBuf.append("		select 	a.vendorNo, ");
			sqlBuf.append("				a.vendorNm, ");
			sqlBuf.append("				a.phoneNo, ");
			sqlBuf.append("				a.mobileNo, ");
			sqlBuf.append("				a.faxNo, ");
			
			sqlBuf.append("				a.chargeEmpNm, ");
			sqlBuf.append("				a.email, ");
			sqlBuf.append("				a.countryCd, ");
			sqlBuf.append("				a.addr, ");
			sqlBuf.append("				a.note, ");
			
			sqlBuf.append("				a.insertUserId, ");
			sqlBuf.append("				a.insertDatetime, ");
			sqlBuf.append("				a.updateUserId, ");
			sqlBuf.append("				a.updateDatetime "); 
			sqlBuf.append("				, (select count(0) from item where vendorNo = a.vendorNo) as dealCnt");
			sqlBuf.append("				, (select cdNm from code where classCd = '01' and cd = a.countryCd) as countryNm");

			sqlBuf.append("		  from vendor a ");
			sqlBuf.append("		 where vendorNo = ?;");
			
			pstmt = con.prepareStatement(sqlBuf.toString()); 
			pstmt.setInt(1, vendorNo); 
//System.out.println(pstmt.toString());
			rs = pstmt.executeQuery(); 
			
			if(rs.next()) { 
				vendor = new Vendor(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7), rs.getString(8), rs.getString(9), rs.getString(10), rs.getString(11), rs.getString(12), rs.getInt(15), rs.getString(16)); 
			} 
		}catch(Exception e) { 
			throw e;
		}finally { 
			DBClose.close(con,pstmt,rs); 
		} 
		
		return vendor; 
	} 

		
	// list page 
	public ArrayList<Vendor> getVendorList() throws Exception { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		
		ArrayList<Vendor> alist = new ArrayList<Vendor>(); 
		
		try { 
			StringBuffer sqlBuf=new StringBuffer(); 

			sqlBuf.append("		select 	a.vendorNo, ");
			sqlBuf.append("				a.vendorNm, ");
			sqlBuf.append("				a.phoneNo, ");
			sqlBuf.append("				a.mobileNo, ");
			sqlBuf.append("				a.faxNo, ");
			
			sqlBuf.append("				a.chargeEmpNm, ");
			sqlBuf.append("				a.email, ");
			sqlBuf.append("				a.countryCd, ");
			sqlBuf.append("				a.addr, ");
			sqlBuf.append("				a.note, ");
			sqlBuf.append("				a.insertUserId, ");
			sqlBuf.append("				a.insertDatetime, ");
			sqlBuf.append("				a.updateUserId, ");
			sqlBuf.append("				a.updateDatetime "); 
			sqlBuf.append("				, (select count(0) from item where vendorNo = a.vendorNo) as dealCnt");
			sqlBuf.append("				, (select cdNm from code where classCd = '01' and cd = a.countryCd) as countryNm");
			sqlBuf.append("		from vendor a ");
			sqlBuf.append("		order by vendorNm;");
			
			pstmt = con.prepareStatement(sqlBuf.toString()); 
//System.out.println(pstmt.toString());
			rs = pstmt.executeQuery(); 
			
			while(rs.next()) { 
				Vendor vendor = new Vendor(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7), rs.getString(8), rs.getString(9), rs.getString(10), rs.getString(11), rs.getString(12), rs.getInt(15), rs.getString(16)); 
				alist.add(vendor); 
			} 
		}catch(Exception e) { 
			throw e;
		}finally { 
			DBClose.close(con,pstmt,rs); 
		} return alist; 
	} 
	
	
	public void insertVendor(Vendor vendor) throws Exception { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		
		try { 
			sql = "insert into vendor (vendorNo, vendorNm, phoneNo, mobileNo, faxNo, chargeEmpNm, email, countryCd, addr, note, insertUserId, insertDatetime) VALUES (?,?,?,?,?,?,?,?,?,?,?, current_timestamp())"; 
			pstmt = con.prepareStatement(sql); 

			pstmt.setInt(1, vendor.getVendorNo());
			pstmt.setString(2, vendor.getVendorNm()); 
			pstmt.setString(3, vendor.getPhoneNo()); 
			pstmt.setString(4, vendor.getMobileNo());
			pstmt.setString(5, vendor.getFaxNo());
			pstmt.setString(6, vendor.getChargeEmpNm());
			pstmt.setString(7, vendor.getEmail());
			pstmt.setString(8, vendor.getCountryCd());
			pstmt.setString(9, vendor.getAddr());
			pstmt.setString(10, vendor.getNote());
			pstmt.setString(11, vendor.getInsertUserId());
			
			pstmt.execute(); 
			//System.out.println(sql);
			
		}catch(Exception e) { 
			throw e;
		}finally { 
			DBClose.close(con,pstmt); 
		} 
	} 
	
	
	public void modifyVendor(Vendor vendor) throws Exception { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		
		try { 
			sql = "update vendor set vendorNm=?, phoneNo=?, mobileNo=?, faxNo=?, chargeEmpNm=?, email=?, countryCd=?, addr=?, note=?, updateUserId=?, updateDatetime=current_timestamp() where vendorNo=?";
			
			pstmt = con.prepareStatement(sql);

			pstmt.setString(1, vendor.getVendorNm()); 
			pstmt.setString(2, vendor.getPhoneNo()); 
			pstmt.setString(3, vendor.getMobileNo());
			pstmt.setString(4, vendor.getFaxNo());
			pstmt.setString(5, vendor.getChargeEmpNm());
			pstmt.setString(6, vendor.getEmail());
			pstmt.setString(7, vendor.getCountryCd());
			pstmt.setString(8, vendor.getAddr());
			pstmt.setString(9, vendor.getNote());
			pstmt.setString(10, vendor.getUpdateUserId());
			pstmt.setInt(11, vendor.getVendorNo());
			
			pstmt.executeUpdate();
			//System.out.println(sql);
			
		}catch(Exception e) { 
			throw e;
		}finally { 
			DBClose.close(con,pstmt); 
		} 
	} 
		

	public void deleteVendor(int vendorNo) throws Exception { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		
		try { 
			sql = "delete from vendor where vendorNo = ?";
			
			pstmt = con.prepareStatement(sql); 
			pstmt.setInt(1, vendorNo); 
			pstmt.executeUpdate();
			
			//System.out.println(sql);
			
		}catch(Exception e) { 
			throw e;
		}finally { 
			DBClose.close(con,pstmt); 
		} 
	} 
	
}



