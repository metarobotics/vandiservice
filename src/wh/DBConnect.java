package wh;
import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnect {
	public DBConnect() {}
	
	public Connection getConnection() {
//		String url = "jdbc:mysql://dbmeta.cgnu1ig5rqls.ap-northeast-2.rds.amazonaws.com:3306/mr_warehouse";
		String url = "jdbc:mysql://dbmeta.cgnu1ig5rqls.ap-northeast-2.rds.amazonaws.com:3306/mr_warehouse?useUnicode=true&characterEncoding=UTF-8";
//		 conn = DriverManager.getConnection("jdbc:mysql://localhost/project","root","root");에서
		 //conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bbs?useUnicode=true&characterEncoding=UTF-8","root","root"); 변경해서 mysql 
		String id = "master";
		String pass = "g514rMkm";
		
		Connection con = null;
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection(url,id,pass);
		}catch(Exception e) {
			System.out.println(e.toString());
		}
		
		return con;
	}
}
