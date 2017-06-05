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
	
	public String incoding(String data) { 
		try { 
			data = new String(data.getBytes("8859_1"), "euc-kr"); 
		}catch (Exception e){ } 
		return data; 
	} 
	
	
	public ArrayList<Item> getItemList(String whNo) throws Exception {
		return this.getItemList(Integer.parseInt(whNo));
	}
	
	public ArrayList<Item> getItemList() throws Exception { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		ArrayList<Item> alist = new ArrayList<Item>(); 
		
		try { 
			
			StringBuffer sqlBuf = new StringBuffer(); 

			sqlBuf.append("		select a.*"); 
			sqlBuf.append("       from item a");
			sqlBuf.append("        order by itemId");
			System.out.println(sqlBuf.toString());
			
			pstmt = con.prepareStatement(sqlBuf.toString()); 
			rs = pstmt.executeQuery(); 
			
			/*
			private int itemNo;
			private String itemId;
			private String itemNm;
			private String itemNmKor;
			private String sku;
			
			private String vendorId;
			private int price;
			private String curCd;
			private int priceMeta;
			private int priceFactory;
			
			private int priceCenter;
			private int priceClient;
			private float serviceHour;
			private int moqVendor;
			private int moqCenter;
			
			private int requiredStockCnt;
			private int defectStockCnt;
			private String linkItem;
			private String linkInvoice;
			private String note;
			
			private String insertUserId;
			private String insertDatetime;
			private String updateUserId;
			private String updateDatetime;//24
			
			
			*/
			
			while(rs.next()) { 
				
				//note:vincent:20170518:filtering price_client
				
				//if(rs.getInt(11) == 0)
				//	continue;
				
				Item item = new Item(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getInt(7), rs.getString(8), rs.getInt(9), rs.getInt(10), rs.getInt(11), rs.getInt(12), rs.getFloat(13), rs.getInt(14), rs.getInt(15), rs.getInt(16), rs.getInt(17), rs.getString(18), rs.getString(19), rs.getString(20), rs.getString(21), rs.getString(22), rs.getString(23), rs.getString(24));
				
				/*
				item.setItemNo(rs.getInt(1)); 
				item.setItemNm(rs.getString(2)); 
				item.setInsertUserId(rs.getString(3)); 
				item.setInsertDatetime(rs.getString(4).toString()); 
				*/
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
			e.printStackTrace();
			throw e;
		}finally { 
			DBClose.close(con,pstmt,rs); 
		} return alist; 
	} 
	
	public ArrayList<Item> getItemList(int whNo) throws Exception { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		ArrayList<Item> alist = new ArrayList<Item>(); 
		
		try { 
			
			StringBuffer sqlBuf = new StringBuffer(); 

			sqlBuf.append("		select a.*"); 
			sqlBuf.append("            , ifnull(b.itemCnt,0) as itemCnt");
			sqlBuf.append("       from item a");
			sqlBuf.append("       left outer join whItem b");
			sqlBuf.append("         on a.itemNo = b.itemNo");
			sqlBuf.append("        and b.whNo = ?");
			sqlBuf.append("        order by itemId");
			System.out.println(sqlBuf.toString());
			
			pstmt = con.prepareStatement(sqlBuf.toString()); 
			pstmt.setInt(1, whNo); 
			rs = pstmt.executeQuery(); 
			
			/*
			private int itemNo;
			private String itemId;
			private String itemNm;
			private String itemNmKor;
			private String sku;
			
			private String vendorId;
			private int price;
			private String curCd;
			private int priceMeta;
			private int priceFactory;
			
			private int priceCenter;
			private int priceClient;
			private float serviceHour;
			private int moqVendor;
			private int moqCenter;
			
			private int requiredStockCnt;
			private int defectStockCnt;
			private String linkItem;
			private String linkInvoice;
			private String note;
			
			private String insertUserId;
			private String insertDatetime;
			private String updateUserId;
			private String updateDatetime;//24
			
	private int itemCnt; // from whItem
			
			*/
			
			while(rs.next()) { 
				
				//note:vincent:20170518:filtering price_client
				
				//if(rs.getInt(11) == 0)
				//	continue;
				
				Item item = new Item(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getInt(7), rs.getString(8), rs.getInt(9), rs.getInt(10), rs.getInt(11), rs.getInt(12), rs.getFloat(13), rs.getInt(14), rs.getInt(15), rs.getInt(16), rs.getInt(17), rs.getString(18), rs.getString(19), rs.getString(20), rs.getString(21), rs.getString(22), rs.getString(23), rs.getString(24), rs.getInt(25));
				
				/*
				item.setItemNo(rs.getInt(1)); 
				item.setItemNm(rs.getString(2)); 
				item.setInsertUserId(rs.getString(3)); 
				item.setInsertDatetime(rs.getString(4).toString()); 
				*/
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
			e.printStackTrace();
			throw e;
		}finally { 
			DBClose.close(con,pstmt,rs); 
		} 
		
		return alist; 
	} 
	
	public ArrayList<Item> getItemList(int srcWhNo, int destWhNo) throws Exception {
		
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		ArrayList<Item> alist = new ArrayList<Item>(); 
		
		try { 
			
			StringBuffer sqlBuf = new StringBuffer(); 

			sqlBuf.append("		select a.*"); 
			sqlBuf.append("            , ifnull(b.itemCnt,0) as srcItemCnt");
			sqlBuf.append("            , ifnull(c.itemCnt,0) as destItemCnt");
			sqlBuf.append("       from item a");
			sqlBuf.append("       left outer join whItem b");
			sqlBuf.append("         on a.itemNo = b.itemNo");
			sqlBuf.append("        and b.whNo = ?");
			sqlBuf.append("       left outer join whItem c");
			sqlBuf.append("         on a.itemNo = c.itemNo");
			sqlBuf.append("        and c.whNo = ?");
			sqlBuf.append("        order by itemId");
			System.out.println(sqlBuf.toString());
			
			pstmt = con.prepareStatement(sqlBuf.toString()); 
			pstmt.setInt(1, srcWhNo); 
			pstmt.setInt(2, destWhNo); 
			rs = pstmt.executeQuery(); 
			
			/*
			private int itemNo;
			private String itemId;
			private String itemNm;
			private String itemNmKor;
			private String sku;
			
			private String vendorId;
			private int price;
			private String curCd;
			private int priceMeta;
			private int priceFactory;
			
			private int priceCenter;
			private int priceClient;
			private float serviceHour;
			private int moqVendor;
			private int moqCenter;
			
			private int requiredStockCnt;
			private int defectStockCnt;
			private String linkItem;
			private String linkInvoice;
			private String note;
			
			private String insertUserId;
			private String insertDatetime;
			private String updateUserId;
			private String updateDatetime;//24
			
	private int srcItemCnt; // from to
	private int destItemCnt; // from to
			
			*/
			
			while(rs.next()) { 
				
				//note:vincent:20170518:filtering price_client
				
				//if(rs.getInt(11) == 0)
				//	continue;
				
				Item item = new Item(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getInt(7), rs.getString(8), rs.getInt(9), rs.getInt(10), rs.getInt(11), rs.getInt(12), rs.getFloat(13), rs.getInt(14), rs.getInt(15), rs.getInt(16), rs.getInt(17), rs.getString(18), rs.getString(19), rs.getString(20), rs.getString(21), rs.getString(22), rs.getString(23), rs.getString(24), rs.getInt(25), rs.getInt(26));
				
				/*
				item.setItemNo(rs.getInt(1)); 
				item.setItemNm(rs.getString(2)); 
				item.setInsertUserId(rs.getString(3)); 
				item.setInsertDatetime(rs.getString(4).toString()); 
				*/
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
			e.printStackTrace();
			throw e;
		}finally { 
			DBClose.close(con,pstmt,rs); 
		} 
		
		return alist; 		
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
			
			sql = "insert into item (itemNo, itemId, itemNm, itemNmKor, insertDatetime) VALUES (?,?,?,?, current_timestamp())"; 
			pstmt = con.prepareStatement(sql); 

			pstmt.setInt(1, max+1);
			pstmt.setString(2, incoding(item.getItemId())); 
			pstmt.setString(3, incoding(item.getItemNm())); 
			pstmt.setString(4, incoding(item.getItemNmKor()));
			
			pstmt.execute(); 
		}catch(Exception e) { 
			
		}finally { 
			DBClose.close(con,pstmt); 
		} 
	} 
	
	public Item getItemInfo(int itemNo) { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		Item item = null; 
		
		try { 
			sql = "select * from item where itemNo = ?"; 
			pstmt = con.prepareStatement(sql); 
			pstmt.setInt(1, itemNo); 
			rs = pstmt.executeQuery(); 
			
			if(rs.next()) { 
				item = new Item(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4)); 
				/*
				item = new Item(); 
				item.setItemNo(rs.getInt(1)); 
				item.setItemNm(rs.getString(2)); 
				item.setInsertUserId(rs.getInt(3)); 
				item.setInsertDatetime(rs.getString(4).toString());
				*/ 
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
	
	public void deleteItem(int itemNo) { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		try { 
			sql = "delete from item where itemNo = ?"; 
			pstmt = con.prepareStatement(sql); 
			pstmt.setInt(1, itemNo); 
			pstmt.executeUpdate(); 
		}catch(Exception e) { 
		
		}finally { 
			DBClose.close(con,pstmt); 
		} 
	} 
	
	public void modifyItem(Item item, int itemNo) { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		try { 
			sql = "update item set itemNm=? where itemNo=?"; 
			pstmt = con.prepareStatement(sql); 
			pstmt.setString(1, incoding(item.getItemNm())); 
			pstmt.setInt(2, itemNo); 
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
			pstmt.setString(1, incoding(item.getName())); 
			pstmt.setString(2, incoding(item.getPassword())); 
			pstmt.setString(3, incoding(item.getTitle())); 
			pstmt.setString(4, incoding(item.getMemo())); 
			pstmt.setInt(5, ref); pstmt.setInt(6, indent+1); 
			pstmt.setInt(7, step+1); 
			pstmt.execute(); 
		}catch(Exception e) { 
			
		}finally { 
			DBClose.close(con,pstmt); 
		} 
	}*/
	
	
}



