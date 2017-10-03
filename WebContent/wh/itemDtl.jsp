<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" %>
<%@ page import = "java.sql.*" %>                    <!-- JSP���� JDBC�� ��ü�� ����ϱ� ���� java.sql ��Ű���� import �Ѵ� -->
<%@ page import="wh.*" %>
<%@ page import="java.util.*" %>
<jsp:useBean id="dao" class="wh.ItemDAO"/>
<jsp:include page = "top.jsp"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
 	<link rel="stylesheet" href="../css/vandiservice.css">
<script type="text/javascript" src="../js/mr.js"></script>

<%
	String authLvl =  (String)session.getAttribute("authLvl");
	if (authLvl == null) return;
	//if(authLvl.equals("S") || authLvl.equals("A")) // ���,���� ������
	
	String mode = request.getParameter("mode");
	String pg = request.getParameter("pg");

	String writeMode;
	if(mode.equals("C"))
		writeMode = "C";
	else // R
		writeMode = "U";
	
	Item item = null;

	if(mode.equals("R"))
	{
		int idx = Integer.parseInt(request.getParameter("idx"));
		
		item = dao.getItemInfo(idx);
	}
	
%>

<script type="text/javascript">

	var mode = '<%=mode%>';
	
	//alert(mode);

	function chkValid() {
	
		if(document.getElementById("itemId").value == '')
		{
			alert('ǰ���ڵ带 �Է��ϼ���.');
			return false;
		}
		else if(document.getElementById("itemId").value.length != 4)
		{
			alert('ǰ���ڵ带 ���� ���ڸ��� �Է��ϼ���.');
			return false;
		}
		else if(document.getElementById("itemNm").value == '')
		{
			alert('ǰ��(����)�� �Է��ϼ���.');
			return false;
		}
		else if(document.getElementById("itemNmKor").value == '')
		{
			alert('ǰ��(�ѱ�)�� �Է��ϼ���.');
			return false;
		}
		else if(document.getElementById("curCd").value != '' &&document.getElementById("curCd").value != 'WON' && document.getElementById("curCd").value != 'USD' && document.getElementById("curCd").value != 'YEN')
		{
			alert('ȭ������� �˸°� �Է��ϼ���.');
			return false;
		}
		/*
		else if(document.getElementById("curCd").value == '')
		{
			alert('ȭ������� �Է��ϼ���.');
			return false;
		}
		else if(document.getElementById("priceCenter").value == '')
		{
			alert('���Ŵܰ��� �Է��ϼ���.');
			return false;
		}
		else if(document.getElementById("priceClient").value == '')
		{
			alert('�ǸŴܰ��� �Է��ϼ���.');
			return false;
		}
		else if(document.getElementById("serviceHour").value == '')
		{
			alert('���ӽð��� �Է��ϼ���.(�Ҽ��� ���ڸ����� ����)');
			return false;
		}
		*/
		
		// �Է� ���� ���� �⺻ setting 
		if(document.getElementById("vendorId").value == '')
			document.getElementById("vendorId").value = 0;
		if(document.getElementById("curCd").value == '')
			document.getElementById("curCd").value = "WON";
		 
		if(document.getElementById("price").value == '')
			document.getElementById("price").value = 0;
		if(document.getElementById("priceMeta").value == '')
			document.getElementById("priceMeta").value = 0;
		if(document.getElementById("priceFactory").value == '')
			document.getElementById("priceFactory").value = 0;
		if(document.getElementById("priceCenter").value == '')
			document.getElementById("priceCenter").value = 0;
		if(document.getElementById("priceClient").value == '')
			document.getElementById("priceClient").value = 0;
		if(document.getElementById("serviceHour").value == '')
			document.getElementById("serviceHour").value = 0;
		
	}

	function confirmDelete() {
		
		if(confirm('�����Ͻðڽ��ϱ�?'))
		{
			<% if(mode.equals("R")) { %>   
				moveTo('itemWrite.jsp?mode=D&itemNo=<%= item.getItemNo() %>');	
			<% } else { %>
			<% } %>
		}
	}
	
</script>


</head>
<body>
<center>

	<% if(mode.equals("R")) { %>   
   		<div class="table-title"><h1>��������</h1></div>
	<% } else { %>
   		<div class="table-title"><h1>������</h1></div>
	<% } %>   		
	
	<form name="form1" method="post" action="itemWrite.jsp?mode=<%= writeMode %>" onsubmit="return chkValid();">
		<table>
		
    		<tr class="row_bottom_only">
				<td width="40%" class="cell-r">ǰ���ڵ�</td>
				<td width="60%" class="cell-l">
	<% if(mode.equals("C")) { %>   
					<input type=text name=itemId id=itemId size=4 maxlength=4
						onKeypress="if(event.keyCode < 48 || event.keyCode > 57) event.returnValue = false;"
						value='' >
					<input type=hidden name=itemNo id=itemNo value='' >
	<% } else { %>
					<input type=text disabled size=4 maxlength=4 
						onKeypress="if(event.keyCode < 48 || event.keyCode > 57) event.returnValue = false;"
						value='<%= item.getItemId() %>' >
					<input type=hidden name=itemId id=itemId value='<%= item.getItemId() %>' >
					<input type=hidden name=itemNo id=itemNo value='<%= item.getItemNo() %>' >
	<% } %>   		
				</td>
			</tr>
    		<tr class="row_bottom_only">
				<td width="40%" class="cell-r">ǰ��(����)</td>
				<td width="60%" class="cell-l">
	<% if(mode.equals("C")) { %>   
					<input type=text name=itemNm id=itemNm size=45 value='' >
	<% } else { %>
					<input type=text name=itemNm id=itemNm size=45 value='<%= item.getItemNm() %>' >
	<% } %>   		
				</td>
			</tr>
    		<tr class="row_bottom_only">
				<td width="40%" class="cell-r">ǰ��(�ѱ�)</td>
				<td width="60%" class="cell-l">
	<% if(mode.equals("C")) { %>   
					<input type=text name=itemNmKor id=itemNmKor size=45 value='' >
	<% } else { %>
					<input type=text name=itemNmKor id=itemNmKor size=45 value='<%= item.getItemNmKor() %>' >
	<% } %>   		
				</td>
			</tr>
    		<tr class="row_bottom_only">
				<td width="40%" class="cell-r">����ID</td>
				<td width="60%" class="cell-l">
	<% if(mode.equals("C")) { %>   
					<input type=text name=vendorId id=vendorId size=15 maxlength=15
						onKeypress="if(event.keyCode < 48 || event.keyCode > 57) event.returnValue = false;"
						value='' >
	<% } else { %>
					<input type=text name=vendorId id=vendorId size=15 maxlength=15
						onKeypress="if(event.keyCode < 48 || event.keyCode > 57) event.returnValue = false;"
						value='<%= item.getVendorId() %>' >
	<% } %>   		
				</td>
			</tr>			
    		<tr class="row_bottom_only">
				<td width="40%" class="cell-r">ȭ�����</td>
				<td width="60%" class="cell-l">
	<% if(mode.equals("C")) { %>   
					<input type=text name=curCd id=curCd size=15 maxlength=3
						value='' >
	<% } else { %>
					<input type=text name=curCd id=curCd size=15 maxlength=3
						value='<%= item.getCurCd() %>' >
	<% } %>   		
	 				��ȭ : WON, �̴޷� : USD, ��ȭ :YEN <!--  , ���� : EUR-->
				</td>
			</tr>
			
			<!-- ----------------------------------------------------------------------------------------------------------------- �غ� -->
			<!--  �Ʒ� ���� 3���� SUPER�� ������ !!! -->
<% if(authLvl.equals("S")) { %>			
    		<tr class="row_bottom_only">
				<td width="40%" class="cell-r"><font color="red">����</font></td>
				<td width="60%" class="cell-l">
	<% if(mode.equals("C")) { %>   
					<input type=text name=price id=price size=15 maxlength=15
						onKeypress="if(event.keyCode < 48 || event.keyCode > 57) event.returnValue = false;"
						value='' > 
	<% } else { %>
					<input type=text name=price id=price size=15 maxlength=15
						onKeypress="if(event.keyCode < 48 || event.keyCode > 57) event.returnValue = false;"
						value='<%= item.getPrice() %>' > 
	<% } %>   		
					<font color="red"> (Super �����ڿ��Ը� ����)</font>
				</td>
			</tr>
    		<tr class="row_bottom_only">
				<td width="40%" class="cell-r"><font color="red">��Ÿ�ܰ�</font></td>
				<td width="60%" class="cell-l">
	<% if(mode.equals("C")) { %>   
					<input type=text name=priceMeta id=priceMeta size=15 maxlength=15
						onKeypress="if(event.keyCode < 48 || event.keyCode > 57) event.returnValue = false;"
						value='' > 
	<% } else { %>
					<input type=text name=priceMeta id=priceMeta size=15 maxlength=15
						onKeypress="if(event.keyCode < 48 || event.keyCode > 57) event.returnValue = false;"
						value='<%= item.getPriceMeta() %>' >
	<% } %>   		
					<font color="red"> (Super �����ڿ��Ը� ����)</font>
				</td>
			</tr>
    		<tr class="row_bottom_only">
				<td width="40%" class="cell-r"><font color="red">����ܰ�</font></td>
				<td width="60%" class="cell-l">
	<% if(mode.equals("C")) { %>   
					<input type=text name=priceFactory id=priceFactory size=15 maxlength=15
						onKeypress="if(event.keyCode < 48 || event.keyCode > 57) event.returnValue = false;"
						value='' >
	<% } else { %>
					<input type=text name=priceFactory id=priceFactory size=15 maxlength=15
						onKeypress="if(event.keyCode < 48 || event.keyCode > 57) event.returnValue = false;"
						value='<%= item.getPriceFactory() %>' >
	<% } %>   		
					<font color="red"> (Super �����ڿ��Ը� ����)</font>
				</td>
			</tr>
<% } %>   		
			<!-- ----------------------------------------------------------------------------------------------------------------- �غ� -->

    		<tr class="row_bottom_only">
				<td width="40%" class="cell-r">���Ŵܰ�</td>
				<td width="60%" class="cell-l">
	<% if(mode.equals("C")) { %>   
					<input type=text name=priceCenter id=priceCenter size=15 maxlength=15
						onKeypress="if(event.keyCode < 48 || event.keyCode > 57) event.returnValue = false;"
						value='' >
	<% } else { %>
					<input type=text name=priceCenter id=priceCenter size=15 maxlength=15
						onKeypress="if(event.keyCode < 48 || event.keyCode > 57) event.returnValue = false;"
						value='<%= item.getPriceCenter() %>' >
	<% } %>   		
				</td>
			</tr>
    		<tr class="row_bottom_only">
				<td width="40%" class="cell-r">�ǸŴܰ�</td>
				<td width="60%" class="cell-l">
	<% if(mode.equals("C")) { %>   
					<input type=text name=priceClient id=priceClient size=15 maxlength=15
						onKeypress="if(event.keyCode < 48 || event.keyCode > 57) event.returnValue = false;"
						value='' >
	<% } else { %>
					<input type=text name=priceClient id=priceClient size=15 maxlength=15
						onKeypress="if(event.keyCode < 48 || event.keyCode > 57) event.returnValue = false;"
						value='<%= item.getPriceClient() %>' >
	<% } %>   		
				</td>
			</tr>
    		<tr class="row_bottom_only">
				<td width="40%" class="cell-r">���ӽð�</td>
				<td width="60%" class="cell-l">
	<% if(mode.equals("C")) { %>   
					<input type=text name=serviceHour id=serviceHour size=15 
						onKeypress="if(event.keyCode != 46 && (event.keyCode < 48 || event.keyCode > 57)) event.returnValue = false;" 
						value='' placeholder="ex)2.5" />
	<% } else { %>
					<input type=text name=serviceHour id=serviceHour size=15 
						onKeypress="if(event.keyCode != 46 && (event.keyCode < 48 || event.keyCode > 57)) event.returnValue = false;"
						value='<%= item.getServiceHour() %>' >
	<% } %>   		
				</td>
			</tr>
     		<tr class="row_bottom_only">
				<td width="40%" class="cell-r">�����</td>
				<td width="60%" class="cell-l">
	<% if(mode.equals("C")) { %>   
					<input type=text name=insertUserId id=insertUserId size=20 disabled value='<%= (String)session.getAttribute("userId") %>' >
	<% } else { %>
					<input type=text name=insertUserId id=insertUserId size=20 disabled value='<%= item.getInsertUserId() %>' >
	<% } %>   		
				</td>
			</tr>
    		<tr class="row_bottom_only">
				<td width="40%" class="cell-r">����Ͻ�</td>
				<td width="60%" class="cell-l">
	<% if(mode.equals("C")) { %>   
					<input type=text name=insertDatetime id=insertDatetime size=20 disabled value='javascript:today();' >
	<% } else { %>
					<input type=text name=insertDatetime id=insertDatetime size=20 disabled value='<%= item.getInsertDatetime() %>' >
	<% } %>   		
				</td>
			</tr>
			<tr height="20"/>
		</table>
		
		<table>
    		<tr height="40" valign="bottom">
     			<td colspan="2">
     				<div align="center">
     				<% if(mode.equals("C") && authLvl.equals("S")) { %>
     					<input type="submit" class="dtlBtn" value="���">&nbsp;
     				<% }else if(mode.equals("R") && authLvl.equals("S")) { %>
     					<input type="submit" class="dtlBtn" value="����">&nbsp;
     					<!-- <input type="button" class="dtlBtn" value="����" onclick="confirmDelete();">&nbsp; -->
     				<% } %>
         				<input type="button" class="dtlBtn" value="���" onclick="moveTo('itemList.jsp?pg=<%=pg%>');">
         			</div>
     			</td>
    		</tr>
		</table>    		 
	</form> 
</center>
</body>
</html>