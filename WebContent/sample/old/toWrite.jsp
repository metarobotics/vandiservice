<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" %>
<%@ page import = "java.sql.*" %>                    <!-- JSP에서 JDBC의 객체를 사용하기 위해 java.sql 패키지를 import 한다 -->
<%@ page import="wh.*" %>
<%@ page import="java.util.*" %>
 
<jsp:useBean id="mrDao" class="wh.MrDAO"/>
<jsp:useBean id="itemDao" class="wh.ItemDAO"/>
<jsp:include page = "/loginChk.jsp"/>


<%	
	ArrayList<Wh> whlist = mrDao.getWhList();
	int whLength = whlist.size();

	ArrayList<Item> itemlist = itemDao.getItemList();
	int itemLength = itemlist.size();

	int maxItemCnt = 1;
	maxItemCnt++;
	out.print(maxItemCnt);
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/mr.css">
<script type="text/javascript" src="../js/mr.js"></script>
<script type="text/javascript" src="../js/chkValid.js"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.7.1.min.js"></script>

<script type="text/javascript">

	function move(url) {
		location.href=url;
	}
	
	function toWriteCheck() {
		
		var form = document.toWriteForm;
		
		if(isNull(form.srcWh))
		{
			alert('src 선택해');
			return false;
		}
		else if(isNull(form.destWh))
		{
			alert('dest 선택해');
			return false;
		}
		else if(form.srcWh.value == form.destWh.value)
		{
			alert("Source창고와 Destination창고는 같을 수 없습니다.");
			return false;
		}
		else if(isNull(form.item))
		{
			alert('item 선택해');
			//form.item.focus();
			return false;
		}
		else if(isNull(form.itemCnt))
		{
			alert('item 갯수 입력해');
			//form.itemCnt.focus();
			return false;
		}
		
		setItemSession();
		
		return true;
	}
	
	function setItemSession()
	{
		
	}
	
/*	
	function setItemPrice(obj)
	{
		alert(obj.id);//selItem
		alert(substring(obj.id, 7));
		var itemId = obj.value;
		
		
			int price;
		
			for(int i=0; i<itemLength;i++){
				Item item = itemlist.get(i);
				if(item.getItemId().equals(obj.value))
					price = item.getPriceCenter();
				else
					continue;
			}
		
		var price
		if(obj.value == '')
			form.getElementById("txtItemPrice"+substring(obj.id, 7)).value = 0;
		else
			form.getElementById("txtItemPrice"+substring(obj.id, 7)).value = 100;
	}
*/

 /*
		$("select").change(function () { 
			var str = ""; 
			$("select option:selected").each(function () { 
				str += $(this).text() + " "; 
			}); 
			$("div").text(str);
		}) 
		.change(); 
*/

		
	
</script>
</head>

<body>
<center>
   <div class="table-title"><h1>Transfer Order 등록</h1></div>

		<form name="toWriteForm" method="post" action="toWrite_action.jsp" onsubmit="return toWriteCheck();">


		<table border=1 class='table-fill'>
    		<tr>
				<td width="30%" class="cell-hd">작성자</td>
				<td width="70%" class="cell-l"><input type=text name=name size=10 disabled value=<%= (String)session.getAttribute("userId") %> ></td>
			</tr>
    		<!-- <tr>
				<td class="cell-hd">주문일자</td>
				<td class="cell-l"><input type=text name=name size=10 disabled value='javascript:today();'></td>
			</tr>-->
    		<tr>
     			<td class="cell-hd">Source Warehouse</td>
     			<td class="cell-l">
     				<select id=srcWh>
	     				<option value=''>선택</option>
		   				<%
					 		for(int i=0; i<whLength;i++){
								Wh wh = whlist.get(i);
		     			%>
		      			    <option value=<%= wh.getWhNo() %>><%= wh.getWhNm() %></option>
		     			<%
		     				}
		     			%>
     				</select>
     			</td>
    		</tr>
    		<tr>
     			<td class="cell-hd">Destination Warehouse</td>
     			<td class="cell-l">
     				<select id=destWh>
	     				<option value=''>선택</option>
		   				<%
					 		for(int i=0; i<whLength;i++){
								Wh wh = whlist.get(i);
		     			%>
		      			    <option value=<%= wh.getWhNo() %>><%= wh.getWhNm() %></option>
		     			<%
		     				}
		     			%>
     				</select>
     			</td>
     		</tr>
    		<tr>
     			<td class="cell-hd">Item</td>
     			<td class="cell-l">
						<h3 align="left">
						    <a href="#" id="addItem">Add Item</a>
						</h3>
						<table class="dynatable" width="600" border=0>
						    <thead>
						        <tr>
						            <th width="500">Item</th>
						            <th width="100">수량</th>
						        </tr>
						    </thead>
						    <tbody id="p_item">
						        <tr>
						            <td>
					     				<select style="width:400;" id=selItem1 ><!-- onChange="javascript:setItemPrice(this)" -->
						     				<option value="">선택</option>
							   				<%
										 		for(int i=0; i<itemLength;i++){
													Item item = itemlist.get(i);
							     			%>
							      			    <option value=<%= item.getItemNo() %>>[<%= item.getItemId() %>] <%= item.getItemNm() %></option>
							     			<%
							     				}
							     			%>
					     				</select>
						            </td>
					<!--  	            <td>
						                <input type="text" id="txtItemPrice1" disabled />
						            </td>-->
						            <td>
						                <input type="text" id="txtItemCnt1" onKeypress="if(event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;" style="IME-MODE:disabled;"/>
						            </td>
						        </tr>
						    </tbody>
						</table>
     			</td>
    		</tr>
		</table>
		<table>
    		<tr height="40" valign="bottom">
     			<td colspan="2"><div align="center">
     			<input type="hidden" id="maxItemCnt" value=<%= maxItemCnt %>>
     			<input type="submit" value="등록">
         		<input type="button" value="목록" onclick="move('toList.jsp');"></div>
     			</td>
    		</tr>
		</table>    		 
	</form> 
</center>
<script>

var scntDiv = $('#p_item');

var i = $('#p_item tr').size();

$('#addItem').click(function() {
	
    i++;
	
<% 
maxItemCnt++;
out.print(maxItemCnt);
%>
alert('<%= maxItemCnt++ %>');


	var tags = '\
        <tr>\
		    <td>\
					<select style="width:400px;" id=selItem<%=maxItemCnt%>>\
						<option value="">선택</option>\
						<%
				 		for(int j=0; j<itemLength;j++){
							Item item = itemlist.get(j);
		 			%>\
		  			    <option value=<%= item.getItemNo() %>>[<%= item.getItemId() %>] <%= item.getItemNm().replaceAll("'","\"") %></option>\
		 			<%
		 				}
		 			%>\
					</select>\
		    </td>\
		    <td>\
		        <input type="text" id="txtItemCnt<%=maxItemCnt%>" onKeypress="if(event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;" style="IME-MODE:disabled;"/>\
		    </td>\
		    <td><a href="#" id="remItem">Remove</a></td></tr>\
		</tr>\
	';
	
	scntDiv.append(tags);   
    return false;
});

//Remove button
$(document).on('click', '#remItem', function() {
    if (i > 1) {
        $(this).closest('tr').remove();
        i--;
        alert(i);
    }
    return false;
});


</script>
</body>
</html>