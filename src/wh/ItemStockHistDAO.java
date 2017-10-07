package wh;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import common.DAO;
import common.DBClose;

public class ItemStockHistDAO extends DAO {

	public ItemStockHistDAO() {
		// TODO Auto-generated constructor stub
	}
	
	
	// 처리 시각 - 현재시간 기준. 
	private int getNextSeq(int whNo, int itemNo) throws Exception {
		
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		int no = 0; 
		
		try { 
			StringBuffer sqlBuf = new StringBuffer();
//System.out.println("next... " + whNo + " / " + itemNo);			
			sqlBuf.append("select ifnull(max(dealSeq),0)+1 ");
			sqlBuf.append("	 from itemStockHist ");
			sqlBuf.append("	where whNo = ? ");
			sqlBuf.append("	  and itemNo = ? ");
			//sqlBuf.append("	  and dealDt = ? ");
			sqlBuf.append("	  and dealDt = current_date(); ");
			
//System.out.println(sqlBuf.toString());
			pstmt = con.prepareStatement(sqlBuf.toString()); 
			pstmt.setInt(1, whNo); 
			pstmt.setInt(2, itemNo); 
			//pstmt.setString(3, dealDt); 
//System.out.println(pstmt.toString());
			
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
	
	/*
	public int countItemStockHist(int whNo, int itemNo, String fromDt, String toDt) throws Exception {
		
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		int cnt = 0; 
		
		try { 
			StringBuffer sqlBuf=new StringBuffer();
			
			sqlBuf.append("select count(0) ");
			sqlBuf.append("	 from itemStockHist ");
			sqlBuf.append("	where whNo = ifnull(?,whNo) ");
			sqlBuf.append("	  and itemNo = ifnull(?,itemNo) ");
			sqlBuf.append("	  and dealDt >= ifnull(?,fromDt) ");
			sqlBuf.append("	  and dealDt <= ifnull(?,toDt) ");
			
			pstmt.setInt(1, whNo); 
			pstmt.setInt(2, itemNo); 
			pstmt.setString(3, fromDt); 
			pstmt.setString(4, toDt); 
			pstmt = con.prepareStatement(sql); 
System.out.println(pstmt.toString());
			
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
	*/
	/*
	public ItemStockHist getItemStockHistInfo(int itemStockHistNo) throws Exception { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		ItemStockHist itemStockHist = null; 
		
		try { 
			StringBuffer sqlBuf=new StringBuffer(); 

			sqlBuf.append("		select 	a.itemStockHistNo, ");
			sqlBuf.append("				a.itemStockHistNm, ");
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
			sqlBuf.append("				, (select count(0) from item where itemStockHistNo = a.itemStockHistNo) as dealCnt");
			sqlBuf.append("				, (select cdNm from code where classCd = '01' and cd = a.countryCd) as countryNm");

			sqlBuf.append("		  from itemStockHist a ");
			sqlBuf.append("		 where itemStockHistNo = ?;");
			
			pstmt = con.prepareStatement(sqlBuf.toString()); 
			pstmt.setInt(1, itemStockHistNo); 
//System.out.println(pstmt.toString());
			rs = pstmt.executeQuery(); 
			
			if(rs.next()) { 
				itemStockHist = new ItemStockHist(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7), rs.getString(8), rs.getString(9), rs.getString(10), rs.getString(11), rs.getString(12), rs.getInt(15), rs.getString(16)); 
			} 
		}catch(Exception e) { 
			throw e;
		}finally { 
			DBClose.close(con,pstmt,rs); 
		} 
		
		return itemStockHist; 
	} 
*/
		/*
	// list page 
	public int countItemStockHist(int whNo, int itemNo, String fromDt, String toDt) throws Exception {
		
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		int cnt = 0; 
		
		try { 
			StringBuffer sqlBuf=new StringBuffer();
			
			sqlBuf.append("select count(0) ");
			sqlBuf.append("	 from itemStockHist ");
			sqlBuf.append("	where whNo = ifnull(?,whNo) ");
			sqlBuf.append("	  and itemNo = ifnull(?,itemNo) ");
			sqlBuf.append("	  and dealDt >= ifnull(?,fromDt) ");
			sqlBuf.append("	  and dealDt <= ifnull(?,toDt); ");
			
			pstmt.setInt(1, whNo); 
			pstmt.setInt(2, itemNo); 
			pstmt.setString(3, fromDt); 
			pstmt.setString(4, toDt); 
			pstmt = con.prepareStatement(sql); 
System.out.println(pstmt.toString());
			
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
	*/
	
	public ArrayList<ItemStockHist> getItemStockHistList(int whNo, int itemNo, String fromDt, String toDt, String dealType) throws Exception { 
		
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		
		ArrayList<ItemStockHist> alist = new ArrayList<ItemStockHist>(); 
		
		try { 
			StringBuffer sqlBuf=new StringBuffer(); 
			
			sqlBuf.append("		select 	a.whNo, ");
			sqlBuf.append("				a.itemNo, ");
			sqlBuf.append("				a.dealDt, ");
			sqlBuf.append("				a.dealSeq, ");
			sqlBuf.append("				a.dealType, ");
			
			sqlBuf.append("				a.orderType, ");//6
			sqlBuf.append("				a.orderNo, ");
			sqlBuf.append("				a.beforeCnt, ");
			sqlBuf.append("				a.dealCnt, ");
			sqlBuf.append("				a.afterCnt, ");
			
			sqlBuf.append("				a.insertUserId, ");
			sqlBuf.append("				a.insertDatetime, ");//12
			sqlBuf.append("				a.updateUserId, ");
			sqlBuf.append("				a.updateDatetime "); 
			
			sqlBuf.append("				, (select whNm from wh where whNo = a.whNo) as whNm ");//15
			sqlBuf.append("				, (select itemNm from item where itemNo = a.itemNo) as itemNm ");
			
			sqlBuf.append("				, case a.dealType when '01' then '입고' when '02' then '출고' end as dealTypeStr ");
			
			sqlBuf.append("				, (select whNm from wh where whNo = b.srcWhNo) as srcWhNm ");
			sqlBuf.append("				, (select whNm from wh where whNo = b.destWhNo) as destWhNm ");
			sqlBuf.append("		from itemStockHist a ");
			sqlBuf.append("		left outer join orderT b ");
			sqlBuf.append("		  on a.orderType = 'T' and a.orderNo = b.orderNo ");
			sqlBuf.append("	   where whNo = whNo ");
			
			if(whNo != -1)
				sqlBuf.append("	  and whNo = '" + whNo + "' ");
			if(itemNo != -1)
				sqlBuf.append("	  and itemNo = '" + itemNo + "' ");
System.out.println("_" +dealType+"_");			
			if(dealType != null && !dealType.equals(""))
				sqlBuf.append("	  and dealType = '" + dealType + "' ");
			
			sqlBuf.append("	  and dealDt >= ifnull(?,dealDt) ");
			sqlBuf.append("	  and dealDt <= ifnull(?,dealDt); ");
//			sqlBuf.append("		order by itemStockHistNm;");
			
			pstmt = con.prepareStatement(sqlBuf.toString()); 
			pstmt.setString(1, fromDt); 
			pstmt.setString(2, toDt);
			
System.out.println(pstmt.toString());

			rs = pstmt.executeQuery(); 
			
			while(rs.next()) { 
				
				ItemStockHist itemStockHist = new ItemStockHist(rs.getInt(1), rs.getInt(2), rs.getString(3), rs.getInt(4), rs.getString(5), rs.getString(6), rs.getInt(7), rs.getInt(8), rs.getInt(9), rs.getInt(10), rs.getString(12), rs.getString(15), rs.getString(16), rs.getString(17), rs.getString(18), rs.getString(19));

				if(itemStockHist.getOrderType().equals("P"))
					itemStockHist.setOrderNoStr(MrUtil.getPOrderNoStr(itemStockHist.getOrderNo()));
				if(itemStockHist.getOrderType().equals("T"))
					itemStockHist.setOrderNoStr(MrUtil.getTOrderNoStr(itemStockHist.getOrderNo()));
				
				alist.add(itemStockHist); 
			} 
		}catch(Exception e) { 
			throw e;
		}finally { 
			DBClose.close(con,pstmt,rs); 
		} return alist; 
	} 
	
	
	public void insertItemStockHist(ItemStockHist itemStockHist) throws Exception { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		
		try { 
			String IN = "01";
			String OUT = "02";
			
//System.out.println("insertItemStockHist !!! ");			
//System.out.println(itemStockHist.getWhNo() + "/" +itemStockHist.getItemNo());
			int nextSeq = getNextSeq(itemStockHist.getWhNo(), itemStockHist.getItemNo());
//System.out.println("nextSeq : " + nextSeq);			
			int beforeCnt = new WhItemDAO().getWhItemCnt(itemStockHist.getWhNo(), itemStockHist.getItemNo());
//System.out.println("beforeCnt : " + beforeCnt);			
			int afterCnt = -1;
			if(itemStockHist.getDealType().equals(IN))
				afterCnt = beforeCnt + itemStockHist.getDealCnt();
			else //OUT
				afterCnt = beforeCnt - itemStockHist.getDealCnt();
//System.out.println("afterCnt : " + afterCnt);			
			
			sql = "insert into itemStockHist (whNo, itemNo, dealDt, dealSeq, dealType, orderType, orderNo, beforeCnt, dealCnt, afterCnt, insertUserId, insertDatetime) VALUES (?,?,current_date(),?,?,?,?,?,?,?,?, current_timestamp())"; 
			pstmt = con.prepareStatement(sql); 

			pstmt.setInt(1, itemStockHist.getWhNo());
			pstmt.setInt(2, itemStockHist.getItemNo()); 
			//pstmt.setString(3, itemStockHist.getDealDt()); 
			//pstmt.setInt(4, itemStockHist.getDealSeq());
			pstmt.setInt(3, nextSeq);
			
			pstmt.setString(4, itemStockHist.getDealType());
			pstmt.setString(5, itemStockHist.getOrderType());
			pstmt.setInt(6, itemStockHist.getOrderNo());
			pstmt.setInt(7, beforeCnt);
			pstmt.setInt(8, itemStockHist.getDealCnt());
			pstmt.setInt(9, afterCnt);
			pstmt.setString(10, itemStockHist.getInsertUserId());

//System.out.println(pstmt.toString());
			pstmt.execute(); 
			
		}catch(Exception e) { 
			throw e;
		}finally { 
			DBClose.close(con,pstmt); 
		} 
	} 
	
	/*
	public void modifyItemStockHist(ItemStockHist itemStockHist) throws Exception { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		
		try { 
			sql = "update itemStockHist set itemStockHistNm=?, phoneNo=?, mobileNo=?, faxNo=?, chargeEmpNm=?, email=?, countryCd=?, addr=?, note=?, updateUserId=?, updateDatetime=current_timestamp() where itemStockHistNo=?";
			
			pstmt = con.prepareStatement(sql);

			pstmt.setString(1, itemStockHist.getItemStockHistNm()); 
			pstmt.setString(2, itemStockHist.getPhoneNo()); 
			pstmt.setString(3, itemStockHist.getMobileNo());
			pstmt.setString(4, itemStockHist.getFaxNo());
			pstmt.setString(5, itemStockHist.getChargeEmpNm());
			pstmt.setString(6, itemStockHist.getEmail());
			pstmt.setString(7, itemStockHist.getCountryCd());
			pstmt.setString(8, itemStockHist.getAddr());
			pstmt.setString(9, itemStockHist.getNote());
			pstmt.setString(10, itemStockHist.getUpdateUserId());
			pstmt.setInt(11, itemStockHist.getItemStockHistNo());
			
			pstmt.executeUpdate();
			//System.out.println(sql);
			
		}catch(Exception e) { 
			throw e;
		}finally { 
			DBClose.close(con,pstmt); 
		} 
	} 
		*/
/*
	public void deleteItemStockHist(int itemStockHistNo) throws Exception { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		
		try { 
			sql = "delete from itemStockHist where itemStockHistNo = ?";
			
			pstmt = con.prepareStatement(sql); 
			pstmt.setInt(1, itemStockHistNo); 
			pstmt.executeUpdate();
			
			//System.out.println(sql);
			
		}catch(Exception e) { 
			throw e;
		}finally { 
			DBClose.close(con,pstmt); 
		} 
	} 
	*/
}
