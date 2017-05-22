package wh; 

import java.sql.Connection; 
import java.sql.PreparedStatement; 
import java.sql.ResultSet; 
import java.text.SimpleDateFormat; 
import java.util.ArrayList; 
import java.util.Date; 

public class ClientDAO extends DAO { 
	
	public ClientDAO() {
		// TODO Auto-generated constructor stub
	}
	
	public int getNextClientNo() {
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
			
		}finally { 
			DBClose.close(con,pstmt,rs); 
		} 
		return no; 
	}
	
	public int countClient() { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		int cnt = 0; 
		
		try { 
			sql = "SELECT COUNT(*) FROM client"; 
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
	
	public String incoding(String data) { 
		try { 
			//data = new String(data.getBytes("8859_1"), "euc-kr");
			//data = new String(data.getBytes("KSC5601"), "8859_1");
			
//			sql = new String(",  statusNm ".getBytes("8859_1"), "euc-kr");
//			sql = new String(",  statusNm ".getBytes("KSC5601"), "8859_1");
			
		}catch (Exception e){ } 
		return data; 
	} 
	
	
	public Client getClientInfo(int clientNo) { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		Client client = null; 
		
		try { 
			StringBuffer sqlBuf=new StringBuffer(); 

			sqlBuf.append("		select a.* ");
			sqlBuf.append("			, (select count(0) from orderS where clientNo = a.clientNo) as dealCnt");
			sqlBuf.append("		from client a ");
			sqlBuf.append("		 where clientNo = ?;");
			
			pstmt = con.prepareStatement(sqlBuf.toString()); 
			pstmt.setInt(1, clientNo); 
			rs = pstmt.executeQuery(); 
			
			if(rs.next()) { 
				client = new Client(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7), rs.getString(8), rs.getString(9), rs.getString(10), rs.getInt(13)); 
			} 
		}catch(Exception e) { 
			
		}finally { 
			DBClose.close(con,pstmt,rs); 
		} 
		
		return client; 
	} 
	
		
	// list page 
	public ArrayList<Client> getClientList() { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		
		ArrayList<Client> alist = new ArrayList<Client>(); 
		
		try { 
			StringBuffer sqlBuf=new StringBuffer(); 

			sqlBuf.append("		select a.* ");
			sqlBuf.append("			, (select count(0) from orderS where clientNo = a.clientNo) as dealCnt");
			sqlBuf.append("		from client a ");
			sqlBuf.append("		order by clientNm;");
			
			pstmt = con.prepareStatement(sqlBuf.toString()); 
			rs = pstmt.executeQuery(); 
			while(rs.next()) { 
				Client client = new Client(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7), rs.getString(8), rs.getString(9), rs.getString(10), rs.getInt(13)); 
				
				alist.add(client); 
			} 
		}catch(Exception e) { 
			
		}finally { 
			DBClose.close(con,pstmt,rs); 
		} return alist; 
	} 
	
	
	public void insertClient(Client client) { 
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
		}catch(Exception e) { 
			
		}finally { 
			DBClose.close(con,pstmt); 
		} 
	} 
	
	
	public void modifyClient(Client client) { 
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
			
		}catch(Exception e) { 
			
		}finally { 
			DBClose.close(con,pstmt); 
		} 
	} 
		

	public void deleteClient(int clientNo) { 
		Connection con = dbconnect.getConnection(); 
		PreparedStatement pstmt = null; 
		try { 
			sql = "delete from client where clientNo = ?"; 
			pstmt = con.prepareStatement(sql); 
			pstmt.setInt(1, clientNo); 
			pstmt.executeUpdate();
		}catch(Exception e) { 
		
		}finally { 
			DBClose.close(con,pstmt); 
		} 
	} 
	
}



