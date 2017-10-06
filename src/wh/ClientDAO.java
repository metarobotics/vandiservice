package wh; 

import java.sql.Connection; 
import java.sql.PreparedStatement; 
import java.sql.ResultSet; 
import java.text.SimpleDateFormat; 
import java.util.ArrayList; 
import java.util.Date;

import common.DAO;
import common.DBClose; 

public class ClientDAO extends DAO { 
	
	public ClientDAO() {
		// TODO Auto-generated constructor stub
	}
	
	public int getNextClientNo() throws Exception {
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		int no = 0; 
		
		try { 
			sql = "select ifnull(max(clientNo),0)+1 from client"; 
			
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
	
	public int countClient() throws Exception { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		int cnt = 0; 
		
		try { 
			sql = "SELECT COUNT(0) FROM client";
			
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
	
	public Client getClientInfo(int clientNo) throws Exception { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		Client client = null; 
		
		try { 
			StringBuffer sqlBuf=new StringBuffer(); 

			sqlBuf.append("	select 	a.clientNo, ");
			sqlBuf.append("			a.clientNm, ");
			sqlBuf.append("			a.phoneNo, ");
			sqlBuf.append("			a.mobileNo, ");
			sqlBuf.append("			a.email, ");
			
			sqlBuf.append("			a.location, ");
			sqlBuf.append("			a.addr, ");
			sqlBuf.append("			a.note, ");
			sqlBuf.append("			a.insertUserId, ");
			sqlBuf.append("			a.insertDatetime, ");
			
			sqlBuf.append("			a.updateUserId, ");
			sqlBuf.append("			a.updateDatetime "); 
			sqlBuf.append("			, (select count(0) from product where clientNo = a.clientNo) as dealCnt	");
			sqlBuf.append("		  from client a ");
			sqlBuf.append("		 where clientNo = ?;");
			
			pstmt = con.prepareStatement(sqlBuf.toString()); 
			pstmt.setInt(1, clientNo); 
//System.out.println(pstmt.toString());
			rs = pstmt.executeQuery(); 
			
			if(rs.next()) { 
				client = new Client(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7), rs.getString(8), rs.getString(9), rs.getString(10), rs.getInt(13)); 
			} 
		}catch(Exception e) { 
			throw e;
		}finally { 
			DBClose.close(con,pstmt,rs); 
		} 
		
		return client; 
	} 

		
	// list page 
	public ArrayList<Client> getClientList() throws Exception { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		
		ArrayList<Client> alist = new ArrayList<Client>(); 
		
		try { 
			StringBuffer sqlBuf=new StringBuffer(); 

			sqlBuf.append("	select 	a.clientNo, ");
			sqlBuf.append("			a.clientNm, ");
			sqlBuf.append("			a.phoneNo, ");
			sqlBuf.append("			a.mobileNo, ");
			sqlBuf.append("			a.email, ");
			
			sqlBuf.append("			a.location, ");
			sqlBuf.append("			a.addr, ");
			sqlBuf.append("			a.note, ");
			sqlBuf.append("			a.insertUserId, ");
			sqlBuf.append("			a.insertDatetime, ");
			
			sqlBuf.append("			a.updateUserId, ");
			sqlBuf.append("			a.updateDatetime "); 
			sqlBuf.append("			, (select count(0) from product where clientNo = a.clientNo) as dealCnt	");
			sqlBuf.append("		from client a ");
			sqlBuf.append("		order by clientNm;");
			
			pstmt = con.prepareStatement(sqlBuf.toString()); 
//System.out.println(pstmt.toString());
			rs = pstmt.executeQuery(); 
			
			while(rs.next()) { 
				Client client = new Client(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7), rs.getString(8), rs.getString(9), rs.getString(10), rs.getInt(13)); 
				
				alist.add(client); 
			} 
		}catch(Exception e) { 
			throw e;
		}finally { 
			DBClose.close(con,pstmt,rs); 
		} return alist; 
	} 
	
	
	public void insertClient(Client client) throws Exception { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		
		try { 
			sql = "insert into client (clientNo, clientNm, phoneNo, mobileNo, email, location, addr, note, insertUserId, insertDatetime) VALUES (?,?,?,?,?,?,?,?,?, current_timestamp())"; 
			pstmt = con.prepareStatement(sql); 

			pstmt.setInt(1, client.getClientNo());
			pstmt.setString(2, client.getClientNm()); 
			pstmt.setString(3, client.getPhoneNo()); 
			pstmt.setString(4, client.getMobileNo());
			pstmt.setString(5, client.getEmail());
			pstmt.setString(6, client.getLocation());
			pstmt.setString(7, client.getAddr());
			pstmt.setString(8, client.getNote());
			pstmt.setString(9, client.getInsertUserId());
			
			pstmt.execute(); 
			//System.out.println(sql);
			
		}catch(Exception e) { 
			throw e;
		}finally { 
			DBClose.close(con,pstmt); 
		} 
	} 
	
	
	public void modifyClient(Client client) throws Exception { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		
		try { 
			sql = "update client set clientNm=?, phoneNo=?, mobileNo=?, email=?, location=?, addr=?, note=?, updateUserId=?, updateDatetime=current_timestamp() where clientNo=?";
			
			pstmt = con.prepareStatement(sql);

			pstmt.setString(1, client.getClientNm()); 
			pstmt.setString(2, client.getPhoneNo()); 
			pstmt.setString(3, client.getMobileNo());
			pstmt.setString(4, client.getEmail());
			pstmt.setString(5, client.getLocation());
			pstmt.setString(6, client.getAddr());
			pstmt.setString(7, client.getNote());
			pstmt.setString(8, client.getUpdateUserId());
			pstmt.setInt(9, client.getClientNo());
			
			pstmt.executeUpdate();
			//System.out.println(sql);
			
		}catch(Exception e) { 
			throw e;
		}finally { 
			DBClose.close(con,pstmt); 
		} 
	} 
		

	public void deleteClient(int clientNo) throws Exception { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		
		try { 
			sql = "delete from client where clientNo = ?";
			
			pstmt = con.prepareStatement(sql); 
			pstmt.setInt(1, clientNo); 
			pstmt.executeUpdate();
			
			//System.out.println(sql);
			
		}catch(Exception e) { 
			throw e;
		}finally { 
			DBClose.close(con,pstmt); 
		} 
	} 
	
}



