<%@ page language="java" contentType="text/html;charset=EUC-KR"%>
<% request.setCharacterEncoding("EUC-KR"); %>
<%@ page import="java.sql.*"%><!-- JSP에서 JDBC의 객체를 사용하기 위해 java.sql 패키지를 import 한다 -->
<%@ page import="java.util.*"%>
<%@ page import="wh.*"%>
<jsp:useBean id="mrDao" class="wh.MrDAO" />
<jsp:useBean id="itemDao" class="wh.ItemDAO" />
<jsp:useBean id="orderTDao" class="wh.OrderTDAO" />

<jsp:include page = "top.jsp"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Transfer Order</title>
<link rel="stylesheet" href="../css/vandiservice.css">
<script type="text/javascript" src="../js/mr.js"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.7.1.min.js"></script>

<%
	String mode = request.getParameter("mode");
	String pg = request.getParameter("pg");

	String authLvl =  (String)session.getAttribute("authLvl");
	if (authLvl == null) return;
	int userWhNo =  (Integer)session.getAttribute("whNo");
	String userWhId =  (String)session.getAttribute("whId");

//System.out.println(mode + " " + authLvl +" "+ userWhNo + " " + userWhId);

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

	ArrayList<OrderTItem> orderTItemList = null;
	ArrayList<Item> itemlist = null;
	
	OrderT orderT = null; 
	
	if (mode.equals("R")) {
		orderNo = Integer.parseInt(request.getParameter("orderNo"));

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
			
			orderTItemList = orderTDao.getOrderTItemList(orderNo);
			
			itemlist = itemDao.getItemList(srcWhNo, destWhNo);
		}

		//		int size = orderItemList.size();		
	}
	else // mode C
	{
		srcWhNo = 0; // mr
		destWhNo = userWhNo;
		itemlist = itemDao.getItemList(srcWhNo, destWhNo);
	}
	
	int itemLength = itemlist.size();
	

	ArrayList<Wh> whlist = mrDao.getWhList();
	int whLength = whlist.size();

	String orderStr;
%>

<script type="text/javascript">

	var mode = '<%=mode%>';
	var backOrderFg = false;  // src 자재 갯수 이상 주문시 true
	
	//alert(mode);
	

	function toWriteCheck() {
		
		if(isNull(document.getElementById("srcWh")))
		{
			alert('출고지를 선택하세요.');
			return false;
		}
		else if(isNull(document.getElementById("destWh")))
		{
			alert('배송지를 선택하세요.');
			return false;
		}
		else if(document.getElementById("srcWh").value == document.getElementById("destWh").value)
		{
			alert("출고지와 배송지는 같을 수 없습니다.");
			return false;
		}
		else if(document.getElementById("tdSubtotal").innerHTML  == "" || document.getElementById("tdSubtotal").innerHTML  == 0)
		{
			alert("품목 입력 내역이 없습니다.");
			return false;
		}
		
		if (backOrderFg)
		{ 
			if(confirm("오렌지 컬러 품목은 백오더 상태입니다. 계속하시겠습니까?"))
			{
				document.getElementById('srcWh').disabled='';
				document.getElementById('destWh').disabled='';
			
				return true;
			}else{
				return false;
			}
		}else{
			document.getElementById('srcWh').disabled='';
			document.getElementById('destWh').disabled='';
			
			return true;
		}
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
			
<%
			if (orderTItemList != null) {
				int size = orderTItemList.size();
				OrderTItem orderTItem = null;

				for (int j = 0; j < size; j++) {
					orderTItem = orderTItemList.get(j);
					int itemId = orderTItem.getItemNo();
					int itemCnt = orderTItem.getItemCnt();
%>
			
					// 수량 setting
					var idList = document.getElementsByName("selItem");
					var priceList = document.getElementsByName("txtPrice");
					var cntList = document.getElementsByName("txtCnt");
					var trList = document.getElementsByName("trItem");
					
					var tot = idList.length;
					
					for (i = 0; i < tot; i++) {
						
						if(idList[i].value == '<%=itemId%>')
						{
						
							cntList[i].value = '<%=itemCnt%>';
						}
					}		
<%
				}//for
			}//if orderItemList
%>
			
/*
			var tbl = document.getElementById("order_item_table");
			var numRows = tbl.rows.length;
			
			for (var i = 1; i < numRows; i++) {
			    var ID = tbl.rows[i].id;
			    if(ID != "order_item_info")
			    	continue;
			    
			    alert(tbl.rows[i].find("input"));
			    
			    tbl.rows[i].find("input").each(function(){
			    	alert(this.value);
			    })
			
			    var cells = tbl.rows[i].find("input");
			    
			    alert(cells[0].innerHTML);
			    
			    if(cells[2].value == 0)
			    	tbl.rows[i].style.display = none;
			    else
			    	tbl.rows[i].style.display = visible;
			}
*/
			
		}//if(mode == "R")
		else { //"C"
			document.getElementById("srcWh").value = 0; // mr로 고정
			document.getElementById("destWh").value = '<%= userWhNo %>';
		}	
		
		if('<%= authLvl %>' == 'S')
		{
			document.getElementById('destWh').disabled='';
		}
		/*else{
			alert('2');
			document.getElementById('destWh').setAttribute('disabled');
		}*/
	}//setPage
	
	
	function setSelectResult()
	{
		var str = "";
		var cnt = 0;
	    var subtotal = 0;
	    
	    var idList = document.getElementsByName("selItem");
	    var priceList = document.getElementsByName("txtPrice");
	    var cntList = document.getElementsByName("txtCnt");
	    var srcCntList = document.getElementsByName("srcItemCnt");
	    
	    var tot = idList.length;
	    
	    backOrderFg = false;
	    
	    for (i = 0; i < tot; i++) {
   		
	    	// 주문정보 setting
	    	if(!isNull(cntList[i]) && cntList[i].value != 0)
	    	{
	    		if(str == "")
	    			str = idList[i].value + ":" +  cntList[i].value + ":" +  priceList[i].value;
	    		else
	    			str = str + "/" + idList[i].value + ":" +  cntList[i].value + ":" +  priceList[i].value; // seperator | 는 사용하면 안됨. 변형되는지 split이 안돼 
	    		
	    		subtotal = subtotal + parseInt(priceList[i].value) * parseInt(cntList[i].value);
	    	}
	    	
			// 재고 체크 
	    	if(!isNull(cntList[i]))
	    	{
	    		<% if(orderT == null || !orderT.getStatusCd().equals("40")) { // 배송완료 상태가 아닌 경우 %> 
				if (parseInt(cntList[i].value) > parseInt(srcCntList[i].value))
				{
					cntList[i].style.backgroundColor = "orange";
					backOrderFg = true;
				}else{
					cntList[i].style.backgroundColor = "";
				}
				<% } %>
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
			moveTo('toWrite.jsp?version=1&mode=D&orderNo=<%=orderNo%>');
		}
	}
	
	// 접수 
	function confirmAccept() {
		if(confirm('접수 후에는 수정/삭제가 불가능합니다. 접수하시겠습니까?'))
		{
			moveTo('toWrite.jsp?mode=A&orderNo=<%=orderNo%>');
		}
	}
		
	// 배송중
	function confirmShip() {
		if(confirm('배송처리 하시겠습니까?'))
		{
			moveTo('toWrite.jsp?mode=S&orderNo=<%=orderNo%>');
		}
	}
		
	// 완료 
	function confirmFinish() {
		<% if(mode.equals("R")) { %>
		if(confirm('완료처리 하시겠습니까?'))
		{
			moveTo('toWrite.jsp?mode=F&orderNo=<%=orderNo%>&srcWhNo=<%=orderT.getSrcWhNo()%>');
		}
		<% } %>
	}	
		
	
</script>
</head>

<body>
	<center>
	   <div class="table-title"><h1>T.O.(Transfer order) 정보</h1></div>

		<form name="form_order" method="post"
			action="toWrite.jsp?mode=<%=writeMode%>"
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
					
					<td width="35%" class="cell-r">출고지</td>
					<td width="15%" class="cell-l">
						<select name=srcWh id=srcWh disabled>
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
					
					<td width="35%" class="cell-r">배송지</td>
					<td width="15%" class="cell-l">
						<select id=destWh name=destWh disabled>
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
			
			
		<!-- NOTE -->
		<!-- //////////////////////////////////////////////////////////////////////////////////////////// -->
		<h3>Note</h3>
		<table border="0" width=600>
			
	   	<% if(mode.equals("C")) { %>
			<tr><td><textarea rows="3" cols="80" name="note" placeholder="자재 구매 관련 특이사항을 입력합니다."></textarea></td></tr>
	   	<% } else if(mode.equals("R")) { %>
			<tr><td><textarea rows="3" cols="80" name="note"><%= orderT.getNote() %></textarea></td></tr>
	   	<% } else if(mode.equals("V")){ %>
			<tr><td><textarea rows="3" cols="96" name="note" style="border: 1px solid #C1C3D1;" readonly><%= orderT.getNote() %></textarea></td></tr>
	   	<% } %>
			        
			<tr height="15"/>
		</table>
			

			<table id="order_item_table" border=0>
				<thead>
					<tr>
						<th width="60%" nowrap>품목</th>
						<th width="10%" class="cell-r">판매가격</th>
						<th width="10%" class="cell-r">수량</th>
						<th width="10%" class="cell-r">출고지 재고</th>
						<th width="10%" class="cell-r">배송지 재고</th>
					</tr>
				</thead>
				<tbody id="p_item">

					<%
						for (int i = 0; i < itemLength; i++) {
							Item item = itemlist.get(i);
					%>

					<tr id="order_item_info">
						<td><input type=hidden name="selItem" value=<%=item.getItemNo()%>>
						<!-- <select name="selItem" disabled>
								<option value=<%=item.getItemNo()%>> </option></select>-->
								[<%=item.getItemId()%>]&nbsp;<%=item.getItemNm()%>
						</td>
						<td class="cell-r"><input type="text" name="txtPrice" size=6
							style="border: 0px; text-align: right;" value='<%=item.getPriceCenter()%>'
							disabled /></td>
						<td class="cell-r"><input type="text" name="txtCnt" size=6
							style="text-align: right" onchange="setSelectResult();"
							onKeypress="if(event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;" />
						</td>
						<td class="cell-r"><input type="text" name="srcItemCnt" size=7
							style="border: 0px; text-align: right;" value='<%=item.getSrcItemCnt()%>'
							disabled /></td>
						<td class="cell-r"><input type="text" name="destItemCnt" size=7
							style="border: 0px; text-align: right;" value='<%=item.getDestItemCnt()%>'
							disabled /></td>
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
							<% if (mode.equals("C")) { %>
									<input type="submit" class="dtlBtn" value="등록">&nbsp;
							<% } %> 
							<% if (mode.equals("R") && orderT.getStatusCd().equals("10")){ // 주문상태 => 수정 삭제 가능 %>
									<input type="submit" class="dtlBtn" value="수정">&nbsp;
									<input type="button" class="dtlBtn" value="삭제" onclick="confirmDelete();">&nbsp;
							<% } %> 
							<% if (mode.equals("R") && orderT.getStatusCd().equals("10") && userWhId.equals("mr")) { // 접수이고  MR 직원인 경우 확정 가능 %>
									<input type="button" class="dtlBtn" value="접수" onclick="confirmAccept();">&nbsp;
							<% } %> 
							<% if (mode.equals("R") && orderT.getStatusCd().equals("20") && userWhId.equals("mr")) { // 확정이고  MR 직원인 경우 배송관련 처리 가능 %>
									<input type="button" class="dtlBtn" value="배송중" onclick="confirmShip();">&nbsp;
							<% } %> 
							<% if (mode.equals("R") && orderT.getStatusCd().equals("30") && userWhId.equals("mr")) { // 배송중이고  MR 직원인 경우 배송관련 처리 가능 %>
									<input type="button" class="dtlBtn" value="배송완료" onclick="confirmFinish();">&nbsp;
							<% } %> 
							
							<input type="button" class="dtlBtn" value="목록"
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