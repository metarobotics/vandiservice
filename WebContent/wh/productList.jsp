<%@ page language="java" contentType="text/html;charset=EUC-KR" %>
<% request.setCharacterEncoding("EUC-KR"); %>
<%@ page import="java.sql.*" %>                    <!-- JSP에서 JDBC의 객체를 사용하기 위해 java.sql 패키지를 import 한다 -->
<%@ page import="java.util.*" %>
<%@ page import="wh.*" %>
<jsp:useBean id="dao" class="wh.ProductDAO"/>
<jsp:useBean id="mrDao" class="wh.MrDAO"/>
<jsp:include page = "top.jsp"/>

<%	
	String authLvl =  (String)session.getAttribute("authLvl");
	if (authLvl == null) return;
//	if(authLvl.equals("S") || authLvl.equals("A")) // 등록,수정 권한자

	ArrayList<Model> modelList = mrDao.getModelList();
	int modelLength = modelList.size();

	String strParamModelNo = request.getParameter("modelNo");
	int intParamModelNo = 0;
	if(strParamModelNo != null){
		intParamModelNo = Integer.parseInt(strParamModelNo);
	}

	ArrayList<Product> alist = null; 
	if(intParamModelNo == 0)
	{
		alist = dao.getProductList();
	}
	else
	{
		alist = dao.getProductList(intParamModelNo);
	}
	
	int productListSize = alist.size();
	
	int size = alist.size();
	int size2 = size;
	
	final int ROWSIZE = 100;
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
	
	allPage = (int)Math.ceil(productListSize/(double)ROWSIZE);
	
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
 	<link rel="stylesheet" href="../css/vandiservice.css">
 	
<script>
function onChangeModel() {
	var x = document.getElementById("modelNo").value;
	if(x > 0)
	{
		window.location='productList.jsp?modelNo='+ x;
	}
	else
	{
		window.location='productList.jsp';
	}
}

</script> 	
</head>

<body>
<center>
   <div class="table-title"><h1>제품목록</h1></div>

<table>
<tr>
	<td width="50%" class="cell-l">모델명 &nbsp; 
		<select id=modelNo name=modelNo onchange="onChangeModel()">
				<option value=''>전체</option>
			<%
				for(int i=0; i<modelLength; i++){
					Model model = modelList.get(i);
					
					if(intParamModelNo != 0 && intParamModelNo == model.getModelNo()) {					
 			%>
  				    	<option value=<%= model.getModelNo() %> selected><%= model.getModelNmEng() %></option>
			<% 		} else { %>  				    
  				    	<option value=<%= model.getModelNo() %>><%= model.getModelNmEng() %></option>
 			<%
					}
				}
 			%>
		</select>
	</td>
	<td class="cell-r">total : <%= size %></td>
</tr>
<tr height="10"></tr>
</table>

<table border="1" width="600">
	<tr class="header">
		<th width="23%" class="text-center">제품일련번호</th>
		<th width="16%" class="text-center">제작일자</th>
		<th width="13%" class="text-center">기체번호</th>
		<th width="22%" class="text-center">납품처</th>
		<th width="10%" class="text-center">지역</th>
		<th width="16%" class="text-center">검사일자</th>
	</tr>
	
	<%
		if(productListSize==0) {
	%>
			<tr class="row">
		 	   <td colspan="6" class="cell-c">등록된 내역이 없습니다.</td>
			</tr>
	<%
	 	} else {
	 		for(int i=ROWSIZE*(pg-1); i<end;i++){
	 			Product product = alist.get(i);
	//			indent = item.getIndent();
				/*int itemNo = item.getItemNo();
				String itemNm = item.getItemNm();
				String regUserId = item.getInsertUserId();
				String regDt = item.getInsertDatetime.toString();*/
	%>
	
			<tr class="row">
				<td class="cell-c"><a href="productDtl.jsp?mode=R&productNo=<%=product.getProductNo()%>&pg=<%=pg%>"><%= product.getSerialNo() %></a></td>
				<td class="cell-c"><%=product.getProdDt()%></td>
				<td class="cell-c"><%=product.getRegisterNo()%></td>
				<td class="cell-c"><%=product.getClientNm()%></td>
				<td class="cell-c"><%=product.getClientLocation()%></td>
				<td class="cell-c"><%=product.getCertDt()%></td>
			</tr>

	<%
			}
		}
	%>

</table>
<table cellpadding="0" cellspacing="0" border="0">
	<tr height="10"/>
	<tr>
		<td align="center">
			<%
				if(pg>BLOCK) {
			%>
				[<a href="toList.jsp?pg=1">◀◀</a>]
				[<a href="toList.jsp?pg=<%=startPage-1%>">◀</a>]
			<%
				}
			%>
			
			<%
				for(int i=startPage; i<= endPage; i++){
					if(i==pg){
			%>
						<u><b>[<%=i %>]</b></u>
			<%
					}else{
			%>
						[<a href="toList.jsp?pg=<%=i %>"><%=i %></a>]
			<%
					}
				}
			%>
			
			<%
				if(endPage<allPage){
			%>
				[<a href="toList.jsp?pg=<%=endPage+1%>">▶</a>]
				[<a href="toList.jsp?pg=<%=allPage%>">▶▶</a>]
			<%
				}
			%>
		</td>
	</tr>
	<tr height="10"></tr>
	<tr>
		<%
		if(authLvl.equals("S") || authLvl.equals("A")) { // 등록,수정 권한자
		%>
	   		<td align="center"><input type=button class="dtlBtn" value="등록" OnClick="window.location='productDtl.jsp?mode=C&pg=<%=pg%>'"></td>
	   	<%} else { %>
	   	<%} %>
  	</tr>
</table>
</center>
</body>
</html>