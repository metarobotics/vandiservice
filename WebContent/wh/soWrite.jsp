<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" %>
<% request.setCharacterEncoding("EUC-KR"); %>
<%@ page import = "java.sql.*" %>                    <!-- JSP���� JDBC�� ��ü�� ����ϱ� ���� java.sql ��Ű���� import �Ѵ� -->
<%@ page import="java.util.*" %>
<%@ page import="wh.*" %>
<jsp:useBean id="orderSDao" class="wh.OrderSDAO"/>
<jsp:useBean id="itemDao" class="wh.ItemDAO"/>

<%
response.setContentType("text/html;charset=EUC-KR");

//parameter
String mode = request.getParameter("mode"); //CUD + F(Finish.Ȯ��)
String modeStr = "";
if(mode.equals("C")) 
{
	modeStr = "���";
}
else if(mode.equals("U")) 
{
	modeStr = "����";
}
else if(mode.equals("D"))
{
	modeStr = "����";
}
else if(mode.equals("F"))
{
	modeStr = "Ȯ��";
}

if(mode.equals("C") || mode.equals("U")) 
{
	
	int orderNo = 0;
	if(mode.equals("C")) 
	{
		orderNo = orderSDao.getNextOrderNo();
	}
	else //U
	{
		orderNo = Integer.parseInt(request.getParameter("orderNo"));
	}
	
	String orderDt = request.getParameter("orderDt").toString();
	int whNo = Integer.parseInt(request.getParameter("whNo"));
	String productSerialNo = request.getParameter("productEach").toString();
	
	int subtotal = Integer.parseInt(request.getParameter("subtotal"));
	int tax = Integer.parseInt(request.getParameter("tax"));
	int totalAmt = Integer.parseInt(request.getParameter("totalAmt"));
	String note = request.getParameter("note").toString();
/*
	if(note != null){
	out.print(note);
//	return;
}
*/
	String orderStr = request.getParameter("orderStr").toString(); // 1:3:25000|2:5:15000
	
	// session 
	String userId = (String)session.getAttribute("userId");
	
	//out.print(srcWhId +"<br>"+destWhId +"<br>"+ subtotal +"<br>"+ tax +"<br>"+ totalAmt +"<br>"+ orderStr + "<br>" + userId + "<br>");
	
	%>
	
	
	<%
	//
	// orderT
	//
	
	OrderS orderS = new OrderS(orderNo, orderDt, whNo, productSerialNo, null, subtotal, tax, totalAmt, note, userId, userId);
	
	if(mode.equals("C"))
	{
		orderSDao.insertOrderS(orderS); 
	} 
	else
	{
		orderSDao.modifyOrderS(orderS); 
	}

	
	//
	// orderSItem
	//
	
	if(mode.equals("U"))
	{
		orderSDao.deleteOrderSItem(orderNo);
	}
	
	int itemNo;
	int itemCnt;
	int itemPrice;
	float serviceHour;

	//out.print("<br><br>");
	
	List<String> strList = new ArrayList<String>(Arrays.asList(orderStr.split("/")));
	
	int len = strList.size();
			
	for(int i=0; i<len; i++)
	{
		String[] arr = strList.get(i).toString().split(":");	
		
		itemNo = Integer.parseInt(arr[0]);
		itemCnt = Integer.parseInt(arr[1]);
		itemPrice = Integer.parseInt(arr[2]);
		serviceHour = Float.parseFloat(arr[3]);
		
		OrderSItem orderSItem = new OrderSItem(orderNo, i+1, itemNo, itemCnt, itemPrice, serviceHour, userId);  
		orderSDao.insertOrderSItem(orderSItem);
	}
}
else if(mode.equals("D"))
{
	int orderNo = Integer.parseInt(request.getParameter("orderNo"));

	orderSDao.deleteOrderS(orderNo);
	orderSDao.deleteOrderSItem(orderNo);
}
else if(mode.equals("F")) // Ȯ�� 
{
	int orderNo = Integer.parseInt(request.getParameter("orderNo"));
	int whNo = Integer.parseInt(request.getParameter("whNo"));
	
	orderSDao.finishOrderS(orderNo, whNo);
}

%>
<script>
	alert("<%= modeStr %>�Ǿ����ϴ�.");
	document.location.href="soList.jsp";
</script>