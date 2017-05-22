<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" %>
<%@ page import = "java.sql.*" %>                    <!-- JSP���� JDBC�� ��ü�� ����ϱ� ���� java.sql ��Ű���� import �Ѵ� -->
<%@ page import="wh.*" %>
<%@ page import="java.util.*" %>
<jsp:useBean id="orderSDao" class="wh.OrderSDAO"/>
<jsp:useBean id="itemDao" class="wh.ItemDAO"/>

<%
// request 
request.setCharacterEncoding("UTF-8");

//parameter
String mode = request.getParameter("mode");
String modeStr;
if(mode.equals("C")) 
{
	modeStr = "���";
}
else //U
{
	modeStr = "����";
}

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
int centerId = Integer.parseInt(request.getParameter("center"));
String productSerialNo = request.getParameter("productEach").toString();

int subtotal = Integer.parseInt(request.getParameter("subtotal"));
int tax = Integer.parseInt(request.getParameter("tax"));
int totalAmt = Integer.parseInt(request.getParameter("totalAmt"));

String orderStr = request.getParameter("orderStr").toString(); // 1:3:25000|2:5:15000

// session 
String userId = (String)session.getAttribute("userId");

//out.print(srcWhId +"<br>"+destWhId +"<br>"+ subtotal +"<br>"+ tax +"<br>"+ totalAmt +"<br>"+ orderStr + "<br>" + userId + "<br>");

%>


<%
	//
	// orderT
	//
	
	OrderS orderS = new OrderS(orderNo, orderDt, centerId, productSerialNo, null, subtotal, tax, totalAmt, userId, userId);
	
	if(mode.equals("C"))
	{
		orderSDao.insertOrderS(orderS); 
	} 
	else
	{
		orderSDao.modifyOrderS(orderS); 
	}

	
	//
	// orderItem
	//
	
	if(mode.equals("U"))
	{
		orderSDao.deleteOrderItem(orderNo);
	}
	
	int itemNo;
	int itemCnt;
	int itemPrice;

	//out.print("<br><br>");
	
	List<String> strList = new ArrayList<String>(Arrays.asList(orderStr.split("/")));
	
	int len = strList.size();
			
	for(int i=0; i<len; i++)
	{
		String[] arr = strList.get(i).toString().split(":");	
		
		itemNo = Integer.parseInt(arr[0]);
		itemCnt = Integer.parseInt(arr[1]);
		itemPrice = Integer.parseInt(arr[2]);
		
		OrderItem orderItem = new OrderItem("S", orderNo, i+1, itemNo, itemCnt, itemPrice, userId); 
		orderSDao.insertOrderItem(orderItem);
	}
	
%>
<script>
	alert("<%= modeStr %>�Ǿ����ϴ�.");
	document.location.href="soList.jsp";
</script>