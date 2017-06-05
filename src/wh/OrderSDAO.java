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
	
	public int countOrderS() throws Exception { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		int cnt = 0; 
		
		try { 
			sql = "SELECT COUNT(*) FROM orderS"; 
			pstmt = con.prepareStatement(sql); 
			rs = pstmt.executeQuery(); 
			System.out.println(sql);
			
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
			/*
			private int orderNo;
			private String orderDt;
			private int whNo;
			private String productSerialNo;//4
			private String statusCd;
			private int subtotal;
			private int tax;
			private int totalAmt;
			private int depositPrgAmt;
			private int creditPrgAmt;//10
			private int depositAmt;
			private int creditAmt;
			private int receiptAmt;
			private String note;//14
			
			private String insertUserId;
			private String insertDatetime;
			private String updateUserId;
			private String updateDatetime;//18

			private String centerNm;
			private int clientNo;
			private String clientNm;
			private String statusNm;//22
			*/
			
			sqlBuf.append("		select a.*, b.whNm centerNm, d.clientNo clientNo, d.clientNm clientNm "); 
			sqlBuf.append("      		" + incoding(", case a.statusCd when '10' then '주문' when '20' then '확정' else '' end statusNm "));
			sqlBuf.append("        from orderS a ");
			sqlBuf.append("        left join wh b on a.whNo = b.whNo");
			sqlBuf.append("        left join productEach c on a.productSerialNo = c.serialNo");
			sqlBuf.append("        left join client d on c.clientNo = d.clientNo");
			sqlBuf.append("        where a.orderNo = ?; ");
			
			pstmt = con.prepareStatement(sqlBuf.toString()); 
			pstmt.setInt(1, orderNo); 
			rs = pstmt.executeQuery(); 
			System.out.println(sqlBuf.toString());
			
			if(rs.next()) { 
/*				
				public OrderS(int orderNo, String orderDt, int whNo, String productSerialNo, 
						String statusCd, int subtotal, int tax, int totalAmt, 
						String insertUserId, String insertDatetime,
						String centerNm, int clientNo, String clientNm, String statusNm) {
*/				
				
				orderS = new OrderS(rs.getInt(1), rs.getString(2), rs.getInt(3), rs.getString(4), 
						rs.getString(5), rs.getInt(6), rs.getInt(7), rs.getInt(8), rs.getString(14), 
						rs.getString(15), rs.getString(16), 
						rs.getString(19), rs.getInt(20), rs.getString(21), rs.getString(22)); 
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
			sqlBuf.append("      		" + incoding(", case a.statusCd when '10' then '주문' when '20' then '확정' else '' end statusNm "));
			sqlBuf.append("        from orderS a ");
			sqlBuf.append("        left join wh b on a.whNo = b.whNo");
			sqlBuf.append("        left join productEach c on a.productSerialNo = c.serialNo");
			sqlBuf.append("        left join client d on c.clientNo = d.clientNo");
			sqlBuf.append("        order by orderNo desc;");
 
			pstmt = con.prepareStatement(sqlBuf.toString()); 
			rs = pstmt.executeQuery();
			System.out.println(sqlBuf.toString());
			
			while(rs.next()) { 

				OrderS orderS = new OrderS(rs.getInt(1), rs.getString(2), rs.getInt(3), rs.getString(4), rs.getString(5), rs.getInt(6), rs.getInt(7), rs.getInt(8), rs.getString(14),  
						rs.getString(15), rs.getString(16), rs.getString(19), rs.getInt(20), rs.getString(21), rs.getString(22)); 
				
				alist.add(orderS); 
			} 
		}catch(Exception e) { 
			throw e;
		}finally { 
			DBClose.close(con,pstmt,rs); 
		} 
		
		return alist; 
	} 
	
	public ArrayList<OrderS> getOrderSList(int whNo) throws Exception { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		ArrayList<OrderS> alist = new ArrayList<OrderS>(); 
		
		try { 
			StringBuffer sqlBuf=new StringBuffer(); 

			sqlBuf.append("		select a.*, b.whNm centerNm, d.clientNo clientNo, d.clientNm clientNm "); 
			sqlBuf.append("      		" + incoding(", case a.statusCd when '10' then '주문' when '20' then '확정' else '' end statusNm "));
			sqlBuf.append("        from orderS a ");
			sqlBuf.append("        left join wh b on a.whNo = b.whNo");
			sqlBuf.append("        left join productEach c on a.productSerialNo = c.serialNo");
			sqlBuf.append("        left join client d on c.clientNo = d.clientNo");
			sqlBuf.append("       where a.whNo = ?");
			sqlBuf.append("        order by orderNo desc;");
 
			pstmt = con.prepareStatement(sqlBuf.toString()); 
			pstmt.setInt(1, whNo); 
			rs = pstmt.executeQuery();
			System.out.println(sqlBuf.toString());
			
			while(rs.next()) { 

				OrderS orderS = new OrderS(rs.getInt(1), rs.getString(2), rs.getInt(3), rs.getString(4), rs.getString(5), rs.getInt(6), rs.getInt(7), rs.getInt(8), rs.getString(14), 
						rs.getString(15), rs.getString(16), rs.getString(19), rs.getInt(20), rs.getString(21), rs.getString(22)); 
				
				alist.add(orderS); 
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
/*
			private String orderFg;
			private int orderNo;
			private int seq;
			private int itemNo;
			private int itemCnt;
			private int itemPrice;
			private float serviceHour; // for SO
			
			private String insertUserId; //8
			private String insertDatetime;
			private String updateUserId;
			private String updateDatetime;
*/			
			sqlBuf.append("		select a.* "); 
			sqlBuf.append("        from orderItem a ");
			sqlBuf.append("        where orderFg='" + orderFg + "' and orderNo = ? ");
			sqlBuf.append("        order by seq;");
 			
			pstmt = con.prepareStatement(sqlBuf.toString()); 
			pstmt.setInt(1, orderNo);
			rs = pstmt.executeQuery();
			System.out.println(sqlBuf.toString());
			
			while(rs.next()) { 
				
				OrderItem orderItem = new OrderItem(rs.getString(1), rs.getInt(2), rs.getInt(3), rs.getInt(4), rs.getInt(5), rs.getInt(6), rs.getFloat(7), rs.getString(8)); 
				
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
			
			sql = "insert into orderS (orderNo, orderDt, whNo, productSerialNo, statusCd, subtotal, tax, totalAmt, note, insertUserId, insertDatetime) VALUES (?,?,?,?,?,?,?,?,?,?, current_timestamp())"; 
			pstmt = con.prepareStatement(sql); 

			pstmt.setInt(1, orderS.getOrderNo());
			pstmt.setString(2, incoding(orderS.getOrderDt())); 
			pstmt.setInt(3, orderS.getWhNo()); 
			pstmt.setString(4, orderS.getProductSerialNo());
			pstmt.setString(5, "10"); //statusCd
			pstmt.setInt(6, orderS.getSubtotal());
			pstmt.setInt(7, orderS.getTax());
			pstmt.setInt(8, orderS.getTotalAmt());
			pstmt.setString(9, orderS.getNote());
			pstmt.setString(10, orderS.getInsertUserId());
			
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
			sql = "insert into orderItem (orderFg, orderNo, seq, itemNo, itemCnt, itemPrice, serviceHour, insertUserId, insertDatetime) VALUES (?,?,?,?,?,?,?,?, current_timestamp())"; 
			pstmt = con.prepareStatement(sql); 

			pstmt.setString(1, orderFg);
			pstmt.setInt(2, orderItem.getOrderNo()); 
			pstmt.setInt(3, orderItem.getSeq()); 
			pstmt.setInt(4, orderItem.getItemNo());
			pstmt.setInt(5, orderItem.getItemCnt());
			pstmt.setInt(6, orderItem.getItemPrice());
			pstmt.setFloat(7, orderItem.getServiceHour());
			pstmt.setString(8, orderItem.getInsertUserId());
			
			pstmt.execute(); 
			System.out.println(sql);
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
			sql = "update orderS set whNo=?, productSerialNo=?, subtotal=?, tax=?, totalAmt=?, note=?, updateDatetime=current_timestamp() where orderNo=?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, orderS.getWhNo()); 
			pstmt.setString(2, orderS.getProductSerialNo()); 
			pstmt.setInt(3, orderS.getSubtotal());
			pstmt.setInt(4, orderS.getTax());
			pstmt.setInt(5, orderS.getTotalAmt());
			pstmt.setString(6, orderS.getNote());
			pstmt.setInt(7, orderS.getOrderNo());
						
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
	public void deleteOrderS(int orderNo) throws Exception { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		try { 
			sql = "delete from orderS where orderNo = ?"; 
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
	 * 확정 
	 */
	public void finishOrderS(int orderNo, int whNo) throws Exception { 
		modifyOrderSStatus(orderNo, "20");
		modifyWhItemCnt(orderNo, whNo);
	} 	
	
	/*
	 * 완료 
	 
	public void finishOrderS(int orderNo) throws Exception { 
		modifyOrderSStatus(orderNo, "30");
	} 	*/	
	
	/*
	 * 상태변경 
	 */
	public void modifyOrderSStatus(int orderNo, String statusCd) throws Exception { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		
		try { 
			sql = "update orderS set statusCd=? where orderNo=?";
			
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

	/*
	 * 확정에 따른 Item 재고감소  
	 */
	public void modifyWhItemCnt(int orderNo, int whNo) throws Exception { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		
		try { 
			
			StringBuffer sqlBuf=new StringBuffer(); 

			sqlBuf.append("update whItem a "); 
			sqlBuf.append("inner join ");
			sqlBuf.append("(" );
			sqlBuf.append("	select * ");
			sqlBuf.append("	from orderItem ");
			sqlBuf.append(" where orderFg = 'S' and orderNo = ? ");
			sqlBuf.append(") aa ");
			sqlBuf.append("on a.itemNo = aa.itemNo ");
			sqlBuf.append("set a.itemCnt = a.itemCnt - aa.itemCnt ");
			sqlBuf.append("where whNo = ? ");
 
			pstmt = con.prepareStatement(sqlBuf.toString()); 
			pstmt.setInt(1, orderNo); 
			pstmt.setInt(2, whNo); 
			pstmt.executeUpdate();
			System.out.println(sqlBuf.toString());
			
		}catch(Exception e) { 
			throw e;
		}finally { 
			DBClose.close(con,pstmt); 
		} 
	} 			
}



