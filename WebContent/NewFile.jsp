<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" %>
<%@ page import = "java.sql.*" %>                    <!-- JSP에서 JDBC의 객체를 사용하기 위해 java.sql 패키지를 import 한다 -->
<%@ page import="wh.*" %>
<%@ page import="java.util.*" %>
 
<jsp:useBean id="dao" class="wh.ItemDAO"/>
<jsp:include page = "/loginChk.jsp"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/mr.css">
<script type="text/javascript" src="../js/mr.js"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.7.1.min.js"></script>
</head>
<body>

</body>
</html>




JSP 현재 날짜 / 현재 시간 구하기
http://kwaknu.egloos.com/5223389
<%@ page import="java.util.*, java.text.*"  %>
<%
 java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyyMMddHHmmss");
 String today = formatter.format(new java.util.Date());
 out.println(today);
%>






//Item item = itemlist.get(i);%><option value=<%= item.getItemNo() %>>[<%= item.getItemId() %>]<%= item.getItemNm() %></option><%}%></select></td><td><input type="text" name="itemCnt" id="itemCnt" /></td><td><a href="#" id="remItem">Remove</a></td></tr>




	var tags = '\
        <tr>\
    <td>\
			<select name=item style="width:400px;" id=item>\
				<option value="">선택</option><%
		 		for(int i=0; i<itemLength;i++){
					Item item = itemlist.get(i);
 			%><option value=<%= item.getItemNo() %>>[<%= item.getItemId() %>]<%= item.getItemNm().replaceAll("'","\"") %></option><%}%></select></td><td>\
        <input type="text" name="itemCnt" id="itemCnt" />\
    </td>\
    <td><a href="#" id="remItem">Remove</a></td></tr>\
</tr>\
	';
	
	
	
	var tags = '
        <tr>
		    <td>
					<select name=item style="width:400px;" id=item>
						<option value="">선택</option>
						<%
				 		for(int i=0; i<itemLength;i++){
							Item item = itemlist.get(i);
		 			%>
		  			    <option value=<%= item.getItemNo() %>>[<%= item.getItemId() %>]&nbsp; <%= item.getItemNm().replaceAll("'","\"") %></option>
		 			<%
		 				}
		 			%>
					</select>
		    </td>
		    <td>
		        <input type="text" name="itemCnt" id="itemCnt" />
		    </td>
		    <td><a href="#" id="remItem">Remove</a></td></tr>
		</tr>
	';
	
	scntDiv.append(tags);   
	
	
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

			