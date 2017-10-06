<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" %>
<%@ page import = "java.sql.*" %>                    <!-- JSP에서 JDBC의 객체를 사용하기 위해 java.sql 패키지를 import 한다 -->
<%@ page import="wh.*" %>
<%@ page import="common.*" %>
<%@ page import="java.util.*" %>
<jsp:useBean id="itemDao" class="wh.ItemDAO"/>
<jsp:useBean id="vendorDao" class="wh.VendorDAO"/>
<jsp:useBean id="commonDao" class="common.CommonDAO"/>
<jsp:include page = "top.jsp"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
 	<link rel="stylesheet" href="../css/vandiservice.css">
<script type="text/javascript" src="../js/mr.js"></script>

<%
	String userId =  (String)session.getAttribute("userId");

	String authLvl =  (String)session.getAttribute("authLvl");
	if (authLvl == null) return;
	//if(authLvl.equals("S") || authLvl.equals("A")) // 등록,수정 권한자
	
	String mode = request.getParameter("mode");
	String pg = request.getParameter("pg");

	String writeMode;
	if(mode.equals("C"))
		writeMode = "C";
	else // R
		writeMode = "U";
	
	ArrayList<Vendor> vendorList = vendorDao.getVendorList(); 
	int vendorLength = vendorList.size();
	
	ArrayList<Code> curCdList = commonDao.getCodeList("02");//화폐코드 
	int curCdLength = curCdList.size();
	
	Item item = null;
	int vendorNo = 0;
	String curCd = null; 
	
	if(mode.equals("R"))
	{
		int idx = Integer.parseInt(request.getParameter("idx"));
		
		item = itemDao.getItemInfo(idx);
		vendorNo = item.getVendorNo();
		curCd = item.getCurCd();
	}
	
%>

<script type="text/javascript">

	var mode = '<%=mode%>';
	
	//alert(mode);

	function chkValid() {
	
		if(document.getElementById("itemId").value == '')
		{
			alert('품목코드를 입력하세요.');
			return false;
		}
		else if(document.getElementById("itemId").value.length != 4)
		{
			alert('품목코드를 숫자 네자리로 입력하세요.');
			return false;
		}
		else if(document.getElementById("itemNm").value == '')
		{
			alert('품명(영어)을 입력하세요.');
			return false;
		}
		else if(document.getElementById("itemNmKor").value == '')
		{
			alert('품명(한글)을 입력하세요.');
			return false;
		}
		/*else if(document.getElementById("curCd").value != '' &&document.getElementById("curCd").value != 'WON' && document.getElementById("curCd").value != 'USD' && document.getElementById("curCd").value != 'YEN')
		{
			alert('화폐단위를 알맞게 입력하세요.');
			return false;
		}
		
		else if(document.getElementById("curCd").value == '')
		{
			alert('화폐단위를 입력하세요.');
			return false;
		}
		else if(document.getElementById("priceCenter").value == '')
		{
			alert('구매단가를 입력하세요.');
			return false;
		}
		else if(document.getElementById("priceClient").value == '')
		{
			alert('판매단가를 입력하세요.');
			return false;
		}
		else if(document.getElementById("serviceHour").value == '')
		{
			alert('공임시간을 입력하세요.(소수점 두자리까지 가능)');
			return false;
		}
		*/
		
		// 입력 안한 값들 기본 setting 
		if(document.getElementById("vendorNo").value == '')
			document.getElementById("vendorNo").value = 0;
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
		
		if(confirm('삭제하시겠습니까?'))
		{
			<% if(mode.equals("R")) { %>   
				moveTo('itemWrite.jsp?mode=D&itemNo=<%= item.getItemNo() %>');	
			<% } else { %>
			<% } %>
		}
	}
	
	function setPage()
	{
		if(mode == "R")
		{
			document.getElementById("vendorNo").value = '<%= vendorNo %>';
			document.getElementById("curCd").value = '<%= curCd %>';
		}//if(mode == "R")
	}//setPage
	
</script>

</head>
<body>
<center>

	<% if(mode.equals("R")) { %>   
   		<div class="table-title"><h1>자재정보</h1></div>
	<% } else { %>
   		<div class="table-title"><h1>자재등록</h1></div>
	<% } %>   		
	
	<form name="form1" method="post" action="itemWrite.jsp?mode=<%= writeMode %>" onsubmit="return chkValid();">
		<table>
		
    		<tr class="row_bottom_only">
				<td width="40%" class="cell-r">품목코드</td>
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
				<td width="40%" class="cell-r">품명(영어)</td>
				<td width="60%" class="cell-l">
	<% if(mode.equals("C")) { %>   
					<input type=text name=itemNm id=itemNm size=45 value='' >
	<% } else { %>
					<input type=text name=itemNm id=itemNm size=45 value='<%= item.getItemNm() %>' >
	<% } %>   		
				</td>
			</tr>
    		<tr class="row_bottom_only">
				<td width="40%" class="cell-r">품명(한글)</td>
				<td width="60%" class="cell-l">
	<% if(mode.equals("C")) { %>   
					<input type=text name=itemNmKor id=itemNmKor size=45 value='' >
	<% } else { %>
					<input type=text name=itemNmKor id=itemNmKor size=45 value='<%= item.getItemNmKor() %>' >
	<% } %>   		
				</td>
			</tr>
			
    		<tr class="row_bottom_only">
     			<td class="cell-r">벤더</td>
     			<td class="cell-l">
     				<select id=vendorNo name=vendorNo>
	     				<option value="0">선택</option>
		   				<%
					 		for(int i=0; i<vendorLength; i++){
								Vendor vendor = vendorList.get(i);
		     			%>
		      			    <option value=<%= vendor.getVendorNo() %>><%= vendor.getVendorNm() %></option>
		     			<%
		     				}
		     			%>
     				</select>
     			</td>
     		</tr>
     		
    		<tr class="row_bottom_only">
     			<td class="cell-r">화폐단위</td>
     			<td class="cell-l">
     				<select id=curCd name=curCd>
	     				<option value="0">선택</option>
		   				<%
					 		for(int i=0; i<curCdLength; i++){
								Code code = curCdList.get(i);
		     			%>
		      			    <option value=<%= code.getCd() %>><%= code.getCdNm() %></option>
		     			<%
		     				}
		     			%>
     				</select>
     			</td>
     		</tr>
     		     		
			<!-- ----------------------------------------------------------------------------------------------------------------- 극비 -->
			<!--  아래 가격 3개는 SUPER만 보여줌 !!! -->
<% if(authLvl.equals("S")) { %>			
    		<tr class="row_bottom_only">
				<td width="40%" class="cell-r"><font color="red">가격</font></td>
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
					<font color="red"> (Super 관리자에게만 공개)</font>
				</td>
			</tr>
    		<tr class="row_bottom_only">
				<td width="40%" class="cell-r"><font color="red">메타단가</font></td>
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
					<font color="red"> (Super 관리자에게만 공개)</font>
				</td>
			</tr>
    		<tr class="row_bottom_only">
				<td width="40%" class="cell-r"><font color="red">공장단가</font></td>
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
					<font color="red"> (Super 관리자에게만 공개)</font>
				</td>
			</tr>
<% } %>   		
			<!-- ----------------------------------------------------------------------------------------------------------------- 극비 -->

    		<tr class="row_bottom_only">
				<td width="40%" class="cell-r">구매단가</td>
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
				<td width="40%" class="cell-r">판매단가</td>
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
				<td width="40%" class="cell-r">공임시간</td>
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
				<td width="40%" class="cell-r">등록자</td>
				<td width="60%" class="cell-l">
	<% if(mode.equals("C")) { %>   
					<input type=text name=insertUserId id=insertUserId size=20 disabled value='<%= (String)session.getAttribute("userId") %>' >
	<% } else { %>
					<input type=text name=insertUserId id=insertUserId size=20 disabled value='<%= item.getInsertUserId() %>' >
	<% } %>   		
				</td>
			</tr>
    		<tr class="row_bottom_only">
				<td width="40%" class="cell-r">등록일시</td>
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
     					<input type="submit" class="dtlBtn" value="등록">&nbsp;
     				<% }else if(mode.equals("R") && authLvl.equals("S")) { %>
     					<input type="submit" class="dtlBtn" value="수정">&nbsp;
	     				<% if(userId.equals("bona")) { %>
     					 <input type="button" class="dtlBtn" value="삭제" onclick="confirmDelete();">&nbsp; 
	     				<% } %>
     				<% } %>
         				<input type="button" class="dtlBtn" value="목록" onclick="moveTo('itemList.jsp?pg=<%=pg%>');">
         			</div>
     			</td>
    		</tr>
		</table>    		 
	</form> 
</center>
<script>
	setPage();
</script>
</body>
</html>