<%@ page language="java" contentType="text/html;charset=EUC-KR" %>
<% request.setCharacterEncoding("EUC-KR"); %>
<%@ page import = "java.sql.*" %>                    <!-- JSP���� JDBC�� ��ü�� ����ϱ� ���� java.sql ��Ű���� import �Ѵ� -->
<%@ page import="java.util.*" %>
<%@ page import="wh.*" %>
<jsp:useBean id="mrDao" class="wh.MrDAO"/>
<jsp:include page = "/loginChk.jsp"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/mr.css">
<script type="text/javascript" src="../js/mr.js"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.7.1.min.js"></script>

<%
	String mode = request.getParameter("mode"); // C/R
	String pg = ""; //request.getParameter("pg");
	
	String writeMode;
	if(mode.equals("C"))
		writeMode = "C";
	else // R
		writeMode = "U";
	
	//out.print("."+mode+".");
	
	Product product = null;
	ArrayList<ProductItem> productItemList = null;
	int productItemSize = 0;
	
	if(mode.equals("R"))
	{
		int productNo = 1; //Integer.parseInt(request.getParameter("productNo"));
	
		product = mrDao.getProductInfo(productNo);
		productItemList = mrDao.getProductItemList(productNo);
		
		productItemSize = productItemList.size();
	}

%>

<script type="text/javascript">

	var mode = '<%= mode %>';
	//alert(mode);
/*
	function chkValid() {
		
		//alert(document.getElementById("productNo").value);
		
		if(isNull(document.getElementById("productNm")))
		{
			alert('������ �Է��ϼ���.');
			return false;
		}
		
		return true;
	}

	function confirmDelete() {
		
		if(confirm('�����Ͻðڽ��ϱ�?'))
		{
			<% if(mode.equals("R")) { %>   
				//moveTo('productDelete.jsp?productNo=<%= product.getProductNo() %>');	
			<% } else { %>
			<% } %>   		
		}
	}
	*/
</script>
</head>

<body>
<center>

	<% if(mode.equals("R")) { %>   
   		<div class="table-title"><h1>Product ��</h1></div>
	<% } else { %>
   		<div class="table-title"><h1>Product ���</h1></div>
	<% } %>   		
   	
 		<form name="form1" method="post" action="productWrite_action.jsp?mode=<%= writeMode %>" onsubmit="return chkValid();">


		<table border=1 class='table-fill'>
    		<tr>
				<td width="30%" class="cell-hd">productNo</td>
				<td width="70%" class="cell-l">
	<% if(mode.equals("C")) { %>   
					<input type=text size=10 disabled value='' >
					<input type=hidden name=productNo id=productNo value='' >
	<% } else { %>
					<input type=text size=10 disabled value='<%= MrUtil.getClientNoStr(product.getProductNo()) %>' >
					<input type=hidden name=productNo id=productNo value='<%= product.getProductNo() %>' >
	<% } %>   		
				</td>
			</tr>
    		<tr>
				<td width="30%" class="cell-hd">productId</td>
				<td width="70%" class="cell-l">
	<% if(mode.equals("C")) { %>   
					<input type=text name=productId id=productId size=20 value='' >
	<% } else { %>
					<input type=text name=productId id=productId size=20 value='<%= product.getProductId() %>' >
	<% } %>   		
				</td>
			</tr>
    		<tr>
				<td width="30%" class="cell-hd">productNmKor</td>
				<td width="70%" class="cell-l">
	<% if(mode.equals("C")) { %>   
					<input type=text name=productNmKor id=productNmKor size=20 value='' >
	<% } else { %>
					<input type=text name=productNmKor id=productNmKor size=20 value='<%= product.getProductNmKor() %>' >
	<% } %>   		
				</td>
			</tr>
    		<tr>
				<td width="30%" class="cell-hd">productNmEng</td>
				<td width="70%" class="cell-l">
	<% if(mode.equals("C")) { %>   
					<input type=text name=productNmEng id=productNmEng size=20 value='' >
	<% } else { %>
					<input type=text name=productNmEng id=productNmEng size=20 value='<%= product.getProductNmEng() %>' >
	<% } %>   		
				</td>
			</tr>
    		<tr>
				<td width="30%" class="cell-hd">��ǰ�����</td>
				<td width="70%" class="cell-l">
	<% if(mode.equals("C")) { %>   
					<input type=text name=createDt id=createDt size=20 value='' >
	<% } else { %>
					<input type=text name=createDt id=createDt size=20 value='<%= product.getCreateDt() %>' >
	<% } %>   		
				</td>
			</tr>
   
			
			
			
			<!-- 
    		<tr>
				<td width="30%" class="cell-hd">�����</td>
				<td width="70%" class="cell-l">
	<% if(mode.equals("C")) { %>   
					<input type=text name=insertUserId id=insertUserId size=20 disabled value='<%= (String)session.getAttribute("userId") %>' >
	<% } else { %>
					<input type=text name=insertUserId id=insertUserId size=20 disabled value='<%= product.getInsertUserId() %>' >
	<% } %>   		
				</td>
			</tr>
    		<tr>
				<td width="30%" class="cell-hd">����Ͻ�</td>
				<td width="70%" class="cell-l">
	<% if(mode.equals("C")) { %>   
					<input type=text name=insertDatetime id=insertDatetime size=20 disabled value='javascript:today();' >
	<% } else { %>
					<input type=text name=insertDatetime id=insertDatetime size=20 disabled value='<%= product.getInsertDatetime() %>' >
	<% } %>   		
				</td>
			</tr>
			 -->
		</table>
		
		
	<!--  start of ProductItem List -->	
	 	<br><br>
	   <div class="table-title"><h3>Product Items</h3></div>
	   
		<table class="table-fill" width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr><td class="cell-r">total : <%= productItemSize %></td></tr></table>
		<table class="table-fill" border="1">
		<tr class="header">
			<th width="10%" class="text-center">productNo</th>
			<th width="10%" class="text-center">itemId</th>
			<th width="10%" class="text-center">itemCnt</th>
			<th width="30%" class="text-center">itemNm</th>
			<th width="40%" class="text-center">itemNmKr</th>
		</tr>
		<tbody class="table-hover">
		<%
			if(productItemSize == 0) {
		%>
				<tr class="row">
			 	   <td colspan="6" class="cell-c">��ϵ� ������ �����ϴ�.</td>
				</tr>
			 <%
			 	} else {
			 		
			 		for(int i=0; i<productItemSize;i++){
			 			
						ProductItem productItem = productItemList.get(i);
			//			indent = item.getIndent();
						/*int itemNo = item.getItemNo();
						String itemNm = item.getItemNm();
						String regUserId = item.getInsertUserId();
						String regDt = item.getInsertDatetime.toString();*/
		%>
		
		<tr class="row">
		<td class="cell-c"><%= productItem.getProductNo() %></td>
		<td class="cell-c"><%= productItem.getItemId() %></td>
		<td class="cell-c"><%= productItem.getItemCnt() %></td>
		<td class="cell-c"><%= productItem.getItemNm() %></td>
		<td class="cell-c"><%= productItem.getItemNmKr() %></td>
		</tr>
		
		<%
		
			}}
		
		%>

		</table>		
	<!--  end of ProductItem List -->	
	
		
		
		
		
		<table>
    		<tr height="40" valign="bottom">
     			<td colspan="2">
     				<div align="center">
     				<% if(mode.equals("C")) { %>
     					<!--<input type="submit" class="myButton" value="���">&nbsp;-->
     				<% }else{ %>
     					<!--  <input type="submit" class="myButton" value="����">&nbsp;-->
     					<!--  <input type="button" class="myButton" value="����" onclick="confirmDelete();">&nbsp;-->
     				<% } %>
         				<!--  <input type="button" class="myButton" value="���" onclick="moveTo('productList.jsp?pg=<%=pg %>');">-->
         			</div>
     			</td>
    		</tr>
		</table>   		 
	</form> 
</center>
</body>
</html>