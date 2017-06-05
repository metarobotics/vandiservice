package wh; 

import java.sql.Connection; 
import java.sql.PreparedStatement; 
import java.sql.ResultSet; 
import java.text.SimpleDateFormat; 
import java.util.ArrayList; 
import java.util.Date; 

public class OrderTDAO extends DAO { 
	
	private String orderFg = "T";
	
	public OrderTDAO() {
		// TODO Auto-generated constructor stub
	}
	
	public int getNextOrderNo() throws Exception  {
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		int no = 0; 
		
		try { 
			sql = "select ifnull(max(orderNo),0)+1 from orderT"; 
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
	public int countOrderT() { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		int cnt = 0; 
		
		try { 
			sql = "SELECT COUNT(*) FROM orderT"; 
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
	
	
	public OrderT getOrderTInfo(int orderNo) throws Exception  { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		OrderT orderT = null; 
		
		try { 
			sql = "select * from orderT where orderNo = ?"; 
			pstmt = con.prepareStatement(sql); 
			pstmt.setInt(1, orderNo); 
			rs = pstmt.executeQuery(); 
			System.out.println(sql);
			
			if(rs.next()) { 
				orderT = new OrderT(rs.getInt(1), rs.getString(2), rs.getInt(3), rs.getInt(4), rs.getString(7), rs.getInt(8), rs.getInt(9), rs.getInt(10), rs.getString(17), rs.getString(19)); 
			} 
		}catch(Exception e) { 
			throw e;
		}finally { 
			DBClose.close(con,pstmt,rs); 
		} 
		
		return orderT; 
	} 
	
	
	public ArrayList<OrderT> getOrderTList() throws Exception  { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		ArrayList<OrderT> alist = new ArrayList<OrderT>(); 
		
		try { 
			StringBuffer sqlBuf=new StringBuffer(); 

			sqlBuf.append("		select a.*, b.whNm srcWhNm, c.whNm destWhNm "); 
			sqlBuf.append("      		" + incoding(", case a.statusCd when '10' then '�ֹ�' when '20' then '����' when '21' then '�����' when '30' then '�����' when '40' then '��ۿϷ�' end statusNm "));
			sqlBuf.append("        from orderT a ");
			sqlBuf.append("        left join wh b on a.srcWhNo = b.whNo");
			sqlBuf.append("        left join wh c on a.destWhNo = c.whNo");
			sqlBuf.append("        order by orderNo desc;");
 
			pstmt = con.prepareStatement(sqlBuf.toString()); 
			rs = pstmt.executeQuery(); 
			System.out.println(sqlBuf.toString());
			
			while(rs.next()) { 
				OrderT orderT = new OrderT(rs.getInt(1), rs.getString(2), rs.getInt(3), rs.getInt(4), rs.getString(7), rs.getInt(8), rs.getInt(9), rs.getInt(10), rs.getString(17), rs.getString(21), rs.getString(22), rs.getString(23)); 
				
				alist.add(orderT); 
			} 
		}catch(Exception e) { 
			throw e;
		}finally { 
			DBClose.close(con,pstmt,rs); 
		} 
		
		return alist; 
	} 
	
	public ArrayList<OrderT> getOrderTList(int whNo) throws Exception  { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		ArrayList<OrderT> alist = new ArrayList<OrderT>(); 
		
		try { 
			StringBuffer sqlBuf=new StringBuffer(); 

			sqlBuf.append("		select a.*, b.whNm srcWhNm, c.whNm destWhNm "); 
			sqlBuf.append("      		" + incoding(", case a.statusCd when '10' then '�ֹ�' when '20' then '����' when '21' then '�����' when '30' then '�����' when '40' then '��ۿϷ�' end statusNm "));
			sqlBuf.append("        from orderT a ");
			sqlBuf.append("        left join wh b on a.srcWhNo = b.whNo");
			sqlBuf.append("        left join wh c on a.destWhNo = c.whNo");
			sqlBuf.append("       where a.destWhNo = ?");
			sqlBuf.append("        order by orderNo desc;");
 
			pstmt = con.prepareStatement(sqlBuf.toString()); 
			pstmt.setInt(1, whNo); 
			rs = pstmt.executeQuery(); 
			System.out.println(sqlBuf.toString());
			
			while(rs.next()) { 
				OrderT orderT = new OrderT(rs.getInt(1), rs.getString(2), rs.getInt(3), rs.getInt(4), rs.getString(7), rs.getInt(8), rs.getInt(9), rs.getInt(10), rs.getString(17), rs.getString(21), rs.getString(22), rs.getString(23)); 
				
				alist.add(orderT); 
			} 
		}catch(Exception e) { 
			throw e;
		}finally { 
			DBClose.close(con,pstmt,rs); 
		} 
		
		return alist; 
	} 	
	
	public ArrayList<OrderItem> getOrderItemList(int orderNo) throws Exception  { 
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
				
				OrderItem orderItem = new OrderItem(rs.getString(1), rs.getInt(2), rs.getInt(3), rs.getInt(4), rs.getInt(5), rs.getInt(6), rs.getString(7)); 

				alist.add(orderItem); 
			} 
		}catch(Exception e) { 
			throw e;
		}finally { 
			DBClose.close(con,pstmt,rs); 
		} 
		
		return alist; 
	} 
	
	
	public void insertOrderT(OrderT orderT) throws Exception  { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		
		try { 
			
			sql = "insert into orderT (orderNo, orderDt, srcWhNo, destWhNo, statusCd, subtotal, tax, totalAmt, insertUserId, insertDatetime) VALUES (?,?,?,?,?,?,?,?,?, current_timestamp())"; 
			pstmt = con.prepareStatement(sql); 

			pstmt.setInt(1, orderT.getOrderNo());
			pstmt.setString(2, incoding(orderT.getOrderDt())); 
			pstmt.setInt(3, orderT.getSrcWhNo()); 
			pstmt.setInt(4, orderT.getDestWhNo());
			pstmt.setString(5, "10"); //statusCd
			pstmt.setInt(6, orderT.getSubtotal());
			pstmt.setInt(7, orderT.getTax());
			pstmt.setInt(8, orderT.getTotalAmt());
			pstmt.setString(9, orderT.getInsertUserId());
			
			pstmt.execute(); 
			System.out.println(sql);
			
		}catch(Exception e) { 
			throw e;
		}finally { 
			DBClose.close(con,pstmt); 
		} 
	} 
	
	
	public void insertOrderItem(OrderItem orderItem) throws Exception  { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		
		try { 
			sql = "insert into orderItem (orderFg, orderNo, seq, itemNo, itemCnt, itemPrice, insertUserId, insertDatetime) VALUES (?,?,?,?,?,?,?, current_timestamp())"; 
			pstmt = con.prepareStatement(sql); 

			pstmt.setString(1, orderFg);
			pstmt.setInt(2, orderItem.getOrderNo()); 
			pstmt.setInt(3, orderItem.getSeq()); 
			pstmt.setInt(4, orderItem.getItemNo());
			pstmt.setInt(5, orderItem.getItemCnt());
			pstmt.setFloat(6, orderItem.getItemPrice());
			pstmt.setString(7, orderItem.getInsertUserId());
			
			pstmt.execute(); 
			System.out.println(sql);
			
		}catch(Exception e) { 
			throw e;
		}finally { 
			DBClose.close(con,pstmt); 
		} 
	} 
	
	
	public void modifyOrderT(OrderT orderT) throws Exception {
		
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		
		try { 
			sql = "update orderT set orderDt=?, srcWhNo=?, destWhNo=?, subtotal=?, tax=?, totalAmt=?, updateDatetime=current_timestamp() where orderNo=?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, orderT.getOrderDt());
			pstmt.setInt(2, orderT.getSrcWhNo()); 
			pstmt.setInt(3, orderT.getDestWhNo());
			pstmt.setInt(4, orderT.getSubtotal()); 
			pstmt.setInt(5, orderT.getTax()); 
			pstmt.setInt(6, orderT.getTotalAmt()); 
			pstmt.setInt(7, orderT.getOrderNo());
						
			pstmt.executeUpdate(); 
			System.out.println(sql);
			
		}catch(Exception e) { 
			throw e;
		}finally { 
			DBClose.close(con,pstmt); 
		} 
	} 	
	
	
	/*
	 * ����  
	 */
	public void deleteOrderT(int orderNo) throws Exception  { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		
		try { 
			
			sql = "delete from orderT where orderNo = ?"; 
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
	
	
	public void deleteOrderItem(int orderNo) throws Exception  { 
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
	 * ���� 
	 */
	public void acceptOrderT(int orderNo) throws Exception { 
		modifyOrderTStatus(orderNo, "20");
	} 
	
	/*
	 * ����� 
	 */
	public void shipOrderT(int orderNo) throws Exception { 
		modifyOrderTStatus(orderNo, "30");
	} 
	
	/*
	 * �Ϸ� 
	 */
	public void finishOrderT(int orderNo) throws Exception { 
		modifyOrderTStatus(orderNo, "40");
	} 
	
	/*
	 * ���º���
	 */
	private void modifyOrderTStatus(int orderNo, String statusCd) throws Exception { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		
		try { 
			sql = "update orderT set statusCd=? where orderNo=?";
			
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



