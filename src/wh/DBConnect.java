package wh;
import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnect {
	public DBConnect() {}
	
	public Connection getConnection() {
		String url = "jdbc:mysql://dbmeta.cgnu1ig5rqls.ap-northeast-2.rds.amazonaws.com:3306/mr_warehouse";
		String id = "master";
		String pass = "g514rMkm";
		
		Connection con = null;
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection(url,id,pass);
		}catch(Exception e) {
			System.out.println(e);
		}
		
		return con;
	}
}
