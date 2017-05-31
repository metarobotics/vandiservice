package wh; 

import java.sql.Connection; 
import java.sql.PreparedStatement; 
import java.sql.ResultSet; 
import java.text.SimpleDateFormat; 
import java.util.ArrayList; 
import java.util.Date; 

public class OrderSDAO extends DAO { 
	
	private String orderFg = "S";
	
	public OrderSDAO() {
		// TODO Auto-generated constructor stub
	}
	
	public int getNextOrderNo() throws Exception {
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		int no = 0; 
		
		try { 
			sql = "select ifnull(max(orderNo),0)+1 from orderS"; 
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
	
	public int countOrderS() throws Exception { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		int cnt = 0; 
		
		try { 
			sql = "SELECT COUNT(*) FROM orderS"; 
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
	
	public String incoding(String data) { 
		try { 
			//data = new String(data.getBytes("8859_1"), "euc-kr");
			//data = new String(data.getBytes("KSC5601"), "8859_1");
			
//			sql = new String(",  statusNm ".getBytes("8859_1"), "euc-kr");
//			sql = new String(",  statusNm ".getBytes("KSC5601"), "8859_1");
			
		}catch (Exception e){ } 
		return data; 
	} 
	
	
	public OrderS getOrderSInfo(int orderNo) throws Exception { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		OrderS orderS = null; 
		
		try { 
			StringBuffer sqlBuf=new StringBuffer(); 
			
			sqlBuf.append("		select a.*, b.whNm centerNm, d.clientNo clientNo, d.clientNm clientNm "); 
			sqlBuf.append("      		" + incoding(", case a.statusCd when '10' then '주문' when '20' then '출력' when '30' then '완료' end statusNm "));
			sqlBuf.append("        from orderS a ");
			sqlBuf.append("        left join wh b on a.centerNo = b.whNo");
			sqlBuf.append("        left join productEach c on a.productSerialNo = c.serialNo");
			sqlBuf.append("        left join client d on c.clientNo = d.clientNo");
			sqlBuf.append("        where a.orderNo = ?; ");
			
			pstmt = con.prepareStatement(sqlBuf.toString()); 
			pstmt.setInt(1, orderNo); 
			rs = pstmt.executeQuery(); 
			
			if(rs.next()) { 
				orderS = new OrderS(rs.getInt(1), rs.getString(2), rs.getInt(3), rs.getString(4), rs.getString(5), rs.getInt(6), rs.getInt(7), rs.getInt(8), 
						rs.getString(15), rs.getString(16), rs.getString(19), rs.getInt(20), rs.getString(21), rs.getString(21)); 
			} 
		}catch(Exception e) { 
			throw e;
		}finally { 
			DBClose.close(con,pstmt,rs); 
		} 
		
		return orderS; 
	} 
		
	
	public ArrayList<OrderS> getOrderSList() throws Exception { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		ArrayList<OrderS> alist = new ArrayList<OrderS>(); 
		
		try { 
			StringBuffer sqlBuf=new StringBuffer(); 

			sqlBuf.append("		select a.*, b.whNm centerNm, d.clientNo clientNo, d.clientNm clientNm "); 
			sqlBuf.append("      		" + incoding(", case a.statusCd when '10' then '주문' when '20' then '출력' when '30' then '완료' end statusNm "));
			sqlBuf.append("        from orderS a ");
			sqlBuf.append("        left join wh b on a.centerNo = b.whNo");
			sqlBuf.append("        left join productEach c on a.productSerialNo = c.serialNo");
			sqlBuf.append("        left join client d on c.clientNo = d.clientNo");
			sqlBuf.append("        order by orderNo desc;");
 
			pstmt = con.prepareStatement(sqlBuf.toString()); 
			rs = pstmt.executeQuery(); 
			while(rs.next()) { 

				OrderS orderS = new OrderS(rs.getInt(1), rs.getString(2), rs.getInt(3), rs.getString(4), rs.getString(5), rs.getInt(6), rs.getInt(7), rs.getInt(8), 
						rs.getString(15), rs.getString(16), rs.getString(19), rs.getInt(20), rs.getString(21), rs.getString(21)); 
				
				alist.add(orderS); 
			} 
		}catch(Exception e) { 
			throw e;
		}finally { 
			DBClose.close(con,pstmt,rs); 
		} return alist; 
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
	
	
	public void insertOrderS(OrderS orderS) throws Exception { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		
		try { 
			
			sql = "insert into orderS (orderNo, orderDt, centerNo, productSerialNo, statusCd, subtotal, tax, totalAmt, insertUserId, insertDatetime) VALUES (?,?,?,?,?,?,?,?,?, current_timestamp())"; 
			pstmt = con.prepareStatement(sql); 

			pstmt.setInt(1, orderS.getOrderNo());
			pstmt.setString(2, incoding(orderS.getOrderDt())); 
			pstmt.setInt(3, orderS.getCenterNo()); 
			pstmt.setString(4, orderS.getProductSerialNo());
			pstmt.setString(5, "10"); //statusCd
			pstmt.setInt(6, orderS.getSubtotal());
			pstmt.setInt(7, orderS.getTax());
			pstmt.setInt(8, orderS.getTotalAmt());
			pstmt.setString(9, orderS.getInsertUserId());
			
			pstmt.execute(); 
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
			sql = "insert into orderItem (orderFg, orderNo, seq, itemNo, itemCnt, itemPrice, insertUserId, insertDatetime) VALUES (?,?,?,?,?,?,?, current_timestamp())"; 
			pstmt = con.prepareStatement(sql); 

			pstmt.setString(1, orderFg);
			pstmt.setInt(2, orderItem.getOrderNo()); 
			pstmt.setInt(3, orderItem.getSeq()); 
			pstmt.setInt(4, orderItem.getItemNo());
			pstmt.setInt(5, orderItem.getItemCnt());
			pstmt.setInt(6, orderItem.getItemPrice());
			pstmt.setString(7, orderItem.getInsertUserId());
			
			pstmt.execute(); 
		}catch(Exception e) { 
			throw e;
		}finally { 
			DBClose.close(con,pstmt); 
		} 
	} 
	

	public void modifyOrderS(OrderS orderS) throws Exception { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		try { 
			sql = "update orderS set centerNo=?, productSerialNo=?, subtotal=?, tax=?, totalAmt=?, updateDatetime=current_timestamp() where orderNo=?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, orderS.getCenterNo()); 
			pstmt.setString(2, orderS.getProductSerialNo()); 
			pstmt.setInt(3, orderS.getSubtotal());
			pstmt.setInt(4, orderS.getTax());
			pstmt.setInt(5, orderS.getTotalAmt());
			pstmt.setInt(6, orderS.getOrderNo());
						
			pstmt.executeUpdate(); 
		}catch(Exception e) { 
			System.out.println(e.toString());
		}finally { 
			DBClose.close(con,pstmt); 
		} 
	} 
	
	
	public void deleteOrderS(int orderNo) throws Exception { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		try { 
			sql = "delete from orderS where orderNo = ?"; 
			pstmt = con.prepareStatement(sql); 
			pstmt.setInt(1, orderNo); 
			pstmt.executeUpdate();
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
		}catch(Exception e) { 
			throw e;
		}finally { 
			DBClose.close(con,pstmt); 
		} 
	} 
	
}



