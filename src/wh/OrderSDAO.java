package wh; 

import java.sql.Connection; 
import java.sql.PreparedStatement; 
import java.sql.ResultSet; 
import java.text.SimpleDateFormat; 
import java.util.ArrayList; 
import java.util.Date; 

public class OrderSDAO extends DAO { 
	
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
	
	public int countOrderS() throws Exception { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		int cnt = 0; 
		
		try { 
			sql = "SELECT COUNT(0) FROM orderS"; 
			
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
	
	public OrderS getOrderSInfo(int orderNo) throws Exception { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		OrderS orderS = null; 
		
		try { 
			StringBuffer sqlBuf=new StringBuffer(); 
			
			sqlBuf.append("		select  a.orderNo, ");
			sqlBuf.append("				a.orderDt, ");
			sqlBuf.append("				a.whNo, ");
			sqlBuf.append("				a.productSerialNo, ");
			sqlBuf.append("				a.statusCd, ");
			sqlBuf.append("				a.subtotal, ");
			sqlBuf.append("				a.tax, ");
			sqlBuf.append("				a.totalAmt, ");
			sqlBuf.append("				a.depositPrgAmt, ");
			sqlBuf.append("				a.creditPrgAmt, ");//10
			sqlBuf.append("				a.depositAmt, ");
			sqlBuf.append("				a.creditAmt, ");
			sqlBuf.append("				a.receiptAmt, ");
			sqlBuf.append("				a.note, "); //14
			
			sqlBuf.append("				a.insertUserId, ");
			sqlBuf.append("				a.insertDatetime, ");
			sqlBuf.append("				a.updateUserId, ");
			sqlBuf.append("				a.updateDatetime,  "); //18
			
			sqlBuf.append("				b.whNm centerNm, ");
			sqlBuf.append("				d.clientNo clientNo, ");
			sqlBuf.append("				d.clientNm clientNm ");			
			//sqlBuf.append("      		" + incoding(", case a.statusCd when '10' then '주문' when '20' then '확정' else '' end statusNm "));
			sqlBuf.append("      		, case a.statusCd when '10' then '주문' when '20' then '확정' else '' end statusNm "); //22
			sqlBuf.append("        from orderS a ");
			sqlBuf.append("        left join wh b on a.whNo = b.whNo");
			sqlBuf.append("        left join productEach c on a.productSerialNo = c.serialNo");
			sqlBuf.append("        left join client d on c.clientNo = d.clientNo");
			sqlBuf.append("       where a.orderNo = ?; ");
			
			pstmt = con.prepareStatement(sqlBuf.toString()); 
			pstmt.setInt(1, orderNo); 
			rs = pstmt.executeQuery(); 
			//System.out.println(sqlBuf.toString());
			
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

			sqlBuf.append("		select  a.orderNo, ");
			sqlBuf.append("				a.orderDt, ");
			sqlBuf.append("				a.whNo, ");
			sqlBuf.append("				a.productSerialNo, ");
			sqlBuf.append("				a.statusCd, ");
			sqlBuf.append("				a.subtotal, ");
			sqlBuf.append("				a.tax, ");
			sqlBuf.append("				a.totalAmt, ");
			sqlBuf.append("				a.depositPrgAmt, ");
			sqlBuf.append("				a.creditPrgAmt, ");
			sqlBuf.append("				a.depositAmt, ");
			sqlBuf.append("				a.creditAmt, ");
			sqlBuf.append("				a.receiptAmt, ");
			sqlBuf.append("				a.note, ");
			sqlBuf.append("				a.insertUserId, ");
			sqlBuf.append("				a.insertDatetime, ");
			sqlBuf.append("				a.updateUserId, ");
			sqlBuf.append("				a.updateDatetime,  ");
			sqlBuf.append("				b.whNm centerNm, ");
			sqlBuf.append("				d.clientNo clientNo, ");
			sqlBuf.append("				d.clientNm clientNm ");			
//			sqlBuf.append("      		" + incoding(", case a.statusCd when '10' then '주문' when '20' then '확정' else '' end statusNm "));
			sqlBuf.append("      		, case a.statusCd when '10' then '주문' when '20' then '확정' else '' end statusNm ");
			sqlBuf.append("        from orderS a ");
			sqlBuf.append("        left join wh b on a.whNo = b.whNo");
			sqlBuf.append("        left join productEach c on a.productSerialNo = c.serialNo");
			sqlBuf.append("        left join client d on c.clientNo = d.clientNo");
			sqlBuf.append("       order by orderNo desc;");
 
			pstmt = con.prepareStatement(sqlBuf.toString()); 
			rs = pstmt.executeQuery();
			//System.out.println(sqlBuf.toString());
			
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

			sqlBuf.append("		select  a.orderNo, ");
			sqlBuf.append("				a.orderDt, ");
			sqlBuf.append("				a.whNo, ");
			sqlBuf.append("				a.productSerialNo, ");
			sqlBuf.append("				a.statusCd, ");
			sqlBuf.append("				a.subtotal, ");
			sqlBuf.append("				a.tax, ");
			sqlBuf.append("				a.totalAmt, ");
			sqlBuf.append("				a.depositPrgAmt, ");
			sqlBuf.append("				a.creditPrgAmt, ");
			sqlBuf.append("				a.depositAmt, ");
			sqlBuf.append("				a.creditAmt, ");
			sqlBuf.append("				a.receiptAmt, ");
			sqlBuf.append("				a.note, ");
			sqlBuf.append("				a.insertUserId, ");
			sqlBuf.append("				a.insertDatetime, ");
			sqlBuf.append("				a.updateUserId, ");
			sqlBuf.append("				a.updateDatetime,  ");
			sqlBuf.append("				b.whNm centerNm, ");
			sqlBuf.append("				d.clientNo clientNo, ");
			sqlBuf.append("				d.clientNm clientNm ");			
			//sqlBuf.append("      		" + incoding(", case a.statusCd when '10' then '주문' when '20' then '확정' else '' end statusNm "));
			sqlBuf.append("      		, case a.statusCd when '10' then '주문' when '20' then '확정' else '' end statusNm ");
			sqlBuf.append("        from orderS a ");
			sqlBuf.append("        left join wh b on a.whNo = b.whNo");
			sqlBuf.append("        left join productEach c on a.productSerialNo = c.serialNo");
			sqlBuf.append("        left join client d on c.clientNo = d.clientNo");
			sqlBuf.append("       where a.whNo = ?");
			sqlBuf.append("        order by orderNo desc;");
 
			pstmt = con.prepareStatement(sqlBuf.toString()); 
			pstmt.setInt(1, whNo); 
			rs = pstmt.executeQuery();
			//System.out.println(sqlBuf.toString());
			
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
	
	public ArrayList<OrderSItem> getOrderSItemList(int orderNo) throws Exception { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		ArrayList<OrderSItem> alist = new ArrayList<OrderSItem>(); 
		
		try { 
			StringBuffer sqlBuf=new StringBuffer();
			
			sqlBuf.append("		select  a.orderNo, ");
			sqlBuf.append("				a.seq, ");
			sqlBuf.append("				a.itemNo, ");
			sqlBuf.append("				a.itemCnt, ");
			
			sqlBuf.append("				a.itemPrice, ");
			sqlBuf.append("				a.serviceHour, ");
			
			sqlBuf.append("				a.insertUserId, "); //7
			sqlBuf.append("				a.insertDatetime, ");
			sqlBuf.append("				a.updateUserId, ");
			sqlBuf.append("				a.updateDatetime  ");
			sqlBuf.append("        from orderSItem a ");
			sqlBuf.append("       where orderNo = ? ");
			sqlBuf.append("       order by seq;");
 			
			pstmt = con.prepareStatement(sqlBuf.toString()); 
			pstmt.setInt(1, orderNo);
			rs = pstmt.executeQuery();
			//System.out.println(sqlBuf.toString());
			
			while(rs.next()) { 
				
				//System.out.println("[OrderSDAO ServiceHour] " + rs.getFloat(7));
				OrderSItem orderSItem = new OrderSItem(rs.getInt(1), rs.getInt(2), rs.getInt(3), rs.getInt(4), rs.getInt(5), rs.getFloat(6), rs.getString(7)); 
				
				alist.add(orderSItem); 
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
			//pstmt.setString(2, incoding(orderS.getOrderDt())); 
			pstmt.setString(2, orderS.getOrderDt());
			pstmt.setInt(3, orderS.getWhNo()); 
			pstmt.setString(4, orderS.getProductSerialNo());
			pstmt.setString(5, "10"); //statusCd
			pstmt.setInt(6, orderS.getSubtotal());
			pstmt.setInt(7, orderS.getTax());
			pstmt.setInt(8, orderS.getTotalAmt());
			pstmt.setString(9, orderS.getNote());
			pstmt.setString(10, orderS.getInsertUserId());
			
			pstmt.execute(); 
			//System.out.println(sql);
			
		}catch(Exception e) { 
			throw e;
		}finally { 
			DBClose.close(con,pstmt); 
		} 
	} 
	
	public void insertOrderSItem(OrderSItem orderSItem) throws Exception { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		
		try { 
			sql = "insert into orderSItem (orderNo, seq, itemNo, itemCnt, itemPrice, serviceHour, insertUserId, insertDatetime) VALUES (?,?,?,?,?,?,?, current_timestamp())"; 

			pstmt = con.prepareStatement(sql); 

			pstmt.setInt(1, orderSItem.getOrderNo()); 
			pstmt.setInt(2, orderSItem.getSeq()); 
			pstmt.setInt(3, orderSItem.getItemNo());
			pstmt.setInt(4, orderSItem.getItemCnt());
			pstmt.setFloat(5, orderSItem.getItemPrice());
			pstmt.setFloat(6, orderSItem.getServiceHour());
			pstmt.setString(7, orderSItem.getInsertUserId());
			
//System.out.println(pstmt);
			pstmt.execute(); 
			//System.out.println(sql);
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
			//System.out.println("note = " + orderS.getNote());			
			//System.out.println("note = " + incoding(orderS.getNote()));			
			pstmt.setInt(7, orderS.getOrderNo());
						
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
	public void deleteOrderS(int orderNo) throws Exception { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		
		try { 
			sql = "delete from orderS where orderNo = ?"; 
			
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
	
	
	public void deleteOrderSItem(int orderNo) throws Exception { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		
		try { 
			sql = "delete from orderSItem where orderNo = ?"; 
			
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
			//System.out.println(sql);
			
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
			sqlBuf.append(" inner join ");
			sqlBuf.append("      (" );
			sqlBuf.append("	      select * ");
			sqlBuf.append("	        from orderSItem ");
			sqlBuf.append("        where orderNo = ? ");
			sqlBuf.append("      ) aa ");
			sqlBuf.append("    on a.itemNo = aa.itemNo ");
			sqlBuf.append("   set a.itemCnt = a.itemCnt - aa.itemCnt ");
			sqlBuf.append(" where whNo = ? ");
 
			pstmt = con.prepareStatement(sqlBuf.toString()); 
			pstmt.setInt(1, orderNo); 
			pstmt.setInt(2, whNo); 
			pstmt.executeUpdate();
			//System.out.println(sqlBuf.toString());
			
		}catch(Exception e) { 
			throw e;
		}finally { 
			DBClose.close(con,pstmt); 
		} 
	} 			
}



