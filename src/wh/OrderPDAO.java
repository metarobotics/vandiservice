package wh; 

import java.sql.Connection; 
import java.sql.PreparedStatement; 
import java.sql.ResultSet; 
import java.text.SimpleDateFormat; 
import java.util.ArrayList; 
import java.util.Date; 

public class OrderPDAO extends DAO { 
	
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
	
	/*
	public int countOrderP() throws Exception { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		int cnt = 0; 
		
		try { 
			sql = "SELECT COUNT(0) FROM orderP"; 
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
	*/
	
	public OrderP getOrderPInfo(int orderNo) throws Exception { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		OrderP orderP = null; 
		
		try { 
			
			StringBuffer sqlBuf=new StringBuffer(); 

			sqlBuf.append("		select  a.orderNo, ");
			sqlBuf.append("				a.orderDt, ");
			sqlBuf.append("				a.whNo, ");
			sqlBuf.append("				a.deliverPrgDt, ");
			sqlBuf.append("				a.delieverDt, ");
			sqlBuf.append("				a.statusCd, ");
			sqlBuf.append("				a.subtotal, ");
			sqlBuf.append("				a.tax, ");
			sqlBuf.append("				a.totalAmt, ");
			sqlBuf.append("				a.curCd, ");
			sqlBuf.append("				a.depositPrgAmt, ");
			sqlBuf.append("				a.creditPrgAmt, ");
			sqlBuf.append("				a.depositAmt, ");
			sqlBuf.append("				a.creditAmt, ");
			sqlBuf.append("				a.receiptAmt, ");
			sqlBuf.append("				a.note, ");
			sqlBuf.append("				a.insertUserId, ");
			sqlBuf.append("				a.insertDatetime, ");
			sqlBuf.append("				a.updateUserId, ");
			sqlBuf.append("				a.updateDatetime  ");
			sqlBuf.append("		        , b.whNm whNm "); 
			//sqlBuf.append("      		" + incoding(", case a.statusCd when '10' then '작성중' when '20' then '작성완료' when '30' then '입고중' when '40' then '입고완료' end statusNm "));
			sqlBuf.append("      		, case a.statusCd when '10' then '작성중' when '20' then '작성완료' when '30' then '입고중' when '40' then '입고완료' end statusNm ");
			sqlBuf.append("		        , (select count(0) from orderPRcv where orderNo = a.orderNo) as rcvCnt "); 
			sqlBuf.append("        from orderP a ");
			sqlBuf.append("        left join wh b on a.whNo = b.whNo");
			sqlBuf.append("       where a.orderNo = ?; ");
			
			pstmt = con.prepareStatement(sqlBuf.toString()); 
			pstmt.setInt(1, orderNo); 
			rs = pstmt.executeQuery(); 
			//System.out.println(sqlBuf.toString());
			
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

			sqlBuf.append("		select  a.orderNo, ");
			sqlBuf.append("				a.orderDt, ");
			sqlBuf.append("				a.whNo, ");
			sqlBuf.append("				a.deliverPrgDt, ");
			sqlBuf.append("				a.delieverDt, ");
			sqlBuf.append("				a.statusCd, ");
			sqlBuf.append("				a.subtotal, ");
			sqlBuf.append("				a.tax, ");
			sqlBuf.append("				a.totalAmt, ");
			sqlBuf.append("				a.curCd, ");
			sqlBuf.append("				a.depositPrgAmt, ");
			sqlBuf.append("				a.creditPrgAmt, ");
			sqlBuf.append("				a.depositAmt, ");
			sqlBuf.append("				a.creditAmt, ");
			sqlBuf.append("				a.receiptAmt, ");
			sqlBuf.append("				a.note, ");
			sqlBuf.append("				a.insertUserId, ");
			sqlBuf.append("				a.insertDatetime, ");
			sqlBuf.append("				a.updateUserId, ");
			sqlBuf.append("				a.updateDatetime  ");
			sqlBuf.append("		        , b.whNm whNm "); 
			//sqlBuf.append("      		" + incoding(", case a.statusCd when '10' then '작성중' when '20' then '작성완료' when '30' then '입고중' when '40' then '입고완료' end statusNm "));
			sqlBuf.append("      		, case a.statusCd when '10' then '작성중' when '20' then '작성완료' when '30' then '입고중' when '40' then '입고완료' end statusNm ");
			sqlBuf.append("		        , (select count(0) from orderPRcv where orderNo = a.orderNo) as rcvCnt "); 
			sqlBuf.append("        from orderP a ");
			sqlBuf.append("        left join wh b on a.whNo = b.whNo");
			sqlBuf.append("       order by orderNo desc;");
 
			pstmt = con.prepareStatement(sqlBuf.toString()); 
			rs = pstmt.executeQuery(); 
			//System.out.println(sqlBuf.toString());
			
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

			sqlBuf.append("		select  a.orderNo, ");
			sqlBuf.append("				a.orderDt, ");
			sqlBuf.append("				a.whNo, ");
			sqlBuf.append("				a.deliverPrgDt, ");
			sqlBuf.append("				a.delieverDt, ");
			sqlBuf.append("				a.statusCd, ");
			sqlBuf.append("				a.subtotal, ");
			sqlBuf.append("				a.tax, ");
			sqlBuf.append("				a.totalAmt, ");
			sqlBuf.append("				a.curCd, ");
			sqlBuf.append("				a.depositPrgAmt, ");
			sqlBuf.append("				a.creditPrgAmt, ");
			sqlBuf.append("				a.depositAmt, ");
			sqlBuf.append("				a.creditAmt, ");
			sqlBuf.append("				a.receiptAmt, ");
			sqlBuf.append("				a.note, ");
			sqlBuf.append("				a.insertUserId, ");
			sqlBuf.append("				a.insertDatetime, ");
			sqlBuf.append("				a.updateUserId, ");
			sqlBuf.append("				a.updateDatetime  ");
			sqlBuf.append("		        , b.whNm whNm "); 
			//sqlBuf.append("      		" + incoding(", case a.statusCd when '10' then '작성중' when '20' then '작성완료' when '30' then '입고중' when '40' then '입고완료' end statusNm "));
			sqlBuf.append("      		, case a.statusCd when '10' then '작성중' when '20' then '작성완료' when '30' then '입고중' when '40' then '입고완료' end statusNm ");
			sqlBuf.append("		        , (select count(0) from orderPRcv where orderNo = a.orderNo) as rcvCnt "); 
			sqlBuf.append("        from orderP a ");
			sqlBuf.append("        left join wh b on a.whNo = b.whNo");
			sqlBuf.append("       where a.whNo = ?");
			sqlBuf.append("       order by orderNo desc;");
 
			pstmt = con.prepareStatement(sqlBuf.toString()); 
			pstmt.setInt(1, whNo); 
			rs = pstmt.executeQuery(); 
			//System.out.println(sqlBuf.toString());
			
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
	
	public ArrayList<OrderPItem> getOrderPItemList(int orderNo) throws Exception { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		ArrayList<OrderPItem> alist = new ArrayList<OrderPItem>(); 
		
		try { 
			StringBuffer sqlBuf=new StringBuffer(); 

			sqlBuf.append("		select  a.orderNo, ");
			sqlBuf.append("				a.seq, ");
			sqlBuf.append("				a.itemNo, ");
			sqlBuf.append("				a.itemCnt, ");
			sqlBuf.append("				a.itemPrice, ");//5
			sqlBuf.append("				a.curCd, ");
			sqlBuf.append("				a.insertUserId, ");
			sqlBuf.append("				a.insertDatetime, ");
			sqlBuf.append("				a.updateUserId, ");
			sqlBuf.append("				a.updateDatetime  ");
			sqlBuf.append("        from orderPItem a ");
			sqlBuf.append("        where orderNo = ? ");
			sqlBuf.append("        order by seq;");
			
			pstmt = con.prepareStatement(sqlBuf.toString()); 
			pstmt.setInt(1, orderNo);
			
			rs = pstmt.executeQuery();
			//System.out.println(sqlBuf.toString());
			
			while(rs.next()) { 
				
				OrderPItem OrderPItem = new OrderPItem(rs.getInt(1), rs.getInt(2), rs.getInt(3), rs.getInt(4), rs.getFloat(5), rs.getString(6), rs.getString(7)); 

				alist.add(OrderPItem); 
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
			//pstmt.setString(2, incoding(orderP.getOrderDt())); 
			pstmt.setString(2, orderP.getOrderDt());
			pstmt.setInt(3, orderP.getWhNo()); 
			pstmt.setString(4, "10"); //statusCd
			pstmt.setFloat(5, orderP.getSubtotal());
			pstmt.setFloat(6, orderP.getTax());
			pstmt.setFloat(7, orderP.getTotalAmt());
						
			pstmt.setString(8, orderP.getCurCd());
			pstmt.setString(9, orderP.getInsertUserId());
			
System.out.println(pstmt.toString());
			pstmt.execute(); 
			
		}catch(Exception e) { 
			throw e;
		}finally { 
			DBClose.close(con,pstmt); 
		} 
	} 
	
	
	public void insertOrderPItem(OrderPItem orderPItem) throws Exception { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		
		try { 
			sql = "insert into orderPItem (orderNo, seq, itemNo, itemCnt, itemPrice, curCd, insertUserId, insertDatetime) VALUES (?,?,?,?,?,?,?, current_timestamp())"; 
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, orderPItem.getOrderNo()); 
			pstmt.setInt(2, orderPItem.getSeq()); 
			pstmt.setInt(3, orderPItem.getItemNo());
			pstmt.setInt(4, orderPItem.getItemCnt());
			pstmt.setFloat(5, orderPItem.getItemPrice());
			pstmt.setString(6, orderPItem.getCurCd());
			pstmt.setString(7, orderPItem.getInsertUserId());
			
System.out.println(pstmt.toString());
			pstmt.execute(); 
			//System.out.println(sql);
			
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
			sql = "update orderP set orderDt=?, whNo=?, subtotal=?, tax=?, totalAmt=?, curCd=?, updateUserId=?, updateDatetime=current_timestamp() where orderNo=?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, orderP.getOrderDt());
			pstmt.setInt(2, orderP.getWhNo());
			pstmt.setFloat(3, orderP.getSubtotal()); 
			pstmt.setFloat(4, orderP.getTax()); 
			pstmt.setFloat(5, orderP.getTotalAmt()); 
			pstmt.setString(6, orderP.getCurCd());
			pstmt.setString(7, orderP.getUpdateUserId());
			pstmt.setInt(8, orderP.getOrderNo());
						
			pstmt.executeUpdate();
			//System.out.println(sql);
			
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
			//System.out.println(sql);
			
		}catch(Exception e) { 
			throw e;
		}finally { 
			DBClose.close(con,pstmt); 
		} 
	} 
	
	
	public void deleteOrderPItem(int orderNo) throws Exception { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		
		try { 
			sql = "delete from orderPItem where orderNo = ?"; 
			
			pstmt = con.prepareStatement(sql); 
			pstmt.setInt(1, orderNo); 
			pstmt.executeUpdate(); 
			//System.out.println(sql);
			
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
			//System.out.println(sql);
			
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

			sqlBuf.append("		select  a.orderNo, ");
			sqlBuf.append("				a.rcvSeq, ");
			sqlBuf.append("				a.rcvDt, ");
			sqlBuf.append("				a.note, ");
			sqlBuf.append("				b.whNo, ");//5 
			sqlBuf.append("				a.insertUserId, ");
			sqlBuf.append("				a.insertDatetime, ");
			sqlBuf.append("				a.updateUserId, ");
			sqlBuf.append("				a.updateDatetime  ");
			sqlBuf.append("        from orderPRcv a ");
			sqlBuf.append("        left outer join orderP b ");
			sqlBuf.append("          on a.orderNo = b.orderNo ");
			sqlBuf.append("       where a.orderNo = ?");
			sqlBuf.append("         and rcvSeq = ?;");
 
			pstmt = con.prepareStatement(sqlBuf.toString()); 
			pstmt.setInt(1, orderNo);
			pstmt.setInt(2, rcvSeq);
			rs = pstmt.executeQuery(); 
			//System.out.println(sqlBuf.toString());
			
			if(rs.next()) { 
				orderPRcv = new OrderPRcv(rs.getInt(1), rs.getInt(2), rs.getString(3), rs.getString(4), rs.getInt(5), rs.getString(6), rs.getString(8)); 
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

			sqlBuf.append("		select  a.orderNo, ");
			sqlBuf.append("				a.rcvSeq, ");
			sqlBuf.append("				a.rcvDt, ");
			sqlBuf.append("				a.note, ");
			sqlBuf.append("				b.whNo, ");//5 
			sqlBuf.append("				a.insertUserId, ");
			sqlBuf.append("				a.insertDatetime, ");
			sqlBuf.append("				a.updateUserId, ");
			sqlBuf.append("				a.updateDatetime  ");
			sqlBuf.append("        from orderPRcv a ");
			sqlBuf.append("        left outer join orderP b ");
			sqlBuf.append("          on a.orderNo = b.orderNo ");
			sqlBuf.append("       where a.orderNo = ?");
			sqlBuf.append("       order by rcvSeq;");
 
			pstmt = con.prepareStatement(sqlBuf.toString()); 
			pstmt.setInt(1, orderNo);
			rs = pstmt.executeQuery(); 
			//System.out.println(sqlBuf.toString());
			
			while(rs.next()) { 
				OrderPRcv orderPRcv = new OrderPRcv(rs.getInt(1), rs.getInt(2), rs.getString(3), rs.getString(4), rs.getInt(5), rs.getString(6), rs.getString(8)); 
				
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

			sqlBuf.append("		select  a.orderNo, ");
			sqlBuf.append("				a.rcvSeq, ");
			sqlBuf.append("				a.seq, ");
			sqlBuf.append("				a.itemNo, ");
			sqlBuf.append("				a.itemCnt, ");//5
			sqlBuf.append("				b.whNo, ");//6 
			sqlBuf.append("				a.insertUserId, ");//7
			sqlBuf.append("				a.insertDatetime, ");
			sqlBuf.append("				a.updateUserId, ");//9
			sqlBuf.append("				a.updateDatetime  ");
			sqlBuf.append("        from orderPRcvItem a ");
			sqlBuf.append("        left outer join orderP b ");
			sqlBuf.append("          on a.orderNo = b.orderNo ");
			sqlBuf.append("       where a.orderNo = ?");
			sqlBuf.append("         and rcvSeq = ?");
			sqlBuf.append("       order by seq;");
 
			pstmt = con.prepareStatement(sqlBuf.toString()); 
			pstmt.setInt(1, orderNo);
			pstmt.setInt(2, rcvSeq);
			rs = pstmt.executeQuery(); 
			//System.out.println(sqlBuf.toString());
			
			while(rs.next()) { 
				OrderPRcvItem orderPRcvItem = new OrderPRcvItem(rs.getInt(1), rs.getInt(2), rs.getInt(3), rs.getInt(4), rs.getInt(5), rs.getInt(6), rs.getString(7), rs.getString(9)); 
				
				alist.add(orderPRcvItem); 
			} 
		}catch(Exception e) { 
			throw e;
		}finally { 
			DBClose.close(con,pstmt,rs); 
		} 
		
		return alist; 
	}  	
	
	public OrderPRcvItem getOrderPRcvItem(int orderNo, int rcvSeq, int itemNo) throws Exception { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		OrderPRcvItem orderPRcvItem = null; 
		
		try { 
			StringBuffer sqlBuf=new StringBuffer(); 

			sqlBuf.append("		select  a.orderNo, ");
			sqlBuf.append("				a.rcvSeq, ");
			sqlBuf.append("				a.seq, ");
			sqlBuf.append("				a.itemNo, ");
			sqlBuf.append("				a.itemCnt, ");//5
			sqlBuf.append("				b.whNo, ");//6 
			sqlBuf.append("				a.insertUserId, ");//7
			sqlBuf.append("				a.insertDatetime, ");
			sqlBuf.append("				a.updateUserId, ");//9
			sqlBuf.append("				a.updateDatetime  ");
			sqlBuf.append("        from orderPRcvItem a ");
			sqlBuf.append("        left outer join orderP b ");
			sqlBuf.append("          on a.orderNo = b.orderNo ");
			sqlBuf.append("       where a.orderNo = ?");
			sqlBuf.append("         and rcvSeq = ?");
			sqlBuf.append("         and itemNo = ?");
			sqlBuf.append("       order by seq;");
 
			pstmt = con.prepareStatement(sqlBuf.toString()); 
			pstmt.setInt(1, orderNo);
			pstmt.setInt(2, rcvSeq);
			pstmt.setInt(3, itemNo);
			rs = pstmt.executeQuery(); 
System.out.println(pstmt.toString());			
			
			while(rs.next()) { 
				orderPRcvItem = new OrderPRcvItem(rs.getInt(1), rs.getInt(2), rs.getInt(3), rs.getInt(4), rs.getInt(5), rs.getInt(6), rs.getString(7), rs.getString(9));
			} 
		}catch(Exception e) { 
			throw e;
		}finally { 
			DBClose.close(con,pstmt,rs); 
		} 
		
		return orderPRcvItem; 
	}  	
		
		
	public void insertOrderPRcv(OrderPRcv orderPRcv) throws Exception { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		
		try { 
			sql = "insert into orderPRcv (orderNo, rcvSeq, rcvDt, note, insertUserId, insertDatetime) VALUES (?,?,?,?,?, current_timestamp())"; 
			
			pstmt = con.prepareStatement(sql); 

			pstmt.setInt(1, orderPRcv.getOrderNo());
			pstmt.setInt(2, orderPRcv.getRcvSeq());
			//pstmt.setString(3, incoding(orderPRcv.getRcvDt())); 
			pstmt.setString(3, orderPRcv.getRcvDt());
			//pstmt.setString(4, incoding(orderPRcv.getNote())); 
			pstmt.setString(4, orderPRcv.getNote());
			pstmt.setString(5, orderPRcv.getInsertUserId());
			
System.out.println(pstmt.toString());
			pstmt.execute(); 
			//System.out.println(sql);
			
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
			sql = "insert into orderPRcvItem (orderNo, rcvSeq, seq, itemNo, itemCnt, insertUserId, insertDatetime) VALUES (?,?,?,?,?,?, current_timestamp())"; 
			
			pstmt = con.prepareStatement(sql); 

			pstmt.setInt(1, orderPRcvItem.getOrderNo()); 
			pstmt.setInt(2, orderPRcvItem.getRcvSeq()); 
			pstmt.setInt(3, orderPRcvItem.getSeq()); 
			pstmt.setInt(4, orderPRcvItem.getItemNo());
			pstmt.setInt(5, orderPRcvItem.getItemCnt());
			pstmt.setString(6, orderPRcvItem.getInsertUserId());
			
System.out.println(pstmt.toString());
			pstmt.execute(); 
			//System.out.println(sql);
			
		}catch(Exception e) { 
			throw e;
		}finally { 
			DBClose.close(con,pstmt); 
		} 
	} 

	
	//-------------------------------------------
	// WhItem itemCnt 처리   
	//-------------------------------------------
	
	// 1. 입고처리 등록 (수량 등록) : 개별 item 수량 등록 
	// 2. 입고처리 수정 (수량 변경) : 개별 item 수량 삭제 후 등록  
	// 3. 입고처리 삭제                  : item 전체 삭제 
	
	
	// 새 갯수를 더하기만 함 
	public void addWhItemCnt(OrderPRcvItem rcvItem) throws Exception {
		
		WhItem whItem = new WhItem(rcvItem.getWhNo(), rcvItem.getItemNo(), rcvItem.getItemCnt(), rcvItem.getInsertUserId(), rcvItem.getUpdateUserId());

		WhItemDAO whItemDAO = new WhItemDAO();
		
		whItemDAO.addWhItemCnt(whItem); 	// 새 갯수 더하기 
	}
		
	/*
	// 기존 갯수를 빼고 새 갯수를 더함
	public void setWhItemCnt(OrderPRcvItem rcvItem) throws Exception {
		
		WhItem whItem = new WhItem(rcvItem.getWhNo(), rcvItem.getItemNo(), rcvItem.getItemCnt(), rcvItem.getInsertUserId(), rcvItem.getUpdateUserId());

		// 기존 갯수 구하기 
		OrderPRcvItem oldRcvItem = getOrderPRcvItem(rcvItem.getOrderNo(), rcvItem.getRcvSeq(), rcvItem.getItemNo());
		WhItem oldWhItem = new WhItem(oldRcvItem.getWhNo(), oldRcvItem.getItemNo(), oldRcvItem.getItemCnt()*(-1), rcvItem.getInsertUserId(), rcvItem.getUpdateUserId());
				
		WhItemDAO whItemDAO = new WhItemDAO();
		
		whItemDAO.addWhItemCnt(oldWhItem); 	// 기존 갯수 빼기 
		whItemDAO.addWhItemCnt(whItem); 	// 새 갯수 더하기 
	}
		*/
	
	public void minusWhItemCnt(int orderNo, int rcvSeq, String updateUserId) throws Exception {

		ArrayList<OrderPRcvItem> rcvItemList = this.getOrderPRcvItemList(orderNo, rcvSeq);
		int size = rcvItemList.size();
		
		OrderPRcvItem rcvItem;
		WhItem whItem;
		WhItemDAO whItemDao = new WhItemDAO();
		
 		for(int i = 0; i < size; i++) {
 			rcvItem = rcvItemList.get(i);
 			if(rcvItem.getItemCnt() == 0)
 				continue;
 			whItem = new WhItem(rcvItem.getWhNo(), rcvItem.getItemNo(), rcvItem.getItemCnt()*(-1), updateUserId, updateUserId);
 			whItemDao.addWhItemCnt(whItem);
 		}
	}

	


	public void modifyOrderPRcv(OrderPRcv orderPRcv) throws Exception {
		
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		
		try { 
			sql = "update orderPRcv set rcvDt=?, note=?, updateUserId=?, updateDatetime=current_timestamp() where orderNo=? and rcvSeq=?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, orderPRcv.getRcvDt());
			//pstmt.setString(2, incoding(orderPRcv.getNote()));
			pstmt.setString(2, orderPRcv.getNote());
			pstmt.setString(3, orderPRcv.getUpdateUserId());

			pstmt.setInt(4, orderPRcv.getOrderNo());
			pstmt.setInt(5, orderPRcv.getRcvSeq());
						
			pstmt.executeUpdate();
			//System.out.println(sql);
			
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
			//System.out.println(sql);
			
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
			//System.out.println(sql);
			
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
			sqlBuf.append("			where a.orderNo = ?; "); 
			
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
		} return alist; 
	} 

	*/
	
}



