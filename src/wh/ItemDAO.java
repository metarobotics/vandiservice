package wh; 

import java.sql.Connection; 
import java.sql.PreparedStatement; 
import java.sql.ResultSet; 
import java.text.SimpleDateFormat; 
import java.util.ArrayList; 
import java.util.Date; 

public class ItemDAO extends DAO { 
	
	public ItemDAO() {
		// TODO Auto-generated constructor stub
	}
	
	public int getNextItemNo() throws Exception {
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		int no = 0; 
		
		try { 
			sql = "select ifnull(max(itemNo),0)+1 from item"; 
			
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
		
	public int countItem() throws Exception { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		int cnt = 0; 
		
		try { 
			
			sql = "SELECT COUNT(0) FROM item"; 
			
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

			sqlBuf.append("		select  a.itemNo, ");
			sqlBuf.append("				a.itemId, ");
			sqlBuf.append("				a.itemNm, ");
			sqlBuf.append("				a.itemNmKor, ");
			sqlBuf.append("				a.sku, ");
			
			sqlBuf.append("				a.vendorId, ");
			sqlBuf.append("				a.price, ");
			sqlBuf.append("				a.curCd, ");
			sqlBuf.append("				a.priceMeta, ");
			sqlBuf.append("				a.priceFactory, ");
			
			sqlBuf.append("				a.priceCenter, ");
			sqlBuf.append("				a.priceClient, ");
			sqlBuf.append("				a.serviceHour, ");
			sqlBuf.append("				a.moqVendor, ");
			sqlBuf.append("				a.moqCenter, ");
			
			sqlBuf.append("				a.requiredStockCnt, ");
			sqlBuf.append("				a.defectStockCnt, ");
			sqlBuf.append("				a.linkItem, ");
			sqlBuf.append("				a.linkInvoice, ");
			sqlBuf.append("				a.note, ");
			
			sqlBuf.append("				a.insertUserId, ");
			sqlBuf.append("				a.insertDatetime, ");
			sqlBuf.append("				a.updateUserId, ");
			sqlBuf.append("				a.updateDatetime  ");//24
			
			sqlBuf.append("       from item a");
			sqlBuf.append("      order by itemId");
			
			//System.out.println(sqlBuf.toString());
			
			pstmt = con.prepareStatement(sqlBuf.toString()); 
			rs = pstmt.executeQuery(); 
			
			while(rs.next()) { 
				
				//note:vincent:20170518:filtering price_client
				
				//if(rs.getInt(11) == 0)
				//	continue;
				
				Item item = new Item(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getInt(6), rs.getFloat(7), rs.getString(8), rs.getInt(9), rs.getInt(10), rs.getInt(11), rs.getInt(12), rs.getFloat(13), rs.getInt(14), rs.getInt(15), rs.getInt(16), rs.getInt(17), rs.getString(18), rs.getString(19), rs.getString(20), rs.getString(21), rs.getString(22), rs.getString(23), rs.getString(24));
				
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

			sqlBuf.append("		select  a.itemNo, ");
			sqlBuf.append("				a.itemId, ");
			sqlBuf.append("				a.itemNm, ");
			sqlBuf.append("				a.itemNmKor, ");
			sqlBuf.append("				a.sku, ");
			
			sqlBuf.append("				a.vendorId, ");
			sqlBuf.append("				a.price, ");
			sqlBuf.append("				a.curCd, ");
			sqlBuf.append("				a.priceMeta, ");
			sqlBuf.append("				a.priceFactory, ");
			
			sqlBuf.append("				a.priceCenter, ");
			sqlBuf.append("				a.priceClient, ");
			sqlBuf.append("				a.serviceHour, ");
			sqlBuf.append("				a.moqVendor, ");
			sqlBuf.append("				a.moqCenter, ");
			
			sqlBuf.append("				a.requiredStockCnt, ");
			sqlBuf.append("				a.defectStockCnt, ");
			sqlBuf.append("				a.linkItem, ");
			sqlBuf.append("				a.linkInvoice, ");
			sqlBuf.append("				a.note, ");
			
			sqlBuf.append("				a.insertUserId, ");
			sqlBuf.append("				a.insertDatetime, ");
			sqlBuf.append("				a.updateUserId, ");
			sqlBuf.append("				a.updateDatetime  ");//24
			
			sqlBuf.append("            , ifnull(b.itemCnt,0) as itemCnt"); // from whItem
			
			sqlBuf.append("       from item a");
			sqlBuf.append("       left outer join whItem b");
			sqlBuf.append("         on a.itemNo = b.itemNo");
			sqlBuf.append("        and b.whNo = ?");
			sqlBuf.append("      order by itemId");
			
			//System.out.println(sqlBuf.toString());
			pstmt = con.prepareStatement(sqlBuf.toString()); 
			pstmt.setInt(1, whNo); 
			rs = pstmt.executeQuery(); 
			
			while(rs.next()) { 
				
				//note:vincent:20170518:filtering price_client
				
				//if(rs.getInt(11) == 0)
				//	continue;
				
				Item item = new Item(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getInt(6), rs.getFloat(7), rs.getString(8), rs.getInt(9), rs.getInt(10), rs.getInt(11), rs.getInt(12), rs.getFloat(13), rs.getInt(14), rs.getInt(15), rs.getInt(16), rs.getInt(17), rs.getString(18), rs.getString(19), rs.getString(20), rs.getString(21), rs.getString(22), rs.getString(23), rs.getString(24), rs.getInt(25));
				
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

			sqlBuf.append("		select  a.itemNo, ");
			sqlBuf.append("				a.itemId, ");
			sqlBuf.append("				a.itemNm, ");
			sqlBuf.append("				a.itemNmKor, ");
			sqlBuf.append("				a.sku, ");
			
			sqlBuf.append("				a.vendorId, ");
			sqlBuf.append("				a.price, ");
			sqlBuf.append("				a.curCd, ");
			sqlBuf.append("				a.priceMeta, ");
			sqlBuf.append("				a.priceFactory, ");
			
			sqlBuf.append("				a.priceCenter, ");
			sqlBuf.append("				a.priceClient, ");
			sqlBuf.append("				a.serviceHour, ");
			sqlBuf.append("				a.moqVendor, ");
			sqlBuf.append("				a.moqCenter, ");
			
			sqlBuf.append("				a.requiredStockCnt, ");
			sqlBuf.append("				a.defectStockCnt, ");
			sqlBuf.append("				a.linkItem, ");
			sqlBuf.append("				a.linkInvoice, ");
			sqlBuf.append("				a.note, ");
			
			sqlBuf.append("				a.insertUserId, ");
			sqlBuf.append("				a.insertDatetime, ");
			sqlBuf.append("				a.updateUserId, ");
			sqlBuf.append("				a.updateDatetime  ");//24
			
			sqlBuf.append("            , ifnull(b.itemCnt,0) as srcItemCnt");// from to
			sqlBuf.append("            , ifnull(c.itemCnt,0) as destItemCnt");// from to
			sqlBuf.append("       from item a");
			sqlBuf.append("       left outer join whItem b");
			sqlBuf.append("         on a.itemNo = b.itemNo");
			sqlBuf.append("        and b.whNo = ?");
			sqlBuf.append("       left outer join whItem c");
			sqlBuf.append("         on a.itemNo = c.itemNo");
			sqlBuf.append("        and c.whNo = ?");
			sqlBuf.append("      order by itemId");
			
			pstmt = con.prepareStatement(sqlBuf.toString()); 
			pstmt.setInt(1, srcWhNo); 
			pstmt.setInt(2, destWhNo); 
//System.out.println(pstmt.toString());
			rs = pstmt.executeQuery(); 
	
			while(rs.next()) { 
				
				//note:vincent:20170518:filtering price_client
				
				//if(rs.getInt(11) == 0)
				//	continue;
				
				Item item = new Item(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getInt(6), rs.getFloat(7), rs.getString(8), rs.getInt(9), rs.getInt(10), rs.getInt(11), rs.getInt(12), rs.getFloat(13), rs.getInt(14), rs.getInt(15), rs.getInt(16), rs.getInt(17), rs.getString(18), rs.getString(19), rs.getString(20), rs.getString(21), rs.getString(22), rs.getString(23), rs.getString(24), rs.getInt(25), rs.getInt(26));
				
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
			throw e;
		}finally { 
			DBClose.close(con,pstmt,rs); 
		} 
		
		return alist; 		
	}
/*
	// getItemList (orderItem only) 
	public ArrayList<Item> getItemList(int whNo, String orderFg, int orderNo) throws Exception { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		ArrayList<Item> alist = new ArrayList<Item>(); 
		
		try { 
			
			StringBuffer sqlBuf = new StringBuffer(); 

			sqlBuf.append("		select  a.itemNo, ");
			sqlBuf.append("				a.itemId, ");
			sqlBuf.append("				a.itemNm, ");
			sqlBuf.append("				a.itemNmKor, ");
			sqlBuf.append("				a.sku, ");
			sqlBuf.append("				a.vendorId, ");
			sqlBuf.append("				a.price, ");
			sqlBuf.append("				a.curCd, ");
			sqlBuf.append("				a.priceMeta, ");
			sqlBuf.append("				a.priceFactory, ");
			sqlBuf.append("				a.priceCenter, ");
			sqlBuf.append("				a.priceClient, ");
			sqlBuf.append("				a.serviceHour, ");
			sqlBuf.append("				a.moqVendor, ");
			sqlBuf.append("				a.moqCenter, ");
			sqlBuf.append("				a.requiredStockCnt, ");
			sqlBuf.append("				a.defectStockCnt, ");
			sqlBuf.append("				a.linkItem, ");
			sqlBuf.append("				a.linkInvoice, ");
			sqlBuf.append("				a.note, ");
			sqlBuf.append("				a.insertUserId, ");
			sqlBuf.append("				a.insertDatetime, ");
			sqlBuf.append("				a.updateUserId, ");
			sqlBuf.append("				a.updateDatetime  ");//24
			sqlBuf.append("            , ifnull(b.itemCnt,0) as itemCnt");// from whItem
			sqlBuf.append("       from item a");
			sqlBuf.append("       left outer join whItem b");
			sqlBuf.append("         on a.itemNo = b.itemNo");
			sqlBuf.append("        and b.whNo = ?");
//			sqlBuf.append("      where a.itemNo in (select itemNo from order" + orderFg + "Item orderNo = ?)");
			sqlBuf.append("      order by itemId");
			
			//System.out.println(sqlBuf.toString());
			pstmt = con.prepareStatement(sqlBuf.toString()); 
			pstmt.setInt(1, whNo); 
			pstmt.setString(2, orderFg); 
			pstmt.setInt(3, orderNo); 
			rs = pstmt.executeQuery(); 
	
			while(rs.next()) { 
				
				//note:vincent:20170518:filtering price_client
				
				//if(rs.getInt(11) == 0)
				//	continue;
				
				Item item = new Item(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getInt(6), rs.getFloat(7), rs.getString(8), rs.getInt(9), rs.getInt(10), rs.getInt(11), rs.getInt(12), rs.getFloat(13), rs.getInt(14), rs.getInt(15), rs.getInt(16), rs.getInt(17), rs.getString(18), rs.getString(19), rs.getString(20), rs.getString(21), rs.getString(22), rs.getString(23), rs.getString(24), rs.getInt(25));
				
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
			throw e;
		}finally { 
			DBClose.close(con,pstmt,rs); 
		} 
		
		return alist; 
	} 
*/	
	
	public ArrayList<Item> getOrderPItemList(int orderNo) throws Exception { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		ArrayList<Item> alist = new ArrayList<Item>(); 
		
		try { 
			
			StringBuffer sqlBuf = new StringBuffer(); 

			sqlBuf.append("			select  a.itemNo "); 
			sqlBuf.append("					, d.itemId, d.itemNm "); 
			sqlBuf.append("					, a.itemPrice as price, a.curCd "); 
			sqlBuf.append("					, ifnull(c.itemCnt,0) as whItemCnt "); 
			sqlBuf.append("					, a.itemCnt as orderItemCnt "); 
			sqlBuf.append("					, ifnull((select sum(itemCnt) from orderPRcvItem where orderNo = a.orderNo and itemNo = a.itemNo),0) as itemRcvCnt "); 
			sqlBuf.append("					, (ifnull(a.itemCnt,0) - ifnull((select sum(itemCnt) from orderPRcvItem where orderNo = a.orderNo and itemNo = a.itemNo),0)) as itemNoRcvCnt "); 
			sqlBuf.append("		 	  from orderPItem a "); 
			sqlBuf.append("			  left outer join orderP b "); 
			sqlBuf.append("			    on a.orderNo = b.orderNo "); 
			sqlBuf.append("			  left outer join whItem c "); 
			sqlBuf.append("			    on b.whNo = c.whNo "); 
			sqlBuf.append("			   and a.itemNo = c.itemNo "); 
			sqlBuf.append("			  left outer join item d "); 
			sqlBuf.append("			    on a.itemNo = d.itemNo "); 
			sqlBuf.append("			 where a.orderNo = ? "); 
			sqlBuf.append("			 order by a.itemNo ; "); 
			
			//System.out.println(sqlBuf.toString());
			pstmt = con.prepareStatement(sqlBuf.toString()); 
			pstmt.setInt(1, orderNo); 
			rs = pstmt.executeQuery(); 
			
			while(rs.next()) { 
				
				Item item = new Item();
				
				item.setItemNo(rs.getInt(1)); 
				item.setItemId(rs.getString(2)); 
				item.setItemNm(rs.getString(3)); 
				item.setPrice(rs.getFloat(4)); 
				item.setCurCd(rs.getString(5)); 

				item.setWhItemCnt(rs.getInt(6)); 
				item.setOrderItemCnt(rs.getInt(7)); 
				item.setItemRcvCnt(rs.getInt(8)); 
				item.setItemNoRcvCnt(rs.getInt(9)); 

				alist.add(item); 
			} 
		}catch(Exception e) { 
			throw e;
		}finally { 
			DBClose.close(con,pstmt,rs); 
		} 
		
		return alist; 
	} 

	
	public ArrayList<Item> getOrderPItemList(int orderNo, int rcvSeq) throws Exception { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		ArrayList<Item> alist = new ArrayList<Item>(); 
		
		try { 
				
			StringBuffer sqlBuf = new StringBuffer(); 

			sqlBuf.append("			select  a.itemNo "); 
			sqlBuf.append("					, d.itemId, d.itemNm "); 
			sqlBuf.append("					, a.itemPrice as price, a.curCd "); 
			sqlBuf.append("					, ifnull(c.itemCnt,0) as whItemCnt "); 
			sqlBuf.append("					, a.itemCnt as orderItemCnt "); 
			sqlBuf.append("					, ifnull((select sum(itemCnt) from orderPRcvItem where orderNo = a.orderNo and itemNo = a.itemNo),0) as itemRcvCnt "); 
			sqlBuf.append("					, (ifnull(a.itemCnt,0) - ifnull((select sum(itemCnt) from orderPRcvItem where orderNo = a.orderNo and itemNo = a.itemNo),0)) as itemNoRcvCnt "); 
			sqlBuf.append("					, ifnull(f.itemCnt,0) as newRcvCnt "); 
			
			sqlBuf.append("			  from orderPItem a "); 
			
			sqlBuf.append("			  left outer join orderP b "); 
			sqlBuf.append("			    on a.orderNo = b.orderNo ");
			
			sqlBuf.append("			  left outer join whItem c "); 
			sqlBuf.append("			    on b.whNo = c.whNo "); 
			sqlBuf.append("			   and a.itemNo = c.itemNo ");
			
			sqlBuf.append("			  left outer join item d "); 
			sqlBuf.append("			    on a.itemNo = d.itemNo ");
			
			sqlBuf.append("			  left outer join orderPRcvItem f ");
			sqlBuf.append("				on f.orderNo = a.orderNo ");
			sqlBuf.append("			   and f.rcvSeq = ? ");
			sqlBuf.append("			   and f.itemNo = a.itemNo ");
			
			sqlBuf.append("		 	 where a.orderNo = ? "); 
			sqlBuf.append("			 order by a.itemNo ; "); 

			
			//System.out.println(sqlBuf.toString());
			pstmt = con.prepareStatement(sqlBuf.toString()); 
			pstmt.setInt(1, rcvSeq); 
			pstmt.setInt(2, orderNo); 
			rs = pstmt.executeQuery(); 
			
			while(rs.next()) { 
				
				Item item = new Item();
				
				item.setItemNo(rs.getInt(1)); 
				item.setItemId(rs.getString(2)); 
				item.setItemNm(rs.getString(3)); 
				item.setPrice(rs.getFloat(4)); 
				item.setCurCd(rs.getString(5)); 

				item.setWhItemCnt(rs.getInt(6)); 
				item.setOrderItemCnt(rs.getInt(7)); 
				item.setItemRcvCnt(rs.getInt(8)); 
				item.setItemNoRcvCnt(rs.getInt(9)); 
				item.setItemNewRcvCnt(rs.getInt(10)); 

				alist.add(item); 
			} 
		}catch(Exception e) { 
			throw e;
		}finally { 
			DBClose.close(con,pstmt,rs); 
		} 
		
		return alist; 
	} 

	public boolean insertItem(Item item) throws Exception { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		
		try {
			
			if(isExistItemId(item.getItemId()))
				return false;
			
			// itemNo : AI
			sql = "insert into item (itemNo, itemId, itemNm, itemNmKor, vendorId, curCd, price, priceMeta, priceFactory, priceCenter, priceClient, serviceHour, insertUserId, insertDatetime) values (?,?,?,?,?,?,?,?,?,?,?,?,?, current_timestamp())"; 
			pstmt = con.prepareStatement(sql); 

			pstmt.setInt(1, item.getItemNo()); 
			pstmt.setString(2, item.getItemId()); 
			pstmt.setString(3, item.getItemNm()); 
			pstmt.setString(4, item.getItemNmKor());
			
			pstmt.setInt(5, item.getVendorId());
			pstmt.setString(6, item.getCurCd());
		
			pstmt.setFloat(7, item.getPrice());
			pstmt.setInt(8, item.getPriceMeta());
			pstmt.setInt(9, item.getPriceFactory());
			
			pstmt.setInt(10, item.getPriceCenter());
			pstmt.setInt(11, item.getPriceClient());
			pstmt.setFloat(12,  item.getServiceHour());
			pstmt.setString(13, item.getInsertUserId());
			
			//System.out.println(sql);
			pstmt.execute(); 
			
			return true;
			
		}catch(Exception e) { 
			throw e;
		}finally { 
			DBClose.close(con,pstmt); 
		} 
	} 
	
	public boolean isExistItemId(String itemId) throws Exception { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		int cnt = 0; 
		
		try { 
			
			sql = "SELECT COUNT(0) FROM item where itemId = ?;"; 
			
			pstmt = con.prepareStatement(sql); 
			pstmt.setString(1, itemId);
			rs = pstmt.executeQuery(); 
			//System.out.println(sql);
			
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
	
	
	public Item getItemInfo(int itemNo) throws Exception { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		Item item = null; 
		
		try { 
			StringBuffer sqlBuf=new StringBuffer(); 

			sqlBuf.append("		select  a.itemNo, ");
			sqlBuf.append("				a.itemId, ");
			sqlBuf.append("				a.itemNm, ");
			sqlBuf.append("				a.itemNmKor, ");//4
			sqlBuf.append("				a.sku, ");
			
			sqlBuf.append("				a.vendorId, ");//6
			sqlBuf.append("				a.price, ");
			sqlBuf.append("				a.curCd, ");
			sqlBuf.append("				a.priceMeta, ");
			sqlBuf.append("				a.priceFactory, ");
			
			sqlBuf.append("				a.priceCenter, ");//11
			sqlBuf.append("				a.priceClient, ");//12
			sqlBuf.append("				a.serviceHour, ");//13
			sqlBuf.append("				a.moqVendor, ");
			sqlBuf.append("				a.moqCenter, ");
			
			sqlBuf.append("				a.requiredStockCnt, ");
			sqlBuf.append("				a.defectStockCnt, ");
			sqlBuf.append("				a.linkItem, ");
			sqlBuf.append("				a.linkInvoice, ");
			sqlBuf.append("				a.note, ");
			
			sqlBuf.append("				a.insertUserId, ");//21
			sqlBuf.append("				a.insertDatetime, ");
			sqlBuf.append("				a.updateUserId, ");//23
			sqlBuf.append("				a.updateDatetime  ");
			sqlBuf.append("		   from item a ");
			sqlBuf.append("		  where itemNo = ?;");
			
			pstmt = con.prepareStatement(sqlBuf.toString()); 
			pstmt.setInt(1, itemNo);
			rs = pstmt.executeQuery(); 
			if(rs.next()) { 
				//item = new Item(itemNo, itemId, itemNm, itemNmKor, priceCenter, priceClient, serviceHour, userId, userId);
				item = new Item(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getInt(6), rs.getInt(7), rs.getString(8), rs.getInt(9), rs.getInt(10),   
						rs.getInt(11), rs.getInt(12), rs.getFloat(13), rs.getInt(14), rs.getInt(15), rs.getInt(16), rs.getInt(17), rs.getString(18), rs.getString(19), rs.getString(20), 
						rs.getString(21), rs.getString(22), rs.getString(23), rs.getString(24)); 
			} 
		}catch(Exception e) { 
			throw e;
		}finally { 
			DBClose.close(con,pstmt,rs); 
		} 
		
		return item; 
	} 
	
	public void deleteItem(int itemNo) throws Exception { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		
		try { 
			sql = "delete from item where itemNo = ?"; 
			
			pstmt = con.prepareStatement(sql); 
			pstmt.setInt(1, itemNo); 
			//System.out.println(sql);
			pstmt.executeUpdate(); 
		}catch(Exception e) { 
			throw e;
		}finally { 
			DBClose.close(con,pstmt); 
		} 
	} 
	
	public boolean modifyItem(Item item) throws Exception { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		
		try { 
			
			sql = "update item set itemNm=?, itemNmKor=?, vendorId=?, curCd=?, price=?, priceMeta=?, priceFactory=?, priceCenter=?, priceClient=?, serviceHour=?, updateUserId=?, updateDatetime=current_timestamp() where itemNo=?"; 
			
			pstmt = con.prepareStatement(sql); 
			//pstmt.setString(1, item.getItemId()); 
			pstmt.setString(1, item.getItemNm()); 
			pstmt.setString(2, item.getItemNmKor());
			pstmt.setInt(3, item.getVendorId());
			pstmt.setString(4, item.getCurCd());
			
			pstmt.setFloat(5, item.getPrice());
			pstmt.setInt(6, item.getPriceMeta());
			pstmt.setInt(7, item.getPriceFactory());
			
			pstmt.setInt(8, item.getPriceCenter());
			pstmt.setInt(9, item.getPriceClient());
			pstmt.setFloat(10,  item.getServiceHour());
			pstmt.setString(11, item.getUpdateUserId());
			pstmt.setInt(12, item.getItemNo());
			//System.out.println(pstmt.toString());
			
			pstmt.executeUpdate(); 
			
			return true;
			
		}catch(Exception e) { 
			throw e;
		}finally { 
			DBClose.close(con,pstmt); 
		} 
	} 

}



