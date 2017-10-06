package common; 

import java.sql.Connection; 
import java.sql.PreparedStatement; 
import java.sql.ResultSet; 
import java.text.SimpleDateFormat; 
import java.util.ArrayList; 
import java.util.Date; 

public class DAO { 
	
	public DBConnect dbconnect = null; 
	public String sql=""; 
	
	public DAO() { 
		dbconnect = new DBConnect(); 
	} 

}



