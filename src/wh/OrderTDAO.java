package wh; 

import java.sql.Connection; 
import java.sql.PreparedStatement; 
import java.sql.ResultSet; 
import java.text.SimpleDateFormat; 
import java.util.ArrayList; 
import java.util.Date;

import common.DAO;
import common.DBClose; 

public class OrderTDAO extends DAO { 
	
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
	public int countOrderT() throws Exception  { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		int cnt = 0; 
		
		try { 
			sql = "SELECT COUNT(0) FROM orderT"; 
			
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

	
	public OrderT getOrderTInfo(int orderNo) throws Exception  { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		OrderT orderT = null; 
		
		try { 
			StringBuffer sqlBuf=new StringBuffer(); 

			sqlBuf.append("		select orderNo, orderDt, srcWhNo, destWhNo, ");
			sqlBuf.append("		       statusCd, subtotal, tax, totalAmt, note, ");
			sqlBuf.append("		       insertUserId, updateUserId ");
			sqlBuf.append("		from orderT a ");
			sqlBuf.append("		 where orderNo = ?;");
			
			pstmt = con.prepareStatement(sqlBuf.toString()); 
			pstmt.setInt(1, orderNo); 
			rs = pstmt.executeQuery(); 

			if(rs.next()) { 
				orderT = new OrderT(rs.getInt(1), rs.getString(2), rs.getInt(3), rs.getInt(4), rs.getString(5), rs.getInt(6), rs.getInt(7), rs.getInt(8), rs.getString(9), rs.getString(10), rs.getString(11)); 
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
			
			sqlBuf.append("		select  a.orderNo, a.orderDt, a.srcWhNo, a.destWhNo, "); 
			sqlBuf.append("		        a.statusCd, a.subtotal, a.tax, a.totalAmt, a.insertUserId, a.note "); 
			sqlBuf.append("	   	      , b.whNm srcWhNm, c.whNm destWhNm "); 
			//sqlBuf.append("      		" + incoding(", case a.statusCd when '10' then '주문' when '20' then '접수' when '21' then '백오더' when '30' then '배송중' when '40' then '배송완료' end statusNm "));
			sqlBuf.append("           , case a.statusCd when '10' then '주문' when '20' then '접수' when '21' then '백오더' when '30' then '배송중' when '40' then '배송완료' end statusNm ");
			sqlBuf.append("       from orderT a ");
			sqlBuf.append("       left join wh b on a.srcWhNo = b.whNo");
			sqlBuf.append("       left join wh c on a.destWhNo = c.whNo");
			sqlBuf.append("      order by orderNo desc;");
 
			pstmt = con.prepareStatement(sqlBuf.toString()); 
			rs = pstmt.executeQuery(); 
			//System.out.println(sqlBuf.toString());
			
			while(rs.next()) { 
				OrderT orderT = new OrderT(rs.getInt(1), rs.getString(2), rs.getInt(3), rs.getInt(4), rs.getString(5), rs.getInt(6), rs.getInt(7), rs.getInt(8), rs.getString(9), rs.getString(10), rs.getString(11), rs.getString(12), rs.getString(13)); 
				
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
			
			sqlBuf.append("		select  a.orderNo, a.orderDt, a.srcWhNo, a.destWhNo, "); 
			sqlBuf.append("		        a.statusCd, a.subtotal, a.tax, a.totalAmt, a.insertUserId, a.note "); 
			sqlBuf.append("	   	      , b.whNm srcWhNm, c.whNm destWhNm "); 
//			sqlBuf.append("      		" + incoding(", case a.statusCd when '10' then '주문' when '20' then '접수' when '21' then '백오더' when '30' then '배송중' when '40' then '배송완료' end statusNm "));
			sqlBuf.append("      	  , case a.statusCd when '10' then '주문' when '20' then '접수' when '21' then '백오더' when '30' then '배송중' when '40' then '배송완료' end statusNm ");
			sqlBuf.append("       from orderT a ");
			sqlBuf.append("       left join wh b on a.srcWhNo = b.whNo");
			sqlBuf.append("       left join wh c on a.destWhNo = c.whNo");
			sqlBuf.append("      where a.destWhNo = ?");
			sqlBuf.append("      order by orderNo desc;");
 
			pstmt = con.prepareStatement(sqlBuf.toString()); 
			pstmt.setInt(1, whNo); 
			rs = pstmt.executeQuery(); 
			//System.out.println(sqlBuf.toString());
			
			while(rs.next()) { 
				OrderT orderT = new OrderT(rs.getInt(1), rs.getString(2), rs.getInt(3), rs.getInt(4), rs.getString(5), rs.getInt(6), rs.getInt(7), rs.getInt(8), rs.getString(9), rs.getString(10), rs.getString(11), rs.getString(12), rs.getString(13)); 
				
				alist.add(orderT); 
			} 
		}catch(Exception e) { 
			throw e;
		}finally { 
			DBClose.close(con,pstmt,rs); 
		} 
		
		return alist; 
	} 	
	
	public ArrayList<OrderTItem> getOrderTItemList(int orderNo) throws Exception  { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		ArrayList<OrderTItem> alist = new ArrayList<OrderTItem>(); 
		
		try { 
			StringBuffer sqlBuf=new StringBuffer(); 

			sqlBuf.append("		select  a.orderNo, ");
			sqlBuf.append("				a.seq, ");
			sqlBuf.append("				a.itemNo, ");
			sqlBuf.append("				a.itemCnt, ");
			sqlBuf.append("				a.itemPrice, ");
			sqlBuf.append("				a.insertUserId, ");
			sqlBuf.append("				a.insertDatetime, ");
			sqlBuf.append("				a.updateUserId, ");
			sqlBuf.append("				a.updateDatetime  ");			
			sqlBuf.append("        from orderTItem a ");
			sqlBuf.append("        where orderNo = ? ");
			sqlBuf.append("        order by seq;");
 
			
			pstmt = con.prepareStatement(sqlBuf.toString()); 
			pstmt.setInt(1, orderNo);
			rs = pstmt.executeQuery();
//System.out.println(pstmt.toString());
			
			while(rs.next()) { 
				
				OrderTItem orderTItem = new OrderTItem(rs.getInt(1), rs.getInt(2), rs.getInt(3), rs.getInt(4), rs.getInt(5), rs.getString(6)); 

				alist.add(orderTItem); 
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
			
			sql = "insert into orderT (orderNo, orderDt, srcWhNo, destWhNo, statusCd, subtotal, tax, totalAmt, note, insertUserId, insertDatetime) VALUES (?,?,?,?,?,?,?,?,?,?, current_timestamp())";
			
			pstmt = con.prepareStatement(sql); 

			pstmt.setInt(1, orderT.getOrderNo());
			//pstmt.setString(2, incoding(orderT.getOrderDt())); 
			pstmt.setString(2, orderT.getOrderDt());
			pstmt.setInt(3, orderT.getSrcWhNo()); 
			pstmt.setInt(4, orderT.getDestWhNo());
			pstmt.setString(5, "10"); //statusCd
			pstmt.setInt(6, orderT.getSubtotal());
			pstmt.setInt(7, orderT.getTax());
			pstmt.setInt(8, orderT.getTotalAmt());
			pstmt.setString(9, orderT.getNote());
			pstmt.setString(10, orderT.getInsertUserId());
			
			pstmt.execute(); 
			//System.out.println(sql);
			
		}catch(Exception e) { 
			throw e;
		}finally { 
			DBClose.close(con,pstmt); 
		} 
	} 
	
	
	public void insertOrderTItem(OrderTItem orderTItem) throws Exception  { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		
		try { 
			sql = "insert into orderTItem (orderNo, seq, itemNo, itemCnt, itemPrice, insertUserId, insertDatetime) VALUES (?,?,?,?,?,?, current_timestamp())"; 
			
			pstmt = con.prepareStatement(sql); 

			pstmt.setInt(1, orderTItem.getOrderNo()); 
			pstmt.setInt(2, orderTItem.getSeq()); 
			pstmt.setInt(3, orderTItem.getItemNo());
			pstmt.setInt(4, orderTItem.getItemCnt());
			pstmt.setInt(5, orderTItem.getItemPrice());
			pstmt.setString(6, orderTItem.getInsertUserId());
			
			pstmt.execute(); 
			//System.out.println(sql);
			
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
			sql = "update orderT set orderDt=?, srcWhNo=?, destWhNo=?, subtotal=?, tax=?, totalAmt=?, note=?, updateDatetime=current_timestamp() where orderNo=?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, orderT.getOrderDt());
			pstmt.setInt(2, orderT.getSrcWhNo()); 
			pstmt.setInt(3, orderT.getDestWhNo());
			pstmt.setInt(4, orderT.getSubtotal()); 
			pstmt.setInt(5, orderT.getTax()); 
			pstmt.setInt(6, orderT.getTotalAmt()); 
			pstmt.setString(7, orderT.getNote());
			pstmt.setInt(8, orderT.getOrderNo());
						
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
	public void deleteOrderT(int orderNo) throws Exception  { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		
		try { 
			
			sql = "delete from orderT where orderNo = ?"; 
			
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
	
	
	public void deleteOrderTItem(int orderNo) throws Exception  { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		
		try { 
			sql = "delete from orderTItem where orderNo = ?"; 
			
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
	 * 접수 
	 */
	public void acceptOrderT(int orderNo) throws Exception { 
		modifyOrderTStatus(orderNo, "20");
	} 
	
	/*
	 * 배송중 
	 */
	public void shipOrderT(int orderNo) throws Exception { 
		modifyOrderTStatus(orderNo, "30");
	} 
	
	/*
	 * 완료 
	 */
	public void finishOrderT(int orderNo) throws Exception { 
		modifyOrderTStatus(orderNo, "40");
	} 
	
	/*
	 * 상태변경
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
			//System.out.println(sql);
			
		}catch(Exception e) { 
			throw e;
		}finally { 
			DBClose.close(con,pstmt); 
		} 
	} 

	
	// 출고지 자재갯수 감소 (배송완료시) 
	public void minusWhItemCnt(int orderNo, int srcWhNo, String updateUserId) throws Exception {

		ArrayList<OrderTItem> itemList = this.getOrderTItemList(orderNo);
		int size = itemList.size();
		
		OrderTItem orderTItem;
		WhItem whItem;
		WhItemDAO whItemDao = new WhItemDAO();
		
 		for(int i = 0; i < size; i++) {
 			
 			orderTItem = itemList.get(i);
 			
 			if(orderTItem.getItemCnt() == 0)
 				continue;
 			
 			whItem = new WhItem(srcWhNo, orderTItem.getItemNo(), orderTItem.getItemCnt()*(-1), updateUserId, updateUserId);
 			whItemDao.addWhItemCnt(whItem);
 		}
	}

	
	
}



