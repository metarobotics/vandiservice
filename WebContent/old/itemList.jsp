<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" %>
<%@ page import = "java.sql.*" %>                    <!-- JSP���� JDBC�� ��ü�� ����ϱ� ���� java.sql ��Ű���� import �Ѵ� -->
<%@ page import="board.*" %>
<%@ page import="java.util.*" %>


<jsp:useBean id="dao" class="board.DAO"/>

<%	
	int total = dao.count();
	ArrayList<Item> alist = dao.getMemberList();
	int size = alist.size();
	int size2 = size;
	
	final int ROWSIZE = 4;
	final int BLOCK = 5;
	int indent = 0;

	int pg = 1;
	
	if(request.getParameter("pg")!=null) {
		pg = Integer.parseInt(request.getParameter("pg"));
	}
	
	int end = (pg*ROWSIZE);
	
	int allPage = 0;

	int startPage = ((pg-1)/BLOCK*BLOCK)+1;
	int endPage = ((pg-1)/BLOCK*BLOCK)+BLOCK;
	
	allPage = (int)Math.ceil(total/(double)ROWSIZE);
	
	if(endPage > allPage) {
		endPage = allPage;
	}
	
	size2 -=end;
	if(size2 < 0) {
		end = size;
	}
	
%>

    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>������ ���</title>
<link rel="stylesheet" href="css/mr.css">
</head>
<body translate="no" >
<div class="table-title">
<h3>Data Table</h3>
</div>

<table class="table-fill">
<thead>
<tr>
	<th width="10%" class="text-center">ItemNo</th>
	<th width="40%" class="text-center">ǰ���</th>
	<th width="20%" class="text-center">�����</th>
	<th width="30%" class="text-center">����Ͻ�</th>
</tr>
</thead>
<tbody class="table-hover">
<%



Connection conn = null;                                        // null�� �ʱ�ȭ �Ѵ�.

PreparedStatement pstmt = null;

ResultSet rs = null;


try{

String url = "jdbc:mysql://dbmeta.cgnu1ig5rqls.ap-northeast-2.rds.amazonaws.com:3306/mr_warehouse";        // ����Ϸ��� �����ͺ��̽����� ������ URL ���

String id = "master";                                                    // ����� ����

String pw = "g514rMkm";                                                // ����� ������ �н�����



Class.forName("com.mysql.jdbc.Driver");                       // �����ͺ��̽��� �����ϱ� ���� DriverManager�� ����Ѵ�.

conn=DriverManager.getConnection(url,id,pw);              // DriverManager ��ü�κ��� Connection ��ü�� ���´�.

//out.println("����� ����Ǿ����ϴ�.");                            // Ŀ�ؼ��� ����� ����Ǹ� ����ȴ�.

}catch(Exception e){                                                    // ���ܰ� �߻��ϸ� ���� ��Ȳ�� ó���Ѵ�.

e.printStackTrace();

}




//----------------------------------
// insert
//----------------------------------
/*

try{
	
String sql = "insert into item (item_no, item_nm, insert_user_id, insert_datetime) values (?,?,?,?)";        // sql ����

pstmt = conn.prepareStatement(sql);                          // prepareStatement���� �ش� sql�� �̸� �������Ѵ�.

pstmt.setInt(1,1);

pstmt.setString(2,"ITEM1");

pstmt.setString(3,"master");

pstmt.setTimestamp(4, new Timestamp(System.currentTimeMillis()));    // ���� ��¥�� �ð�


pstmt.executeUpdate();                                        // ������ �����Ѵ�.



out.println("item ���̺� ���ο� ���ڵ带 �߰��߽��ϴ�.");        // ������ �޽��� ���



}catch(Exception e){                                                    // ���ܰ� �߻��ϸ� ���� ��Ȳ�� ó���Ѵ�.

e.printStackTrace();

out.println("item ���̺� ���ο� ���ڵ� �߰��� �����߽��ϴ�.");


}finally{                                                            // ������ ���� �Ǵ� ���п� ������� ����� �ڿ��� ���� �Ѵ�. (�����߿�)

if(pstmt != null) try{pstmt.close();}catch(SQLException sqle){}            // PreparedStatement ��ü ����

if(conn != null) try{conn.close();}catch(SQLException sqle){}            // Connection ����

}

*/


//----------------------------------
//select
//----------------------------------

try{
	
//String sql = "select * from item where id = ?";                        // sql ����

String sql = "select * from item ";                        // sql ����

pstmt = conn.prepareStatement(sql);                          // prepareStatement���� �ش� sql�� �̸� �������Ѵ�.

//pstmt.setString(1,"test");



rs = pstmt.executeQuery();                                        // ������ �����ϰ� ����� ResultSet ��ü�� ��´�.



while(rs.next()){                                                        // ����� �� �྿ ���ư��鼭 �����´�.



int itemNo = rs.getInt("item_no");

String itemNm = rs.getString("item_nm");

String regUserId = rs.getString("insert_user_id");

Timestamp regDt = rs.getTimestamp("insert_datetime");



%>

<tr align="center" class="row">

<td class="text-center"><%=itemNo%></td>

<td class="text-center"><%=itemNm%></td>

<td class="text-center"><%=regUserId%></td>

<td class="text-center"><%=regDt.toString()%></td>

</tr>

<%

}



}catch(Exception e){                                                    // ���ܰ� �߻��ϸ� ���� ��Ȳ�� ó���Ѵ�.

e.printStackTrace();

out.println("���̺� ȣ�⿡ �����߽��ϴ�.");

}finally{                                                            // ������ ���� �Ǵ� ���п� ������� ����� �ڿ��� ���� �Ѵ�.  (�����߿�)

if(rs != null) try{rs.close();}catch(SQLException sqle){}            // Resultset ��ü ����

if(pstmt != null) try{pstmt.close();}catch(SQLException sqle){}   // PreparedStatement ��ü ����

if(conn != null) try{conn.close();}catch(SQLException sqle){}   // Connection ����

}

%>

<TR><TD colspan="4"><font size="-1" color="#323232"></font></TD></TR>


</tbody>
</table>

</body>
</html>