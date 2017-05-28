<%@ page language="java" contentType="text/html;charset=EUC-KR"%>
<%
	request.setCharacterEncoding("EUC-KR");
%>

<%@ page import="java.sql.*"%>
<!-- JSP에서 JDBC의 객체를 사용하기 위해 java.sql 패키지를 import 한다 -->
<%@ page import="wh.*"%>
<%@ page import="java.util.*"%>

<jsp:useBean id="mrDao" class="wh.MrDAO" />
<jsp:useBean id="itemDao" class="wh.ItemDAO" />
<jsp:useBean id="orderTDao" class="wh.OrderTDAO" />
<jsp:include page="/loginChk.jsp" />



<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/vandiservice.css">
<script type="text/javascript" src="../js/mr.js"></script>
<script type="text/javascript" src="../js/chkValid.js"></script>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-1.7.1.min.js"></script>


<%
	String mode = request.getParameter("mode");
	String pg = request.getParameter("pg");

	//out.print("."+mode+".");

	String writeMode;
	if (mode.equals("C"))
		writeMode = "C";
	else // R
		writeMode = "U";

	int orderNo = 0;
	String orderDt = "";
	int srcWhNo = 0;
	int destWhNo = 0;
	String statusCd = "";
	int subtotal = 0;
	int tax = 0;
	int totalAmt = 0;
	String insertUserId = "";

	ArrayList<OrderItem> orderItemList = null;

	if (mode.equals("R")) {
		orderNo = Integer.parseInt(request.getParameter("orderNo"));

		OrderT orderT = null;

		orderT = orderTDao.getOrderTInfo(orderNo);

		if (orderT != null) {
			//out.print("orderT not null");

			orderDt = orderT.getOrderDt();
			srcWhNo = orderT.getSrcWhNo();
			destWhNo = orderT.getDestWhNo();
			statusCd = orderT.getStatusCd();
			subtotal = orderT.getSubtotal();
			tax = orderT.getTax();
			totalAmt = orderT.getTotalAmt();
			insertUserId = orderT.getInsertUserId();
		}

		orderItemList = orderTDao.getOrderItemList(orderNo);
		//		int size = orderItemList.size();		
	}

	// mode C/R

	ArrayList<Wh> whlist = mrDao.getWhList();
	int whLength = whlist.size();

	ArrayList<Item> itemlist = itemDao.getItemList();
	int itemLength = itemlist.size();

	String orderStr;
%>

<script type="text/javascript">

	var mode = '<%=mode%>';
	//alert(mode);
	

	function toWriteCheck() {
		
		
		if(isNull(document.getElementById("srcWh")))
		{
			alert('src 선택해');
			return false;
		}
		else if(isNull(document.getElementById("destWh")))
		{
			alert('dest 선택해');
			return false;
		}
		else if(document.getElementById("srcWh").value == document.getElementById("destWh").value)
		{
			alert("Source창고와 Destination창고는 같을 수 없습니다.");
			return false;
		}
		else if(document.getElementById("tdSubtotal").innerHTML  == "" || document.getElementById("tdSubtotal").innerHTML  == 0)
		{
			alert("아이템 입력 내역이 없습니다.");
			return false;
		}
		
		return true;
	}


	function setPage()
	{
		if(mode == "R")
		{
		
			//document.getElementById("userId").value = '<%=insertUserId%>';
			
			document.getElementById("srcWh").value = '<%=srcWhNo%>';
			//document.getElementById("srcWh").disabled = true;
			
			document.getElementById("destWh").value = '<%=destWhNo%>';
			//document.getElementById("destWh").disabled = true;
			
			document.getElementById("tdSubtotal").innerHTML = '<%=subtotal%>';
			document.getElementById("tdTax").innerHTML = '<%=tax%>';
			document.getElementById("tdTotalAmt").innerHTML = '<%=totalAmt%>';
			
<%if (orderItemList != null) {
				int size = orderItemList.size();
				OrderItem orderItem = null;

				for (int j = 0; j < size; j++) {
					orderItem = orderItemList.get(j);
					int itemId = orderItem.getItemNo();
					int itemCnt = orderItem.getItemCnt();
					//out.print(itemId + ":" + itemCnt);%>
								
				
					// 수량 setting
					var idList = document.getElementsByName("selItem");
					var priceList = document.getElementsByName("txtPrice");
					var cntList = document.getElementsByName("txtCnt");
					
					var tot = idList.length;
					
					for (i = 0; i < tot; i++) {
						
						if(idList[i].value == '<%=itemId%>')
						{
							cntList[i].value = '<%=itemCnt%>';
						}
					}		
<%}
			}%>
		}//if(mode == "R")
	}//setPage
	
	
	function setSelectResult()
	{
		var str = "";
		var cnt = 0;
	    var subtotal = 0;
	    
	    var idList = document.getElementsByName("selItem");
	    var priceList = document.getElementsByName("txtPrice");
	    var cntList = document.getElementsByName("txtCnt");
	    
	    var tot = idList.length;
	    
	    for (i = 0; i < tot; i++) {
	    	
	    	if(!isNull(cntList[i]) && cntList[i].value != 0)
	    	{
	    		if(str == "")
	    			str = idList[i].value + ":" +  cntList[i].value + ":" +  priceList[i].value;
	    		else
	    			str = str + "/" + idList[i].value + ":" +  cntList[i].value + ":" +  priceList[i].value; // seperator | 는 사용하면 안됨. 변형되는지 split이 안돼 
	    		subtotal = subtotal + parseInt(priceList[i].value) * parseInt(cntList[i].value);
	    	}
	    }
	    
		document.getElementById("tdSubtotal").innerHTML = subtotal;
		document.getElementById("tdTax").innerHTML = parseInt(subtotal * 0.1);
		document.getElementById("tdTotalAmt").innerHTML = parseInt(subtotal * 1.1);
		
		document.getElementById("subtotal").value = subtotal;
		document.getElementById("tax").value = parseInt(subtotal * 0.1);
		document.getElementById("totalAmt").value = parseInt(subtotal * 1.1);
		
		document.getElementById("orderStr").value = str;
	}
	

	function confirmDelete() {
		
		if(confirm('삭제하시겠습니까?'))
		{
			<%if (mode.equals("R")) {%>   
				moveTo('toDelete.jsp?orderNo=<%=orderNo%>');
			<%} else {%>
	
			<%}%>
		}
	}
</script>
</head>

<body>
	<center>



		<%
			if (mode.equals("R")) {
		%>
		<div class="table-title">
			<h1>Transfer order #<%= orderNo %></h1>
		</div>
		<%
			} else {
		%>
		<div class="table-title">
			<h1>New transfer order</h1>
		</div>
		<%
			}
		%>


		<form name="form_order" method="post"
			action="toWrite_action.jsp?mode=<%=writeMode%>"
			onsubmit="return toWriteCheck();">


			<table width="300">
				<tr class="row_bottom_only">
					<td width="15%" class="cell-hd">주문번호</td>
					<td width="35%" class="cell-l">
 
 <% if(mode.equals("C")) { %>   
					<input type=text size=10 disabled value='' style="border: 0px; text-align: left;" >
					<input type=hidden name=orderNo id=orderNo >
	<% } else { %>
					<input type=text size=10 disabled value='<%= MrUtil.getTOrderNoStr(orderNo) %>'  style="border: 0px; text-align: left;" >
					<input type=hidden name=orderNo id=orderNo value='<%= orderNo %>' >
	<% } %>
 
					</td>
					<td width="35%" class="cell-l"/>
					<td width="15%" class="cell-l"/>
				</tr>
				<tr class="row_bottom_only">
					<td width="15%" class="cell-hd">주문일자</td>
					<td width="35%" class="cell-l">
	<% if(mode.equals("C")) { %>   
					<input type=date name=orderDt id=orderDt size=10 value='<%= MrUtil.getDateStr() %>' >
	<% } else { %>
					<input type=date name=orderDt id=orderDt size=10 value='<%= orderDt %>' >
	<% } %>
					</td>
					
					<td width="35%" class="cell-r">Source Warehouse</td>
					<td width="15%" class="cell-l"><select name=srcWh id=srcWh>
							<option value=''>선택</option>
							<%
								for (int i = 0; i < whLength; i++) {
									Wh wh = whlist.get(i);
							%>
							<option value=<%=wh.getWhNo()%>><%=wh.getWhNm()%></option>
							<%
								}
							%>
					</select></td>
					
				</tr>
				<tr class="row_bottom_only">
					<td width="15%" class="cell-hd">작성자</td>
					<td width="35%" class="cell-l">
						<%
							if (mode.equals("C")) {
						%> <%=(String) session.getAttribute("userId")%> <%
 	} else {
 %> <%=insertUserId%> <%
 	}
 %>
					</td>
					
					<td width="35%" class="cell-r">Destination Warehouse</td>
					<td width="15%" class="cell-l"><select id=destWh name=destWh>
							<option value=''>선택</option>
							<%
								for (int i = 0; i < whLength; i++) {
									Wh wh = whlist.get(i);
							%>
							<option value=<%=wh.getWhNo()%>><%=wh.getWhNm()%></option>
							<%
								}
							%>
					</select></td>
	
				</tr>
				
				<tr height="20" />
			</table>

			<table border=0>
				<thead>
					<tr>
						<th width="60%">Item</th>
						<th width="20%" class="cell-r">가격</th>
						<th width="20%" class="cell-r">수량</th>
					</tr>
				</thead>
				<tbody id="p_item">

					<%
						for (int i = 0; i < itemLength; i++) {
							Item item = itemlist.get(i);
					%>

					<tr>
						<td><input type=hidden name="selItem" value=<%=item.getItemNo()%>>
						<!-- <select name="selItem" disabled>
								<option value=<%=item.getItemNo()%>> </option></select>-->
								[<%=item.getItemId()%>]&nbsp;<%=item.getItemNm()%>
						</td>
						<td class="cell-r"><input type="text" name="txtPrice"
							style="border: 0px; text-align: right;" value='<%=item.getPriceCenter()%>'
							disabled /></td>
						<td class="cell-r"><input type="text" name="txtCnt"
							style="text-align: right" onchange="setSelectResult();"
							onKeypress="if(event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;" />
						</td>
					</tr>

					<%
						}
					%>

				</tbody>
			</table>
			<table width="200" height="50" border="0">
				<tr>
					<td align="right" width="100">subtotal :</td>
					<td id="tdSubtotal" align="right"></td>
				</tr>
				<tr>
					<td align="right">tax :</td>
					<td id="tdTax" align="right"></td>
				</tr>
				<tr>
					<td align="right">total price :</td>
					<td id="tdTotalAmt" align="right"></td>
				</tr>
			</table>


			<input type="hidden" id="subtotal" name="subtotal" /> <input
				type="hidden" id="tax" name="tax" /> <input type="hidden"
				id="totalAmt" name="totalAmt" /> <input type="hidden" id="orderStr"
				name="orderStr" />
			<table>
				<tr height="40" valign="bottom">
					<td colspan="2">
						<div align="center">
							<%
								if (mode.equals("C")) {
							%>
							<input type="submit" class="myButton" value="등록">&nbsp;
							<%
								} else {
							%>
							<input type="submit" class="myButton" value="수정">&nbsp; <input
								type="button" class="myButton" value="삭제"
								onclick="confirmDelete();">&nbsp;
							<%
								}
							%>
							<input type="button" class="myButton" value="목록"
								onclick="moveTo('toList.jsp?pg=<%=pg%>');">
						</div>
					</td>
				</tr>
			</table>
		</form>
	</center>
	<script>
		setPage();
		setSelectResult();
	</script>
</body>
</html>