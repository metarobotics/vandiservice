package wh; 

import java.sql.Connection; 
import java.sql.PreparedStatement; 
import java.sql.ResultSet; 
import java.text.SimpleDateFormat; 
import java.util.ArrayList; 
import java.util.Date; 

public class MrDAO extends DAO { 
	
	public MrDAO() {
		// TODO Auto-generated constructor stub
	}

	
	/********************
	 * Company
	 ********************/
	
	public Company getCompanyInfo(int companyNo) throws Exception { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		Company company = null; 
		
		try { 
			StringBuffer sqlBuf=new StringBuffer(); 

			sqlBuf.append("		select  a.companyNo, ");
			sqlBuf.append("				a.companyId, ");
			sqlBuf.append("				a.companyNm, ");
			sqlBuf.append("				a.ceoNm, ");
			sqlBuf.append("				a.phoneNo, ");
			sqlBuf.append("				a.mobileNo, ");
			sqlBuf.append("				a.faxNo, ");
			sqlBuf.append("				a.email, ");
			sqlBuf.append("				a.addr, ");
			sqlBuf.append("				a.acntBankNm, ");
			sqlBuf.append("				a.acntNo, ");
			sqlBuf.append("				a.acntUserNm, ");
			sqlBuf.append("				a.insertUserId, ");
			sqlBuf.append("				a.insertDatetime, ");
			sqlBuf.append("				a.updateUserId, ");
			sqlBuf.append("				a.updateDatetime  ");
			sqlBuf.append("		  from company a ");
			sqlBuf.append("		 where companyNo = ?;");
			
			pstmt = con.prepareStatement(sqlBuf.toString()); 
			pstmt.setInt(1, companyNo); 
			rs = pstmt.executeQuery(); 
			
			if(rs.next()) { 
				company = new Company(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7), rs.getString(8), rs.getString(9), rs.getString(10), rs.getString(11), rs.getString(12), rs.getString(13), rs.getString(14), rs.getString(15), rs.getString(16)); 
			} 
		}catch(Exception e) { 
			throw e;
		}finally { 
			DBClose.close(con,pstmt,rs); 
		} 
		
		return company; 
	} 
	
	
	/********************
	 * Model
	 ********************/
	
	public Model getModelInfo(int modelNo) throws Exception { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		Model model = null; 
		
		try { 
			StringBuffer sqlBuf=new StringBuffer(); 

			sqlBuf.append("		select  a.modelNo, ");
			sqlBuf.append("				a.modelId, ");
			sqlBuf.append("				a.modelNmKor, ");
			sqlBuf.append("				a.modelNmEng, ");
			sqlBuf.append("				a.createDt, ");
			sqlBuf.append("				a.insertUserId, ");
			sqlBuf.append("				a.insertDatetime, ");
			sqlBuf.append("				a.updateUserId, ");
			sqlBuf.append("				a.updateDatetime  ");
			sqlBuf.append("		  from model a ");
			sqlBuf.append("		 where modelNo = ?;");
			
			pstmt = con.prepareStatement(sqlBuf.toString()); 
			pstmt.setInt(1, modelNo); 
			rs = pstmt.executeQuery(); 
			
			if(rs.next()) { 
				model = new Model(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7), rs.getString(8), rs.getString(9)); 
			} 
		}catch(Exception e) { 
			throw e;
		}finally { 
			DBClose.close(con,pstmt,rs); 
		} 
		
		return model; 
	} 
		
	
	public ArrayList<Model> getModelList() throws Exception { 
		
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		
		ArrayList<Model> alist = new ArrayList<Model>(); 
		
		try { 
			StringBuffer sqlBuf=new StringBuffer(); 

			sqlBuf.append("		select  ");
			sqlBuf.append("				a.modelNo, ");
			sqlBuf.append("				a.modelId, ");
			sqlBuf.append("				a.modelNmKor, ");
			sqlBuf.append("				a.modelNmEng, ");
			sqlBuf.append("				a.createDt, ");
			
			sqlBuf.append("				a.insertUserId, ");
			sqlBuf.append("				a.insertDatetime, ");
			sqlBuf.append("				a.updateUserId, ");
			sqlBuf.append("				a.updateDatetime  ");//9
			sqlBuf.append("		  from model a ");
			sqlBuf.append("		 order by modelNo ");
			
			pstmt = con.prepareStatement(sqlBuf.toString()); 
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Model model = new Model(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7), rs.getString(8), rs.getString(9)); 
				alist.add(model); 
			} 
		}catch(Exception e) { 
			throw e;
		}finally { 
			DBClose.close(con,pstmt,rs); 
		} 
		
		return alist; 
	} 
	
	
	
	/********************
	 * ModelItem
	 ********************/
	
	public ArrayList<ModelItem> getModelItemList(int modelNo) throws Exception { 
		
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		
		ArrayList<ModelItem> alist = new ArrayList<ModelItem>(); 
		
		try { 
			StringBuffer sqlBuf=new StringBuffer(); 

			sqlBuf.append("		select  a.modelNo, ");
			sqlBuf.append("				a.itemId, ");
			sqlBuf.append("				a.itemCnt, ");
			sqlBuf.append("				a.insertUserId, ");
			sqlBuf.append("				a.insertDatetime, ");
			sqlBuf.append("				a.updateUserId, ");
			sqlBuf.append("				a.updateDatetime  ");
			sqlBuf.append("          , ifnull(b.itemNm, ''), ifnull(b.itemNmKor, '') ");
			sqlBuf.append("		 from modelItem a ");
			sqlBuf.append("		 left join item b ");
			sqlBuf.append("		   on a.itemId = b.itemId ");
			sqlBuf.append("		where a.modelNo = ?");
			sqlBuf.append("		  and a.itemCnt > 0");
			
			pstmt = con.prepareStatement(sqlBuf.toString()); 
			pstmt.setInt(1, modelNo); 
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ModelItem modelItem = new ModelItem(rs.getInt(1), rs.getString(2), rs.getInt(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7), rs.getString(8), rs.getString(9)); 
				alist.add(modelItem); 
			} 
		}catch(Exception e) { 
			throw e;
		}finally { 
			DBClose.close(con,pstmt,rs); 
		} 
		
		return alist; 
	} 
	
	

	/********************
	 * Wh
	 ********************/	
	
	public ArrayList<Wh> getWhList() throws Exception { 
		
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		
		ArrayList<Wh> alist = new ArrayList<Wh>(); 
		
		try { 
			
			StringBuffer sqlBuf=new StringBuffer(); 

			sqlBuf.append("		select  a.whNo, ");
			sqlBuf.append("				a.whId, ");
			sqlBuf.append("				a.whNm, ");
			sqlBuf.append("				a.whType, ");
			sqlBuf.append("				a.location, ");
			sqlBuf.append("				a.addr, ");
			sqlBuf.append("				a.mgrUserNo, ");
			sqlBuf.append("				a.note, ");
			sqlBuf.append("				a.useYn, ");
			sqlBuf.append("				a.insertUserId, ");
			sqlBuf.append("				a.insertDatetime, ");
			sqlBuf.append("				a.updateUserId, ");
			sqlBuf.append("				a.updateDatetime  ");
			sqlBuf.append("		  from wh a ");
			sqlBuf.append("		 where useYn = 'Y' ");
			sqlBuf.append("		 order by whNo ");
			
			pstmt = con.prepareStatement(sqlBuf.toString()); 
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Wh wh = new Wh(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4)); 
				alist.add(wh); 
			} 
		}catch(Exception e) { 
			throw e;
		}finally { 
			DBClose.close(con,pstmt,rs); 
		} 
		
		return alist; 
	} 

	public ArrayList<Wh> getWhList(String whType) throws Exception { 
		
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		
		ArrayList<Wh> alist = new ArrayList<Wh>(); 
		
		try { 
			
			StringBuffer sqlBuf=new StringBuffer(); 

			sqlBuf.append("		select  a.whNo, ");
			sqlBuf.append("				a.whId, ");
			sqlBuf.append("				a.whNm, ");
			sqlBuf.append("				a.whType, ");
			sqlBuf.append("				a.location, ");
			sqlBuf.append("				a.addr, ");
			sqlBuf.append("				a.mgrUserNo, ");
			sqlBuf.append("				a.note, ");
			sqlBuf.append("				a.useYn, ");
			sqlBuf.append("				a.insertUserId, ");
			sqlBuf.append("				a.insertDatetime, ");
			sqlBuf.append("				a.updateUserId, ");
			sqlBuf.append("				a.updateDatetime  ");
			sqlBuf.append("		  from wh a ");
			sqlBuf.append("		 where useYn = 'Y' ");
			sqlBuf.append("		   and whType = ? ");
			sqlBuf.append("		 order by whNo ");
			
			pstmt = con.prepareStatement(sqlBuf.toString()); 
			pstmt.setString(1, whType);
//System.out.println(pstmt.toString());			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Wh wh = new Wh(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4)); 
				alist.add(wh); 
			} 
		}catch(Exception e) { 
			throw e;
		}finally { 
			DBClose.close(con,pstmt,rs); 
		} 
		
		return alist; 
	} 

	/********************
	 * ItemGrp
	 ********************/	
	
	public ArrayList<ItemGrp> getItemGrpList() throws Exception {
		
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		
		ArrayList<ItemGrp> alist = new ArrayList<ItemGrp>(); 
		
		try { 
			StringBuffer sqlBuf=new StringBuffer(); 

			sqlBuf.append("		select  a.itemGrpNo, ");
			sqlBuf.append("				a.itemGrpId, ");
			sqlBuf.append("				a.grp1Cd, ");
			sqlBuf.append("				a.grp2Cd, ");
			sqlBuf.append("				a.grp3Cd, ");
			sqlBuf.append("				a.grp1Nm, ");
			sqlBuf.append("				a.grp2Nm, ");
			sqlBuf.append("				a.grp3Nm, ");
			sqlBuf.append("				a.note, ");
			sqlBuf.append("				a.insertUserId, ");
			sqlBuf.append("				a.insertDatetime, ");
			sqlBuf.append("				a.updateUserId, ");
			sqlBuf.append("				a.updateDatetime  ");
			sqlBuf.append("		  from itemGrp a ");
			sqlBuf.append("		 order by itemGrpId ");
			
			pstmt = con.prepareStatement(sqlBuf.toString()); 
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ItemGrp itemGrp = new ItemGrp(rs.getInt(1), rs.getString(2), rs.getInt(3), rs.getInt(4), rs.getInt(5), rs.getString(6), rs.getString(7), rs.getString(8), rs.getString(9), rs.getString(10), rs.getString(11), rs.getString(12), rs.getString(13)); 
				alist.add(itemGrp); 
			} 
		}catch(Exception e) { 
			throw e;
		}finally { 
			DBClose.close(con,pstmt,rs); 
		} 
		
		return alist; 
	} 

	
	public int countItemGrp() throws Exception { 
		
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		int cnt = 0; 
		
		try { 
			sql = "SELECT COUNT(0) FROM itemGrp"; 
			
			pstmt = con.prepareStatement(sql); 
			rs = pstmt.executeQuery(); 
			
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
	
	

	/********************
	 * Accessory
	 ********************/	
	
	public ArrayList<Accessory> getAccessoryList() throws Exception { 
		
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		
		ArrayList<Accessory> alist = new ArrayList<Accessory>(); 
		
		try { 
			StringBuffer sqlBuf=new StringBuffer(); 

			sqlBuf.append("	select  a.accNo, ");
			sqlBuf.append("			a.accId, ");
			sqlBuf.append("			a.accNm, ");
			sqlBuf.append("			a.salesAmt ");
			sqlBuf.append("	  from accessory a ");
			sqlBuf.append("	 order by accNo ");
			
			pstmt = con.prepareStatement(sqlBuf.toString()); 
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Accessory accessory = new Accessory(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getInt(4)); 
				alist.add(accessory); 
			} 
		}catch(Exception e) { 
			throw e;
		}finally { 
			DBClose.close(con,pstmt,rs); 
		} 
		
		return alist; 
	} 
	
		
}