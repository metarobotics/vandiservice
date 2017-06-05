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
			sqlBuf.append("        from orderP a ");
			sqlBuf.append("        left join wh b on a.whNo = b.whNo");
			sqlBuf.append("        where a.orderNo = ?; ");
			
			pstmt = con.prepareStatement(sqlBuf.toString()); 
			pstmt.setInt(1, orderNo); 
			rs = pstmt.executeQuery(); 
			System.out.println(sqlBuf.toString());
			
			
			sql = "select * from orderP where orderNo = ?"; 
			
			if(rs.next()) { 

				orderP = new OrderP(rs.getInt(1), rs.getString(2), rs.getInt(3), rs.getString(6), rs.getFloat(7), rs.getFloat(8), rs.getFloat(9), rs.getString(10), rs.getString(17), rs.getString(19), rs.getString(21), rs.getString(22)); 
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
			sqlBuf.append("        from orderP a ");
			sqlBuf.append("        left join wh b on a.whNo = b.whNo");
			sqlBuf.append("        order by orderNo desc;");
 
			pstmt = con.prepareStatement(sqlBuf.toString()); 
			rs = pstmt.executeQuery(); 
			System.out.println(sqlBuf.toString());
			
			while(rs.next()) { 
				OrderP orderP = new OrderP(rs.getInt(1), rs.getString(2), rs.getInt(3), rs.getString(6), rs.getFloat(7), rs.getFloat(8), rs.getFloat(9), rs.getString(10), rs.getString(17), rs.getString(19), rs.getString(21), rs.getString(22)); 
				
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
			sqlBuf.append("        from orderP a ");
			sqlBuf.append("        left join wh b on a.srcWhNo = b.whNo");
			sqlBuf.append("       where a.whNo = ?");
			sqlBuf.append("        order by orderNo desc;");
 
			pstmt = con.prepareStatement(sqlBuf.toString()); 
			pstmt.setInt(1, whNo); 
			rs = pstmt.executeQuery(); 
			System.out.println(sqlBuf.toString());
			
			while(rs.next()) { 
				OrderP orderP = new OrderP(rs.getInt(1), rs.getString(2), rs.getInt(3), rs.getString(6), rs.getFloat(7), rs.getFloat(8), rs.getFloat(9), rs.getString(10), rs.getString(17), rs.getString(19), rs.getString(21), rs.getString(22)); 
				
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
}



