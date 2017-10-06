<%@ page language="java" contentType="text/html;charset=EUC-KR" %>
<% request.setCharacterEncoding("EUC-KR"); %>
<%@ page import = "java.sql.*" %>                    <!-- JSP에서 JDBC의 객체를 사용하기 위해 java.sql 패키지를 import 한다 -->
<%@ page import="java.util.*" %>
<%@ page import="wh.*" %>
<jsp:useBean id="productDao" class="wh.ProductDAO"/>
<jsp:useBean id="clientDao" class="wh.ClientDAO"/>
<jsp:useBean id="mrDao" class="wh.MrDAO"/>
 
<jsp:include page = "top.jsp"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/vandiservice.css">
<script type="text/javascript" src="../js/mr.js"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.7.1.min.js"></script>

<%
	String userId =  (String)session.getAttribute("userId");

	String authLvl =  (String)session.getAttribute("authLvl");
	if (authLvl == null) return;
	//if(authLvl.equals("S") || authLvl.equals("A")) // 등록,수정 권한자

	String mode = request.getParameter("mode"); // C/R
	String pg = request.getParameter("pg");
	
	String writeMode;
	if(mode.equals("C"))
		writeMode = "C";
	else // R
		writeMode = "U";
	
	int orderNo = 0;

	//out.print("."+mode+".");

	ArrayList<Model> modelList = mrDao.getModelList();
	int modelLength = modelList.size();
	
	ArrayList<Accessory> accList = mrDao.getAccessoryList();
	int accLength = accList.size();

	ArrayList<Client> clientList = clientDao.getClientList();
	int clientLength = clientList.size();
	
	ArrayList<ProductAcc> productAccList = null; 

	Product product = null;
	int productNo = 0;
	int modelNo = 0;
	int clientNo = 0;
	
	if(mode.equals("R"))
	{
		productNo = Integer.parseInt(request.getParameter("productNo"));
		
		product = productDao.getProductInfo(productNo);
		productAccList = productDao.getProductAccList(productNo);
		
		modelNo = product.getModelNo();
		clientNo = product.getClientNo();
//System.out.println(productNo + " "+ modelNo +" " + clientNo);		
	}
	
%>

<script type="text/javascript">

	var mode = '<%= mode %>';
	//alert(mode);

	function chkValid() {
				
		if(isNull(document.getElementById("modelNo")))
		{
			alert('모델명을 선택하세요.');
			return false;
		}
		else if(isNull(document.getElementById("serialNo")))
		{
			alert('제품번호를 입력하세요.');
			return false;
		}
		else if(isNull(document.getElementById("clientNo")))
		{
			alert('고객을 선택하세요.');
			return false;
		}
		
		return true;
	}

	function confirmDelete() {
		
		if(confirm('삭제하시겠습니까?'))
		{
			<% if(mode.equals("R")) { %>   
				moveTo('productWrite.jsp?mode=D&productNo=<%= product.getProductNo() %>');	
			<% } else { %>
			<% } %>   		
		}
	}
	
	function setPage()
	{
		if(mode == "R")
		{
			document.getElementById("modelNo").value = '<%= modelNo %>';
			document.getElementById("clientNo").value = '<%= clientNo %>';

<%
			if (productAccList != null) {
				int size = productAccList.size();
				ProductAcc productAcc = null;
				
				for (int j = 0; j < size; j++) {
					productAcc = productAccList.get(j);
					int accNo = productAcc.getAccNo();
					int accCnt = productAcc.getAccCnt();
%>
			
					// 수량 setting
					var accNoList = document.getElementsByName("txtAccNo");
					var accCntList = document.getElementsByName("txtAccCnt");
					
					var tot = accNoList.length;
					
					for (i = 0; i < tot; i++) {
						
						if(accNoList[i].value == '<%=accNo%>')
						{
						
							accCntList[i].value = '<%=accCnt%>';
						}
					}		
<%
				}//for
			}//if orderItemList
%>
		}//if(mode == "R")
	}//setPage
	
	
	function setSelectResult()
	{
		var str = "";
	    
	    var accNoList = document.getElementsByName("txtAccNo");
	    var accCntList = document.getElementsByName("txtAccCnt");
	    
	    var tot = accNoList.length;
	    
	    for (i = 0; i < tot; i++) {
   		
	    	// 악세서리 정보 setting
	    	if(!isNull(accCntList[i]) && accCntList[i].value != 0)
	    	{
	    		if(str == "")
	    			str = accNoList[i].value + ":" +  accCntList[i].value;
	    		else
	    			str = str + "/" + accNoList[i].value + ":" +  accCntList[i].value; // seperator | 는 사용하면 안됨. 변형되는지 split이 안돼 
	    	}
	    }
	    
		document.getElementById("orderStr").value = str;
	}
	
	
</script>
</head>

<body>
<center>

   		<div class="table-title"><h1>제품정보</h1></div>

		<form name="form1" method="post" action="productWrite.jsp?mode=<%= writeMode %>" onsubmit="return chkValid();">



		<table width = "300">
     				
    		<tr class="row_bottom_only">
				<td width="40%" class="cell-r" style="margin-left: 2px">모델명</td>
				<td width="60%" class="cell-l">
     				<select id=modelNo name=modelNo>
	     				<option value=''>선택</option>
		   				<%
					 		for(int i=0; i<modelLength; i++){
								Model model = modelList.get(i);
		     			%>
		      			    <option value=<%= model.getModelNo() %>><%= model.getModelNmEng() %></option>
		     			<%
		     				}
		     			%>
     				</select>
				</td>
			</tr>
			
    		<tr class="row_bottom_only">
				<td width="40%" class="cell-r">제품일련번호</td>
				<td width="60%" class="cell-l">
	<% if(mode.equals("C")) { %>   
					<input type=text name=serialNo id=serialNo size=10 value='' >
	<% } else { %>
					<input type=text name=serialNo id=serialNo size=10 value='<%= product.getSerialNo() %>' >
	<% } %>   		
				</td>
			</tr>
    		<tr class="row_bottom_only">
				<td width="40%" class="cell-r">제작일자</td>
				<td width="60%" class="cell-l">
	<% if(mode.equals("C")) { %>   
					<input type=date name=prodDt id=prodDt size=15 value='' >
	<% } else { %>
					<input type=date name=prodDt id=prodDt size=15 value='<%= product.getProdDt() %>' >
	<% } %>   		
				</td>
			</tr>
			
		
			
    		<tr class="row_bottom_only">
				<td width="40%" class="cell-r">인증 검사일자</td>
				<td width="60%" class="cell-l">
	<% if(mode.equals("C")) { %>   
					<input type=date name=certDt id=certDt size=20 value='' >
	<% } else { %>
					<input type=date name=certDt id=certDt size=20 value='<%= product.getCertDt() %>' >
	<% } %>   		
				</td>
			</tr>
			
    		<tr class="row_bottom_only">
				<td width="40%" class="cell-r">기체번호 (항공청 등록번호)</td>
				<td width="60%" class="cell-l">
	<% if(mode.equals("C")) { %>   
					<input type=text name=registerNo id=registerNo size=10 value='' >
	<% } else { %>
					<input type=text name=registerNo id=registerNo size=10 value='<%= product.getRegisterNo() %>' >
	<% } %>   		
				</td>
			</tr>

    		<tr class="row_bottom_only">
     			<td class="cell-r">고객명</td>
     			<td class="cell-l">
     				<select id=clientNo name=clientNo>
	     				<option value="0">선택</option>
		   				<%
					 		for(int i=0; i<clientLength; i++){
								Client client = clientList.get(i);
		     			%>
		      			    <option value=<%= client.getClientNo() %>><%= client.getClientNm() %></option>
		     			<%
		     				}
		     			%>
     				</select>
     			</td>
     		</tr>

<!--  2017.10. 추가 컬럼  -->
    		<tr class="row_bottom_only">
				<td class="cell-r">제품원가</td>
				<td class="cell-l">
	<% if(mode.equals("C")) { %>   
					<input type=text name=productCost id=productCost size=15 
						onKeypress="if(event.keyCode < 48 || event.keyCode > 57) event.returnValue = false;"
						value='' >
	<% } else { %>
					<input type=text name=productCost id=productCost size=15 
						onKeypress="if(event.keyCode < 48 || event.keyCode > 57) event.returnValue = false;"
						value='<%= product.getProductCost() %>' >
	<% } %>   		
				</td>
			</tr>
    		<tr class="row_bottom_only">
				<td class="cell-r">매출일자</td>
				<td class="cell-l">
	<% if(mode.equals("C")) { %>   
					<input type=date name=salesDt id=salesDt size=20 value='' >
	<% } else { %>
					<input type=date name=salesDt id=salesDt size=20 value='<%= product.getSalesDt() %>' >
	<% } %>   		
				</td>
			</tr>
    		<tr class="row_bottom_only">
				<td class="cell-r">매출액</td>
				<td class="cell-l">
	<% if(mode.equals("C")) { %>   
					<input type=text name=salesAmt id=salesAmt size=15 
						onKeypress="if(event.keyCode < 48 || event.keyCode > 57) event.returnValue = false;"
						value='' >
	<% } else { %>
					<input type=text name=salesAmt id=salesAmt size=15 
						onKeypress="if(event.keyCode < 48 || event.keyCode > 57) event.returnValue = false;"
						value='<%= product.getSalesAmt() %>' >
	<% } %>   		
				</td>
			</tr>
    		<tr class="row_bottom_only">
				<td class="cell-r">추가매출액</td>
				<td class="cell-l">
	<% if(mode.equals("C")) { %>   
					<input type=text name=addSalesAmt id=addSalesAmt size=15 
						onKeypress="if(event.keyCode < 48 || event.keyCode > 57) event.returnValue = false;"
						value='' >
	<% } else { %>
					<input type=text name=addSalesAmt id=addSalesAmt size=15 
						onKeypress="if(event.keyCode < 48 || event.keyCode > 57) event.returnValue = false;"
						value='<%= product.getAddSalesAmt() %>' >
	<% } %>   		
				</td>
			</tr>
    		<tr class="row_bottom_only">
				<td class="cell-r">입금일자</td>
				<td class="cell-l">
	<% if(mode.equals("C")) { %>   
					<input type=date name=payDt id=payDt size=20 value='' >
	<% } else { %>
					<input type=date name=payDt id=payDt size=20 value='<%= product.getPayDt() %>' >
	<% } %>   		
				</td>
			</tr>
    		<tr class="row_bottom_only">
				<td class="cell-r">입금액</td>
				<td class="cell-l">
	<% if(mode.equals("C")) { %>   
					<input type=text name=payAmt id=payAmt size=15 
						onKeypress="if(event.keyCode < 48 || event.keyCode > 57) event.returnValue = false;"
						value='' >
	<% } else { %>
					<input type=text name=payAmt id=payAmt size=15 
						onKeypress="if(event.keyCode < 48 || event.keyCode > 57) event.returnValue = false;"
						value='<%= product.getPayAmt() %>' >
	<% } %>   		
				</td>
			</tr>
    		<tr class="row_bottom_only">
				<td class="cell-r">외상매출액</td>
				<td class="cell-l">
	<% if(mode.equals("C")) { %>   
					<input type=text name=creditSalesAmt id=creditSalesAmt size=15 
						onKeypress="if(event.keyCode < 48 || event.keyCode > 57) event.returnValue = false;"
						value='' >
	<% } else { %>
					<input type=text name=creditSalesAmt id=creditSalesAmt size=15 
						onKeypress="if(event.keyCode < 48 || event.keyCode > 57) event.returnValue = false;"
						value='<%= product.getCreditSalesAmt() %>' >
	<% } %>   		
				</td>
			</tr>
    		<tr class="row_bottom_only">
				<td class="cell-r">엑세서리</td>
				<td class="cell-l">
					<table style="width:300px;" border=0>
					
						<%
							for (int i = 0; i < accLength; i++) {
								Accessory acc = accList.get(i);
						%>
		
								<tr id="order_item_info">
									<td width=10></td>
									<td width=140><input type=hidden name="txtAccNo" value=<%=acc.getAccNo()%>><%=acc.getAccNm()%></td>
									<td class="cell-l">
										<input type="text" name="txtAccCnt" size=3
											style="text-align: right" onchange="setSelectResult();"
											onKeypress="if(event.keyCode < 48 || event.keyCode > 57) event.returnValue = false;" /> 개
									</td>
								</tr>
						<%
							} //for (int i = 0; i < accLength; i++) {
						%>
				
					</table>
					<input type="hidden" id="orderStr" name="orderStr" />
				</td>
			</tr>
    		<tr class="row_bottom_only">
				<td class="cell-r">비고</td>
				<td class="cell-l">
	<% if(mode.equals("C")) { %>   
					<textarea rows="3" cols="10" name="note" style="width:300;"></textarea>
	<% } else { %>
					<textarea rows="3" cols="10" name="note" style="width:300;"><%= product.getNote() %></textarea>
	<% } %>   		
				</td>
			</tr>
 

			
			<tr height="30"/></tr>
		</table>
		
		<table>
    		<tr height="40" valign="bottom">
     			<td colspan="2">
     				<div align="center">
     				<% if(mode.equals("C")) { %>
     					<input type="submit" class="dtlBtn" value="등록">&nbsp;
     				<% }else if(mode.equals("R") && (authLvl.equals("S") || authLvl.equals("A"))) { %>
     					<input type="submit" class="dtlBtn" value="수정">&nbsp;
     				<% } %>
     				<% if(userId.equals("bona")) { %>
     					<input type="button" class="dtlBtn" value="삭제" onclick="confirmDelete();">&nbsp;
     				<% } %>
         				<input type="button" class="dtlBtn" value="목록" onclick="moveTo('productList.jsp?pg=<%=pg %>');">
         			</div>
     			</td>
    		</tr>
		</table>
		<input type=hidden name=productNo id=productNo value='<%= productNo %>' >    		 
	</form> 
</center>
<script>
	setPage();
	setSelectResult();
</script>
</body>
</html>

