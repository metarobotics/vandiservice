package wh; 

import java.sql.Connection; 
import java.sql.PreparedStatement; 
import java.sql.ResultSet; 
import java.text.SimpleDateFormat; 
import java.util.ArrayList; 
import java.util.Date; 

public class OrderPDAO extends DAO { 
	
	private String orderFg = "P";
	
	public OrderPDAO() {
		// TODO Auto-generated constructor stub
	}
	
	public int getNextOrderNo() throws Exception {
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		int no = 0; 
		
		try { 
			sql = "select ifnull(max(orderNo),0)+1 from orderP"; 
			pstmt = con.prepareStatement(sql); 
			rs = pstmt.executeQuery(); 
			System.out.println(sql);
			
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
	
	// 입고처리시 
	public int getNextOrderRcvSeq(int orderNo) throws Exception {
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		int no = 0; 
		
		try { 
			sql = "select ifnull(max(rcvSeq),0)+1 from orderPRcv where orderNo = ?"; 
			pstmt = con.prepareStatement(sql); 
			pstmt.setInt(1, orderNo); 
			rs = pstmt.executeQuery(); 
			System.out.println(sql);
			
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
	public int countOrderP() { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		int cnt = 0; 
		
		try { 
			sql = "SELECT COUNT(*) FROM orderP"; 
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
	*/
	public String incoding(String data) { 
		try { 
			//data = new String(data.getBytes("8859_1"), "euc-kr");
			//data = new String(data.getBytes("KSC5601"), "8859_1");
			
//			sql = new String(",  statusNm ".getBytes("8859_1"), "euc-kr");
//			sql = new String(",  statusNm ".getBytes("KSC5601"), "8859_1");
			
		}catch (Exception e){ } 
		return data; 
	} 
	

	public OrderP getOrderPInfo(int orderNo) throws Exception { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		OrderP orderP = null; 
		
		try { 
			
			StringBuffer sqlBuf=new StringBuffer(); 

			sqlBuf.append("		select a.*, b.whNm whNm "); 
			sqlBuf.append("      		" + incoding(", case a.statusCd when '10' then '작성중' when '20' then '작성완료' when '30' then '입고중' when '40' then '입고완료' end statusNm "));
			sqlBuf.append("		        , (select count(0) from orderPRcv where orderNo = a.orderNo) as rcvCnt "); 
			sqlBuf.append("        from orderP a ");
			sqlBuf.append("        left join wh b on a.whNo = b.whNo");
			sqlBuf.append("        where a.orderNo = ?; ");
			
			pstmt = con.prepareStatement(sqlBuf.toString()); 
			pstmt.setInt(1, orderNo); 
			rs = pstmt.executeQuery(); 
			System.out.println(sqlBuf.toString());
			
			if(rs.next()) { 
				orderP = new OrderP(rs.getInt(1), rs.getString(2), rs.getInt(3), rs.getString(6), rs.getFloat(7), rs.getFloat(8), rs.getFloat(9), rs.getString(10), rs.getString(17), rs.getString(19), rs.getString(21), rs.getString(22), rs.getInt(23)); 
			} 
		}catch(Exception e) { 
			throw e;
		}finally { 
			DBClose.close(con,pstmt,rs); 
		} 
		
		return orderP; 
	} 
	
	
	public ArrayList<OrderP> getOrderPList() throws Exception { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		ArrayList<OrderP> alist = new ArrayList<OrderP>(); 
		
		try { 
			StringBuffer sqlBuf=new StringBuffer(); 

			sqlBuf.append("		select a.*, b.whNm whNm "); 
			sqlBuf.append("      		" + incoding(", case a.statusCd when '10' then '작성중' when '20' then '작성완료' when '30' then '입고중' when '40' then '입고완료' end statusNm "));
			sqlBuf.append("		        , (select count(0) from orderPRcv where orderNo = a.orderNo) as rcvCnt "); 
			sqlBuf.append("        from orderP a ");
			sqlBuf.append("        left join wh b on a.whNo = b.whNo");
			sqlBuf.append("        order by orderNo desc;");
 
			pstmt = con.prepareStatement(sqlBuf.toString()); 
			rs = pstmt.executeQuery(); 
			System.out.println(sqlBuf.toString());
			
			while(rs.next()) { 
				OrderP orderP = new OrderP(rs.getInt(1), rs.getString(2), rs.getInt(3), rs.getString(6), rs.getFloat(7), rs.getFloat(8), rs.getFloat(9), rs.getString(10), rs.getString(17), rs.getString(19), rs.getString(21), rs.getString(22), rs.getInt(23)); 
				
				alist.add(orderP); 
			} 
		}catch(Exception e) { 
			throw e;
		}finally { 
			DBClose.close(con,pstmt,rs); 
		} 
		
		return alist; 
	} 
	
	public ArrayList<OrderP> getOrderPList(int whNo) throws Exception { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		ArrayList<OrderP> alist = new ArrayList<OrderP>(); 
		
		try { 
			StringBuffer sqlBuf=new StringBuffer(); 

			sqlBuf.append("		select a.*, b.whNm whNm "); 
			sqlBuf.append("      		" + incoding(", case a.statusCd when '10' then '작성중' when '20' then '작성완료' when '30' then '입고중' when '40' then '입고완료' end statusNm "));
			sqlBuf.append("		        , (select count(0) from orderPRcv where orderNo = a.orderNo) as rcvCnt "); 
			sqlBuf.append("        from orderP a ");
			sqlBuf.append("        left join wh b on a.srcWhNo = b.whNo");
			sqlBuf.append("       where a.whNo = ?");
			sqlBuf.append("        order by orderNo desc;");
 
			pstmt = con.prepareStatement(sqlBuf.toString()); 
			pstmt.setInt(1, whNo); 
			rs = pstmt.executeQuery(); 
			System.out.println(sqlBuf.toString());
			
			while(rs.next()) { 
				OrderP orderP = new OrderP(rs.getInt(1), rs.getString(2), rs.getInt(3), rs.getString(6), rs.getFloat(7), rs.getFloat(8), rs.getFloat(9), rs.getString(10), rs.getString(17), rs.getString(19), rs.getString(21), rs.getString(22), rs.getInt(23)); 
				
				alist.add(orderP); 
			} 
		}catch(Exception e) { 
			throw e;
		}finally { 
			DBClose.close(con,pstmt,rs); 
		} 
		
		return alist; 
	} 	
	
	public ArrayList<OrderItem> getOrderItemList(int orderNo) throws Exception { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		ArrayList<OrderItem> alist = new ArrayList<OrderItem>(); 
		
		try { 
			StringBuffer sqlBuf=new StringBuffer(); 

			sqlBuf.append("		select a.* "); 
			sqlBuf.append("        from orderItem a ");
			sqlBuf.append("        where orderFg='" + orderFg + "' and orderNo = ? ");
			sqlBuf.append("        order by seq;");
			
			pstmt = con.prepareStatement(sqlBuf.toString()); 
			pstmt.setInt(1, orderNo);
			
			rs = pstmt.executeQuery();
			System.out.println(sqlBuf.toString());
			
			while(rs.next()) { 
				
				OrderItem orderItem = new OrderItem(rs.getString(1), rs.getInt(2), rs.getInt(3), rs.getInt(4), rs.getInt(5), rs.getFloat(6), rs.getString(7), rs.getString(8)); 

				alist.add(orderItem); 
			} 
		}catch(Exception e) { 
			throw e;
		}finally { 
			DBClose.close(con,pstmt,rs); 
		} 
		
		return alist; 
	} 
	
	
	public void insertOrderP(OrderP orderP) throws Exception { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		
		try { 
			
			sql = "insert into orderP (orderNo, orderDt, whNo, statusCd, subtotal, tax, totalAmt, curCd, insertUserId, insertDatetime) VALUES (?,?,?,?,?,?,?,?,?, current_timestamp())"; 
			pstmt = con.prepareStatement(sql); 

			pstmt.setInt(1, orderP.getOrderNo());
			pstmt.setString(2, incoding(orderP.getOrderDt())); 
			pstmt.setInt(3, orderP.getWhNo()); 
			pstmt.setString(4, "10"); //statusCd
			pstmt.setFloat(5, orderP.getSubtotal());
			pstmt.setFloat(6, orderP.getTax());
			pstmt.setFloat(7, orderP.getTotalAmt());
						
			pstmt.setString(8, orderP.getCurCd());
			pstmt.setString(9, orderP.getInsertUserId());
			
			pstmt.execute(); 
			System.out.println(sql);
			
		}catch(Exception e) { 
			throw e;
		}finally { 
			DBClose.close(con,pstmt); 
		} 
	} 
	
	
	public void insertOrderItem(OrderItem orderItem) throws Exception { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		
		try { 
			sql = "insert into orderItem (orderFg, orderNo, seq, itemNo, itemCnt, itemPrice, curCd, insertUserId, insertDatetime) VALUES (?,?,?,?,?,?,?,?, current_timestamp())"; 
			pstmt = con.prepareStatement(sql); 

			pstmt.setString(1, orderFg);
			pstmt.setInt(2, orderItem.getOrderNo()); 
			pstmt.setInt(3, orderItem.getSeq()); 
			pstmt.setInt(4, orderItem.getItemNo());
			pstmt.setInt(5, orderItem.getItemCnt());
			pstmt.setFloat(6, orderItem.getItemPrice());
			pstmt.setString(7, orderItem.getCurCd());
			pstmt.setString(8, orderItem.getInsertUserId());
			
			pstmt.execute(); 
			System.out.println(sql);
			
		}catch(Exception e) { 
			throw e;
		}finally { 
			DBClose.close(con,pstmt); 
		} 
	} 
	
	
	public void modifyOrderP(OrderP orderP) throws Exception {
		
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		
		try { 
			sql = "update orderP set orderDt=?, whNo=?, subtotal=?, tax=?, totalAmt=?, curCd=?, updateDatetime=current_timestamp() where orderNo=?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, orderP.getOrderDt());
			pstmt.setInt(2, orderP.getWhNo());
			pstmt.setFloat(3, orderP.getSubtotal()); 
			pstmt.setFloat(4, orderP.getTax()); 
			pstmt.setFloat(5, orderP.getTotalAmt()); 
			pstmt.setString(6, orderP.getCurCd());
			pstmt.setInt(7, orderP.getOrderNo());
						
			pstmt.executeUpdate();
			System.out.println(sql);
			
		}catch(Exception e) { 
			throw e;
		}finally { 
			DBClose.close(con,pstmt); 
		} 
	} 	
	
	
	/*
	 * 삭제  
	 */
	public void deleteOrderP(int orderNo) throws Exception { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		try { 
			sql = "delete from orderP where orderNo = ?"; 
			pstmt = con.prepareStatement(sql); 
			pstmt.setInt(1, orderNo); 
			pstmt.executeUpdate();
			System.out.println(sql);
			
		}catch(Exception e) { 
			throw e;
		}finally { 
			DBClose.close(con,pstmt); 
		} 
	} 
	
	
	public void deleteOrderItem(int orderNo) throws Exception { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		try { 
			sql = "delete from orderItem where orderFg='" + orderFg + "' and orderNo = ?"; 
			pstmt = con.prepareStatement(sql); 
			pstmt.setInt(1, orderNo); 
			pstmt.executeUpdate(); 
			System.out.println(sql);
			
		}catch(Exception e) { 
			throw e;
		}finally { 
			DBClose.close(con,pstmt); 
		} 
	} 
	
	
	/*
	 * 작성완료
	 */
	public void acceptOrderP(int orderNo) throws Exception { 
		modifyOrderPStatus(orderNo, "20");
	} 
	
	/*
	 * 입고처리 
	 */
	public void getItemOrderP(int orderNo) throws Exception { 
		modifyOrderPStatus(orderNo, "30");
	} 
	
	/*
	 * 입고완료 
	 */
	public void finishOrderP(int orderNo) throws Exception { 
		modifyOrderPStatus(orderNo, "40");
	} 
	
	/*
	 * 상태변경
	 */
	private void modifyOrderPStatus(int orderNo, String statusCd) throws Exception { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		
		try { 
			sql = "update orderP set statusCd=? where orderNo=?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, statusCd);
			pstmt.setInt(2, orderNo);
			pstmt.executeUpdate();
			System.out.println(sql);
			
		}catch(Exception e) { 
			throw e;
		}finally { 
			DBClose.close(con,pstmt); 
		} 
	} 
	
	
	public OrderPRcv getOrderPRcvInfo(int orderNo, int rcvSeq) throws Exception { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		OrderPRcv orderPRcv = new OrderPRcv(); 
		
		try { 
			StringBuffer sqlBuf=new StringBuffer(); 

			sqlBuf.append("		select a.* "); 
			sqlBuf.append("        from orderPRcv a ");
			sqlBuf.append("       where orderNo = ?");
			sqlBuf.append("         and rcvSeq = ?;");
 
			pstmt = con.prepareStatement(sqlBuf.toString()); 
			pstmt.setInt(1, orderNo);
			pstmt.setInt(2, rcvSeq);
			rs = pstmt.executeQuery(); 
			System.out.println(sqlBuf.toString());
			
			if(rs.next()) { 
				orderPRcv = new OrderPRcv(rs.getInt(1), rs.getInt(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(7)); 
			}
			
		}catch(Exception e) { 
			throw e;
		}finally { 
			DBClose.close(con,pstmt,rs); 
		} 
		
		return orderPRcv; 
	}  
		
	public ArrayList<OrderPRcv> getOrderPRcvList(int orderNo) throws Exception { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		ArrayList<OrderPRcv> alist = new ArrayList<OrderPRcv>(); 
		
		try { 
			StringBuffer sqlBuf=new StringBuffer(); 

			sqlBuf.append("		select a.* "); 
			sqlBuf.append("        from orderPRcv a ");
			sqlBuf.append("       where orderNo = ?");
			sqlBuf.append("        order by rcvSeq;");
 
			pstmt = con.prepareStatement(sqlBuf.toString()); 
			pstmt.setInt(1, orderNo);
			rs = pstmt.executeQuery(); 
			System.out.println(sqlBuf.toString());
			
			while(rs.next()) { 
				OrderPRcv orderPRcv = new OrderPRcv(rs.getInt(1), rs.getInt(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(7)); 
				
				alist.add(orderPRcv); 
			} 
		}catch(Exception e) { 
			throw e;
		}finally { 
			DBClose.close(con,pstmt,rs); 
		} 
		
		return alist; 
	}  
	
	
	public ArrayList<OrderPRcvItem> getOrderPRcvItemList(int orderNo, int rcvSeq) throws Exception { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		ArrayList<OrderPRcvItem> alist = new ArrayList<OrderPRcvItem>(); 
		
		try { 
			StringBuffer sqlBuf=new StringBuffer(); 

			sqlBuf.append("		select a.* "); 
			sqlBuf.append("        from orderPRcvItem a ");
			sqlBuf.append("       where orderNo = ?");
			sqlBuf.append("         and rcvSeq = ?");
			sqlBuf.append("        order by seq;");
 
			pstmt = con.prepareStatement(sqlBuf.toString()); 
			pstmt.setInt(1, orderNo);
			pstmt.setInt(2, rcvSeq);
			rs = pstmt.executeQuery(); 
			System.out.println(sqlBuf.toString());
			
			while(rs.next()) { 
				OrderPRcvItem orderPRcvItem = new OrderPRcvItem(rs.getInt(1), rs.getInt(2), rs.getInt(3), rs.getInt(4), rs.getInt(5), rs.getString(6), rs.getString(8)); 
				
				alist.add(orderPRcvItem); 
			} 
		}catch(Exception e) { 
			throw e;
		}finally { 
			DBClose.close(con,pstmt,rs); 
		} 
		
		return alist; 
	}  	
	
	
	
	public void insertOrderPRcv(OrderPRcv orderPRcv) throws Exception { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		
		try { 
//			public OrderPRcv(int orderNo, int rcvSeq, String rcvDt, String note, String insertUserId, String updateUserId)

			sql = "insert into orderPRcv (orderNo, rcvSeq, rcvDt, note, insertUserId, insertDatetime) VALUES (?,?,?,?,?, current_timestamp())"; 
			pstmt = con.prepareStatement(sql); 

			pstmt.setInt(1, orderPRcv.getOrderNo());
			pstmt.setInt(2, orderPRcv.getRcvSeq());
			pstmt.setString(3, incoding(orderPRcv.getRcvDt())); 
			pstmt.setString(4, incoding(orderPRcv.getNote())); 
			pstmt.setString(5, orderPRcv.getInsertUserId());
			
			pstmt.execute(); 
			System.out.println(sql);
			
		}catch(Exception e) { 
			throw e;
		}finally { 
			DBClose.close(con,pstmt); 
		} 
	} 
	
	
	public void insertOrderPRcvItem(OrderPRcvItem orderPRcvItem) throws Exception { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		
		try { 
			//	public OrderPRcvItem(int orderNo, int rcvSeq, int seq, int itemNo, int itemCnt, String insertUserId, String updateUserId) {

			sql = "insert into orderPRcvItem (orderNo, rcvSeq, seq, itemNo, itemCnt, insertUserId, insertDatetime) VALUES (?,?,?,?,?,?, current_timestamp())"; 
			pstmt = con.prepareStatement(sql); 

			pstmt.setInt(1, orderPRcvItem.getOrderNo()); 
			pstmt.setInt(2, orderPRcvItem.getRcvSeq()); 
			pstmt.setInt(3, orderPRcvItem.getSeq()); 
			pstmt.setInt(4, orderPRcvItem.getItemNo());
			pstmt.setInt(5, orderPRcvItem.getItemCnt());
			pstmt.setString(6, orderPRcvItem.getInsertUserId());
			
			pstmt.execute(); 
			System.out.println(sql);
			
		}catch(Exception e) { 
			throw e;
		}finally { 
			DBClose.close(con,pstmt); 
		} 
	} 
	
	
	public void modifyOrderPRcv(OrderPRcv orderPRcv) throws Exception {
		
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		
		try { 
			sql = "update orderPRcv set rcvDt=?, note=?, updateUserId=?, updateDatetime=current_timestamp() where orderNo=? and rcvSeq=?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, orderPRcv.getRcvDt());
			pstmt.setString(2, incoding(orderPRcv.getNote()));
			pstmt.setString(3, orderPRcv.getUpdateUserId());

			pstmt.setInt(4, orderPRcv.getOrderNo());
			pstmt.setInt(5, orderPRcv.getRcvSeq());
						
			pstmt.executeUpdate();
			System.out.println(sql);
			
		}catch(Exception e) { 
			throw e;
		}finally { 
			DBClose.close(con,pstmt); 
		} 
	} 	
	
	
	/*
	 * 삭제  
	 */
	public void deleteOrderPRcv(int orderNo, int rcvSeq) throws Exception { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		try { 
			sql = "delete from orderPRcv where orderNo = ? and rcvSeq = ?"; 
			pstmt = con.prepareStatement(sql); 
			pstmt.setInt(1, orderNo); 
			pstmt.setInt(2, rcvSeq); 
			pstmt.executeUpdate();
			System.out.println(sql);
			
		}catch(Exception e) { 
			throw e;
		}finally { 
			DBClose.close(con,pstmt); 
		} 
	} 
	
	
	public void deleteOrderPRcvItem(int orderNo, int rcvSeq) throws Exception { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		try { 
			sql = "delete from orderPRcvItem where orderNo = ? and rcvSeq = ?"; 
			pstmt = con.prepareStatement(sql); 
			pstmt.setInt(1, orderNo); 
			pstmt.setInt(2, rcvSeq); 
			pstmt.executeUpdate(); 
			System.out.println(sql);
			
		}catch(Exception e) { 
			throw e;
		}finally { 
			DBClose.close(con,pstmt); 
		} 
	} 
	
	
	
/*
	public ArrayList<Item> getOrderPRcvItemList(int orderNo) throws Exception { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		ArrayList<Item> alist = new ArrayList<Item>(); 
		
		try { 
			
			StringBuffer sqlBuf = new StringBuffer(); 

			sqlBuf.append("			select a.itemNo "); 
			sqlBuf.append("			, d.itemId, d.itemNm "); 
			sqlBuf.append("			, a.itemPrice as price, a.curCd "); 
			sqlBuf.append("			, ifnull(c.itemCnt,0) as whItemCnt "); 
			sqlBuf.append("			, a.itemCnt as orderItemCnt "); 
			sqlBuf.append("			, (select count(0) from orderPRcvItem where orderNo = a.orderNo) as itemRcvCnt "); 
			sqlBuf.append("			, (ifnull(a.itemCnt,0) - (select count(0) from orderPRcvItem where orderNo = a.orderNo)) as itemNoRcvCnt "); 
			sqlBuf.append("			from orderItem a "); 
			sqlBuf.append("			left outer join orderP b "); 
			sqlBuf.append("			on a.orderNo = b.orderNo "); 
			sqlBuf.append("			left outer join whItem c "); 
			sqlBuf.append("			on b.whNo = c.whNo "); 
			sqlBuf.append("			and a.itemNo = c.itemNo "); 
			sqlBuf.append("			left outer join item d "); 
			sqlBuf.append("			on a.itemNo = d.itemNo "); 
			sqlBuf.append("			where a.orderFg = 'P' and a.orderNo = ?; "); 
			
			System.out.println(sqlBuf.toString());
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
			e.printStackTrace();
			throw e;
		}finally { 
			DBClose.close(con,pstmt,rs); 
		} return alist; 
	} 

	*/
	
	
	
}



