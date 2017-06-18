<%@ page language="java" contentType="text/html;charset=EUC-KR"%>
<%
	request.setCharacterEncoding("EUC-KR");
%>

<%@ page import="java.sql.*"%>
<!-- JSP에서 JDBC의 객체를 사용하기 위해 java.sql 패키지를 import 한다 -->
<%@ page import="wh.*"%>
<%@ page import="java.util.*"%>

<% 

String mode = request.getParameter("mode");

if(!mode.equals("V")) { %>
<jsp:include page = "top.jsp"/>
<% } %>


<jsp:useBean id="mrDao" class="wh.MrDAO" />
<jsp:useBean id="itemDao" class="wh.ItemDAO" />
<jsp:useBean id="orderPDao" class="wh.OrderPDAO" />




<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Transfer Order</title>
<link rel="stylesheet" href="../css/vandiservice.css">
<script type="text/javascript" src="../js/mr.js"></script>
<script type="text/javascript" src="../js/chkValid.js"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.7.1.min.js"></script>


<%
	String pg = request.getParameter("pg");

	String authLvl =  (String)session.getAttribute("authLvl");
	if (authLvl == null) return;
	int userWhNo =  (Integer)session.getAttribute("whNo");
	String userWhNm =  (String)session.getAttribute("whNm");
	if(userWhNm == null)
		return;
	String userWhId =  (String)session.getAttribute("whId");

	//out.print("[ "+userWhId+" ]");

	String writeMode;
	if (mode.equals("C"))
		writeMode = "C";
	else // R
		writeMode = "U";

	int orderNo = 0;
	String orderDt = "";
	int whNo = 0;
	String whNm = "";
	String statusCd = "";
	//int subtotal = 0;
	//int tax = 0;
	float totalAmt = 0;
	String insertUserId = "";

	ArrayList<OrderItem> orderItemList = null;
	ArrayList<Item> itemlist = null;
	
	OrderP orderP = null; 
	
	if (mode.equals("R") || mode.equals("V")) {
		orderNo = Integer.parseInt(request.getParameter("orderNo"));

		orderP = orderPDao.getOrderPInfo(orderNo);

		if (orderP != null) {
			//out.print("orderP not null");

			orderDt = orderP.getOrderDt();
			whNo = orderP.getWhNo();
			whNm = orderP.getWhNm();
			statusCd = orderP.getStatusCd();
			//subtotal = orderP.getSubtotal();
			//tax = orderP.getTax();
			totalAmt = orderP.getTotalAmt();
			insertUserId = orderP.getInsertUserId();
			
			orderItemList = orderPDao.getOrderItemList(orderNo);
			
			if(orderP.getStatusCd().equals("10")) //작성중
				itemlist = itemDao.getItemList(whNo);
			else
				itemlist = itemDao.getOrderPItemList(orderNo);
		}

		//		int size = orderItemList.size();		
	}
	else // mode C
	{
		whNo = userWhNo;
		whNm = userWhNm;
		itemlist = itemDao.getItemList(whNo);
	}

	if(itemlist == null)
		return;
	int itemLength = itemlist.size();
	

	ArrayList<Wh> whlist = mrDao.getWhList();
	int whLength = whlist.size();

	String orderStr;
%>

<script type="text/javascript">

	var mode = '<%=mode%>';
	var curCd = "";
	
	//alert(mode);

	function setPage()
	{
		if(mode == "R")
		{
		
			//document.getElementById("userId").value = '<%=insertUserId%>';
			
			document.getElementById("whNo").value = '<%=whNo%>';
			
<%
			if (orderItemList != null) {
				int size = orderItemList.size();
				OrderItem orderItem = null;

				for (int j = 0; j < size; j++) {
					orderItem = orderItemList.get(j);
					int itemId = orderItem.getItemNo();
					int itemCnt = orderItem.getItemCnt();
%>
			
					// 수량 setting
					var idList = document.getElementsByName("selItem");
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
		
			
		}//if(mode == "R")
		
		if('<%= authLvl %>' == 'S')
		{
			document.getElementById('whNo').disabled='';
		}
	}//setPage
	
	
	function setSelectResultRcv()
	{
		var str = "";
		var cnt = 0;
	    
	    var idList = document.getElementsByName("selItem");
	    var cntList = document.getElementsByName("txtCntRcv");
	    
	    var tot = idList.length;
	    
	    var tmpCurCd = "";
	    
	    for (i = 0; i < tot; i++) {
	    	
	    	if(!isNull(cntList[i]) && cntList[i].value != 0)
	    	{
		    	// 입고처리 정보 setting
	    		if(str == "")
	    			str = idList[i].value + ":" +  cntList[i].value;
	    		else
	    			str = str + "/" + idList[i].value + ":" +  cntList[i].value; // seperator | 는 사용하면 안됨. 변형되는지 split이 안돼 
	    	}
	    }
	    
		alert("rcvStr : " + str);
		document.getElementById("rcvStr").value = str;
	}
	

	function poRcvCheck() {
		
		if(document.getElementById("rcvStr").value == '')
		{
			alert("입고품목 입력내역이 없습니다.");
			return false;
		}
		
		if(confirm('입고처리 하시겠습니까?'))
			return true;
		else
			return false;
	}

	
	function printWindow() {
		
	    var printContents = document.getElementById("printArea").innerHTML;
	    var originalContents = document.body.innerHTML;
	     
	   	document.body.innerHTML = printContents;
	    window.print();
	    document.body.innerHTML = originalContents;
	}
			
</script>
</head>

<body>
	<center>

	<!-- TITLE -->
	<!-- //////////////////////////////////////////////////////////////////////////////////////////// -->
   		<div class="table-title"><h1>구매정보</h1></div>
	<!-- FORM -->
	<!-- //////////////////////////////////////////////////////////////////////////////////////////// -->

		<form name="form_order" method="post"
			action="poRcvWrite.jsp?mode=<%=writeMode%>"
			onsubmit="return poRcvCheck();">

	<!-- ORDER INFO -->
	<!-- //////////////////////////////////////////////////////////////////////////////////////////// -->

			<table width="600">
				<tr class="row_bottom_only">
					<td width="15%" class="cell-hd">주문번호</td>
					<td width="35%" class="cell-l">
 
 	<% if(mode.equals("C")) { %>   
					<input type=text size=10 disabled value='' style="border: 0px; text-align: left;" >
					<input type=hidden name=orderNo id=orderNo >
	<% } else if(mode.equals("R")) { %>
					<input type=text size=10 disabled value='<%= MrUtil.getTOrderNoStr(orderNo) %>'  style="border: 0px; text-align: left;" >
					<input type=hidden name=orderNo id=orderNo value='<%= orderNo %>' >
	<% } else if(mode.equals("V")) { %><%= MrUtil.getPOrderNoStr(orderNo) %>
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
	<% } else if(mode.equals("R")) { %>
					<input type=date name=orderDt id=orderDt size=10 value='<%= orderDt %>' >
	<% } else if(mode.equals("V")) { %><%= orderDt %>
	<% } %>   		

					</td>
					
					<td width="35%" class="cell-r"></td>
					<td width="15%" class="cell-l">
						</td>
					
				</tr>
				<tr class="row_bottom_only">
					<td width="15%" class="cell-hd">작성자</td>
					<td width="35%" class="cell-l">
						<% if (mode.equals("C")) { %> <%=(String) session.getAttribute("userId")%> 
						<% } else { %> <%=insertUserId%> 
						<% }%>
					</td>
					
					<td width="35%" class="cell-r">센터명</td>
					<td width="15%" class="cell-l">
					
     <% if(mode.equals("V")) { %><%= whNm %>
     				
     <% } else { %>
					
						<select id=whNo name=whNo disabled>
							<option value=''>선택</option>
							<%
								for (int i = 0; i < whLength; i++) {
									Wh wh = whlist.get(i);
							%>
							<option value=<%=wh.getWhNo()%>><%=wh.getWhNm()%></option>
							<%
								}
							%>
						</select>
     <% } %>
					</td>
	
				</tr>
				
				<tr height="20" />
			</table>

	<!-- ORDER ITEM -->
	<!-- //////////////////////////////////////////////////////////////////////////////////////////// -->

			<% float nTotalAmount = 0; %>
			<table id="order_item_table" border=0 width=600>
				<thead>
					<tr>
						<th width="50%" nowrap>품목</th>
						<th width="10%" class="cell-r">센터재고</th>
						<th width="10%" class="cell-r">주문수량</th>
						<th width="10%" class="cell-r">입고</th>
						<th width="10%" class="cell-r">미입고</th>
						<th width="10%" class="cell-r">입고처리</th>
					</tr>
				</thead>
				<tbody id="p_item">

				<%
					for (int i = 0; i < itemLength; i++) {
						Item item = itemlist.get(i);
						
						// View Only
						//////////////////////////////////////////////////////////////////////////
						int nOrderItemCnt = 0;
						if(mode.equals("V")) 
						{
							for(int j = 0; j < orderItemList.size(); j++)
							{
								OrderItem oItem = orderItemList.get(j); 
								if(item.getItemNo() == oItem.getItemNo()){
									nOrderItemCnt = oItem.getItemCnt();
								}
							}
							
							if(nOrderItemCnt == 0)
								continue;
						}
						//////////////////////////////////////////////////////////////////////////							
				%>

						<tr id="order_item_info">
							<td><input type=hidden name="selItem" value=<%=item.getItemNo()%>>
							<!-- <select name="selItem" disabled>
									<option value=<%=item.getItemNo()%>> </option></select>-->
									[<%=item.getItemId()%>]&nbsp;<%=item.getItemNm()%>
							</td>
							
							
							
								<td class="cell-r"><input type="text" name="txtCnt" size=3
									style="text-align: right" readonly value='<%=item.getOrderItemCnt()%>' />
								</td>
								<td class="cell-r"><input type="text" name="itemCnt" size=3
									style="border: 0px; text-align: right;" value='<%=item.getWhItemCnt()%>'
									disabled /></td>

								<td class="cell-r"><input type="text" name="itemCntRcv" size=3
									style="border: 0px; text-align: right;" value='<%=item.getItemRcvCnt()%>'
									disabled /></td>
								<td class="cell-r"><input type="text" name="itemCntNoRcv" size=3
									style="border: 0px; text-align: right;" value='<%=item.getItemNoRcvCnt()%>'
									disabled /></td>
								<td class="cell-r"><input type="text" name="txtCntRcv" size=3
									style="text-align: right" onchange="setSelectResultRcv();"
									onKeypress="if(event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;" />
								</td>

									
						</tr>
				<%
					} //for (int i = 0; i < itemLength; i++) {
				%>

				</tbody>
			</table>
			
			<input type="hidden" id="rcvStr" name="rcvStr" />
			
			<table>
				<tr height="40" valign="bottom">
					<td colspan="2">
						<div align="center">
							<% if (mode.equals("R") && orderP.getStatusCd().equals("20") && userWhId.equals("mr")) { // 작성완료이고  MR 직원인 경우 입고처리 가능 %>
									<input type="submit" class="dtlBtn" value="입고처리">&nbsp;
							<% } %> 
							<% if (mode.equals("R") && orderP.getStatusCd().equals("30") && userWhId.equals("mr")) { // 입고처리이고  MR 직원인 경우 입고완료 처리 가능 %>
									<input type="button" class="dtlBtn" value="입고완료" onclick="confirmFinish();">&nbsp;
							<% } %> 
							
		     				<% if(!mode.equals("V")){ %>
									<input type="button" class="dtlBtn" value="목록" onclick="moveTo('poList.jsp?pg=<%=pg%>');">
		     				<% } %>
						</div>
					</td>
				</tr>
			</table>
		</form>
	</center>
	<script>
		setPage();
		setSelectResultRcv();
	</script>
	
</body>
</html>