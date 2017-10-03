package wh; 

import java.sql.Connection; 
import java.sql.PreparedStatement; 
import java.sql.ResultSet; 
import java.text.SimpleDateFormat; 
import java.util.ArrayList; 
import java.util.Date; 

public class DAO { 
	
	DBConnect dbconnect = null; 
	String sql=""; 
	
	public DAO() { 
		dbconnect = new DBConnect(); 
	} 

}



