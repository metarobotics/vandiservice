<%@ page language="java" contentType="text/html;charset=EUC-KR" %>
<% request.setCharacterEncoding("EUC-KR"); %>
<%@ page import = "java.sql.*" %>                    <!-- JSP에서 JDBC의 객체를 사용하기 위해 java.sql 패키지를 import 한다 -->
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
	
	Model model = null;
	ArrayList<ModelItem> modelItemList = null;
	int modelItemSize = 0;
	
	if(mode.equals("R"))
	{
		int modelNo = 1; //Integer.parseInt(request.getParameter("modelNo"));
	
		model = mrDao.getModelInfo(modelNo);
		modelItemList = mrDao.getModelItemList(modelNo);
		
		modelItemSize = modelItemList.size();
	}

%>

<script type="text/javascript">

	var mode = '<%= mode %>';
	//alert(mode);
/*
	function chkValid() {
		
		//alert(document.getElementById("modelNo").value);
		
		if(isNull(document.getElementById("modelNm")))
		{
			alert('고객명을 입력하세요.');
			return false;
		}
		
		return true;
	}

	function confirmDelete() {
		
		if(confirm('삭제하시겠습니까?'))
		{
			<% if(mode.equals("R")) { %>   
				//moveTo('modelDelete.jsp?modelNo=<%= model.getModelNo() %>');	
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
   		<div class="table-title"><h1>Model 상세</h1></div>
	<% } else { %>
   		<div class="table-title"><h1>Model 등록</h1></div>
	<% } %>   		
   	
 		<form name="form1" method="post" action="modelWrite_action.jsp?mode=<%= writeMode %>" onsubmit="return chkValid();">


		<table border=1 class='table-fill'>
    		<tr>
				<td width="30%" class="cell-hd">modelNo</td>
				<td width="70%" class="cell-l">
	<% if(mode.equals("C")) { %>   
					<input type=text size=10 disabled value='' >
					<input type=hidden name=modelNo id=modelNo value='' >
	<% } else { %>
					<input type=text size=10 disabled value='<%= MrUtil.getClientNoStr(model.getModelNo()) %>' >
					<input type=hidden name=modelNo id=modelNo value='<%= model.getModelNo() %>' >
	<% } %>   		
				</td>
			</tr>
    		<tr>
				<td width="30%" class="cell-hd">modelId</td>
				<td width="70%" class="cell-l">
	<% if(mode.equals("C")) { %>   
					<input type=text name=modelId id=modelId size=20 value='' >
	<% } else { %>
					<input type=text name=modelId id=modelId size=20 value='<%= model.getModelId() %>' >
	<% } %>   		
				</td>
			</tr>
    		<tr>
				<td width="30%" class="cell-hd">modelNmKor</td>
				<td width="70%" class="cell-l">
	<% if(mode.equals("C")) { %>   
					<input type=text name=modelNmKor id=modelNmKor size=20 value='' >
	<% } else { %>
					<input type=text name=modelNmKor id=modelNmKor size=20 value='<%= model.getModelNmKor() %>' >
	<% } %>   		
				</td>
			</tr>
    		<tr>
				<td width="30%" class="cell-hd">modelNmEng</td>
				<td width="70%" class="cell-l">
	<% if(mode.equals("C")) { %>   
					<input type=text name=modelNmEng id=modelNmEng size=20 value='' >
	<% } else { %>
					<input type=text name=modelNmEng id=modelNmEng size=20 value='<%= model.getModelNmEng() %>' >
	<% } %>   		
				</td>
			</tr>
    		<tr>
				<td width="30%" class="cell-hd">제품출시일</td>
				<td width="70%" class="cell-l">
	<% if(mode.equals("C")) { %>   
					<input type=text name=createDt id=createDt size=20 value='' >
	<% } else { %>
					<input type=text name=createDt id=createDt size=20 value='<%= model.getCreateDt() %>' >
	<% } %>   		
				</td>
			</tr>
   
			
			
			
			<!-- 
    		<tr>
				<td width="30%" class="cell-hd">등록자</td>
				<td width="70%" class="cell-l">
	<% if(mode.equals("C")) { %>   
					<input type=text name=insertUserId id=insertUserId size=20 disabled value='<%= (String)session.getAttribute("userId") %>' >
	<% } else { %>
					<input type=text name=insertUserId id=insertUserId size=20 disabled value='<%= model.getInsertUserId() %>' >
	<% } %>   		
				</td>
			</tr>
    		<tr>
				<td width="30%" class="cell-hd">등록일시</td>
				<td width="70%" class="cell-l">
	<% if(mode.equals("C")) { %>   
					<input type=text name=insertDatetime id=insertDatetime size=20 disabled value='javascript:today();' >
	<% } else { %>
					<input type=text name=insertDatetime id=insertDatetime size=20 disabled value='<%= model.getInsertDatetime() %>' >
	<% } %>   		
				</td>
			</tr>
			 -->
		</table>
		
		
	<!--  start of ModelItem List -->	
	 	<br><br>
	   <div class="table-title"><h3>Model Items</h3></div>
	   
		<table class="table-fill" width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr><td class="cell-r">total : <%= modelItemSize %></td></tr></table>
		<table class="table-fill" border="1">
		<tr class="header">
			<th width="10%" class="text-center">modelNo</th>
			<th width="10%" class="text-center">itemId</th>
			<th width="10%" class="text-center">itemCnt</th>
			<th width="30%" class="text-center">itemNm</th>
			<th width="40%" class="text-center">itemNmKr</th>
		</tr>
		<tbody class="table-hover">
		<%
			if(modelItemSize == 0) {
		%>
				<tr class="row">
			 	   <td colspan="6" class="cell-c">등록된 내역이 없습니다.</td>
				</tr>
			 <%
			 	} else {
			 		
			 		for(int i=0; i<modelItemSize;i++){
			 			
						ModelItem modelItem = modelItemList.get(i);
			//			indent = item.getIndent();
						/*int itemNo = item.getItemNo();
						String itemNm = item.getItemNm();
						String regUserId = item.getInsertUserId();
						String regDt = item.getInsertDatetime.toString();*/
		%>
		
		<tr class="row">
		<td class="cell-c"><%= modelItem.getModelNo() %></td>
		<td class="cell-c"><%= modelItem.getItemId() %></td>
		<td class="cell-c"><%= modelItem.getItemCnt() %></td>
		<td class="cell-c"><%= modelItem.getItemNm() %></td>
		<td class="cell-c"><%= modelItem.getItemNmKr() %></td>
		</tr>
		
		<%
		
			}}
		
		%>

		</table>		
	<!--  end of ModelItem List -->	
	
		
		
		
		
		<table>
    		<tr height="40" valign="bottom">
     			<td colspan="2">
     				<div align="center">
     				<% if(mode.equals("C")) { %>
     					<!--<input type="submit" class="myButton" value="등록">&nbsp;-->
     				<% }else{ %>
     					<!--  <input type="submit" class="myButton" value="수정">&nbsp;-->
     					<!--  <input type="button" class="myButton" value="삭제" onclick="confirmDelete();">&nbsp;-->
     				<% } %>
         				<!--  <input type="button" class="myButton" value="목록" onclick="moveTo('modelList.jsp?pg=<%=pg %>');">-->
         			</div>
     			</td>
    		</tr>
		</table>   		 
	</form> 
</center>
</body>
</html>