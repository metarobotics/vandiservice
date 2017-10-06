<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" %>
<% request.setCharacterEncoding("EUC-KR"); %>
<%@ page import="java.sql.*" %> <!-- JSP���� JDBC�� ��ü�� ����ϱ� ���� java.sql ��Ű���� import �Ѵ� -->
<%@ page import="java.util.*" %>
<%@ page import="wh.*" %>
<jsp:useBean id="itemDao" class="wh.ItemDAO"/>

<%
response.setContentType("text/html;charset=EUC-KR");

//parameter
String mode = request.getParameter("mode");
String modeStr;
boolean result = false;

if(mode.equals("C")) 
{
	modeStr = "���";
}
else if(mode.equals("U")) 
{
	modeStr = "����";
}
else //D 
{
	modeStr = "����";
}
//out.println(mode);

//session 
String userId = (String)session.getAttribute("userId");

Item item = null;

if(mode.equals("C") || mode.equals("U")) 
{
	int itemNo = 0;//PK
	if(mode.equals("C")) 
	{
		itemNo = itemDao.getNextItemNo();
	}
	else //U
	{
		itemNo = Integer.parseInt(request.getParameter("itemNo"));
	}
	
	String itemId = request.getParameter("itemId").toString();
	String itemNm = request.getParameter("itemNm").toString();
	String itemNmKor = request.getParameter("itemNmKor").toString();
	
	int vendorNo = Integer.parseInt(request.getParameter("vendorNo").toString());
	String curCd = request.getParameter("curCd").toString();
	
	float price = Float.parseFloat(request.getParameter("price").toString());
	int priceMeta = Integer.parseInt(request.getParameter("priceMeta").toString());
	int priceFactory = Integer.parseInt(request.getParameter("priceFactory").toString());

	int priceCenter = Integer.parseInt(request.getParameter("priceCenter").toString());
	int priceClient = Integer.parseInt(request.getParameter("priceClient").toString());
	float serviceHour = Float.parseFloat(request.getParameter("serviceHour").toString());
	
	item = new Item(itemNo, itemId, itemNm, itemNmKor, vendorNo, price, curCd, priceMeta, priceFactory, priceCenter, priceClient, serviceHour, userId, userId);

	if(mode.equals("C"))
	{
		result = itemDao.insertItem(item); 
	} 
	else
	{
		result = itemDao.modifyItem(item); 
	}
}
else //D
{
	int itemNo = Integer.parseInt(request.getParameter("itemNo"));
	
	itemDao.deleteItem(itemNo); 
	
	result = true;
}
%>
<script>

	if(<%= result %> == false) {
		alert("<%= modeStr %>�� �����Ͽ����ϴ�. ǰ���ڵ尡 �������� Ȯ���ϼ���.");
		history.back();
	} else {
		alert("<%= modeStr %>�Ǿ����ϴ�.");
		document.location.href="itemList.jsp";
	}
	
</script>