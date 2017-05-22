<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" %>
<%@ page import = "java.sql.*" %>                    <!-- JSP에서 JDBC의 객체를 사용하기 위해 java.sql 패키지를 import 한다 -->
<%@ page import="wh.*" %>
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
<title>아이템 목록</title>
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
	<th width="40%" class="text-center">품목명</th>
	<th width="20%" class="text-center">등록자</th>
	<th width="30%" class="text-center">등록일시</th>
</tr>
</thead>
<tbody class="table-hover">
<%



Connection conn = null;                                        // null로 초기화 한다.

PreparedStatement pstmt = null;

ResultSet rs = null;


try{

String url = "jdbc:mysql://dbmeta.cgnu1ig5rqls.ap-northeast-2.rds.amazonaws.com:3306/mr_warehouse";        // 사용하려는 데이터베이스명을 포함한 URL 기술

String id = "master";                                                    // 사용자 계정

String pw = "g514rMkm";                                                // 사용자 계정의 패스워드



Class.forName("com.mysql.jdbc.Driver");                       // 데이터베이스와 연동하기 위해 DriverManager에 등록한다.

conn=DriverManager.getConnection(url,id,pw);              // DriverManager 객체로부터 Connection 객체를 얻어온다.

//out.println("제대로 연결되었습니다.");                            // 커넥션이 제대로 연결되면 수행된다.

}catch(Exception e){                                                    // 예외가 발생하면 예외 상황을 처리한다.

e.printStackTrace();

}




//----------------------------------
// insert
//----------------------------------
/*

try{
	
String sql = "insert into item (item_no, item_nm, insert_user_id, insert_datetime) values (?,?,?,?)";        // sql 쿼리

pstmt = conn.prepareStatement(sql);                          // prepareStatement에서 해당 sql을 미리 컴파일한다.

pstmt.setInt(1,1);

pstmt.setString(2,"ITEM1");

pstmt.setString(3,"master");

pstmt.setTimestamp(4, new Timestamp(System.currentTimeMillis()));    // 현재 날짜와 시간


pstmt.executeUpdate();                                        // 쿼리를 실행한다.



out.println("item 테이블에 새로운 레코드를 추가했습니다.");        // 성공시 메시지 출력



}catch(Exception e){                                                    // 예외가 발생하면 예외 상황을 처리한다.

e.printStackTrace();

out.println("item 테이블에 새로운 레코드 추가에 실패했습니다.");


}finally{                                                            // 쿼리가 성공 또는 실패에 상관없이 사용한 자원을 해제 한다. (순서중요)

if(pstmt != null) try{pstmt.close();}catch(SQLException sqle){}            // PreparedStatement 객체 해제

if(conn != null) try{conn.close();}catch(SQLException sqle){}            // Connection 해제

}

*/


//----------------------------------
//select
//----------------------------------

try{
	
//String sql = "select * from item where id = ?";                        // sql 쿼리

String sql = "select * from item ";                        // sql 쿼리

pstmt = conn.prepareStatement(sql);                          // prepareStatement에서 해당 sql을 미리 컴파일한다.

//pstmt.setString(1,"test");



rs = pstmt.executeQuery();                                        // 쿼리를 실행하고 결과를 ResultSet 객체에 담는다.



while(rs.next()){                                                        // 결과를 한 행씩 돌아가면서 가져온다.



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



}catch(Exception e){                                                    // 예외가 발생하면 예외 상황을 처리한다.

e.printStackTrace();

out.println("테이블 호출에 실패했습니다.");

}finally{                                                            // 쿼리가 성공 또는 실패에 상관없이 사용한 자원을 해제 한다.  (순서중요)

if(rs != null) try{rs.close();}catch(SQLException sqle){}            // Resultset 객체 해제

if(pstmt != null) try{pstmt.close();}catch(SQLException sqle){}   // PreparedStatement 객체 해제

if(conn != null) try{conn.close();}catch(SQLException sqle){}   // Connection 해제

}

%>

<TR><TD colspan="4"><font size="-1" color="#323232"></font></TD></TR>


</tbody>
</table>

</body>
</html>