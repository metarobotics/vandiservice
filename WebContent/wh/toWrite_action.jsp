<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" %>
<%@ page import = "java.sql.*" %>                    <!-- JSP���� JDBC�� ��ü�� ����ϱ� ���� java.sql ��Ű���� import �Ѵ� -->
<%@ page import="wh.*" %>
<%@ page import="java.util.*" %>

<jsp:useBean id="orderTDao" class="wh.OrderTDAO"/>
<jsp:useBean id="itemDao" class="wh.ItemDAO"/>

<%
	// request 
	request.setCharacterEncoding("UTF-8");
	
	//parameter
	String mode = request.getParameter("mode"); //CUD + A(Accept.����), S(Ship.�����), F(Finish.�Ϸ�)
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
	else if(mode.equals("A"))
	{
		modeStr = "����";
	}
	else if(mode.equals("S"))
	{
		modeStr = "���ó��";
	}
	else if(mode.equals("F"))
	{
		modeStr = "�Ϸ�";
	}
	
	
	if(mode.equals("C") || mode.equals("U")) 
	{
		
		int orderNo = 0;
		
		if(mode.equals("C")) 
		{
			orderNo = orderTDao.getNextOrderNo();
		}
		else //U,A
		{
			orderNo = Integer.parseInt(request.getParameter("orderNo"));
		}
		
		String orderDt = request.getParameter("orderDt").toString();
		
		
		out.print("\n1:"+request.getParameter("srcWh"));
		out.print("\n2:"+request.getParameter("destWh"));
		out.print("\n3:"+orderNo);
		out.print("\n4:"+Integer.parseInt(request.getParameter("subtotal")));
		//out.print("\n5:"+Integer.parseInt(request.getParameter("tax")));
		//out.print("\n6:"+Integer.parseInt(request.getParameter("totalAmt")));
		
		
		int srcWhId = Integer.parseInt(request.getParameter("srcWh"));
		int destWhId = Integer.parseInt(request.getParameter("destWh"));
		
		int subtotal = Integer.parseInt(request.getParameter("subtotal"));
		int tax = Integer.parseInt(request.getParameter("tax"));
		int totalAmt = Integer.parseInt(request.getParameter("totalAmt"));
		String note = request.getParameter("note").toString();
		
		String orderStr = request.getParameter("orderStr").toString(); // 1:3:25000|2:5:15000
		
		// session 
		String userId = (String)session.getAttribute("userId");
		
		//out.print(srcWhId +"<br>"+destWhId +"<br>"+ subtotal +"<br>"+ tax +"<br>"+ totalAmt +"<br>"+ orderStr + "<br>" + userId + "<br>");
	
		//
		// orderT
		//
		
		OrderT orderT = new OrderT(orderNo, orderDt, srcWhId, destWhId, null, subtotal, tax, totalAmt, note, userId, userId);
	
		if(mode.equals("C"))
		{
			orderTDao.insertOrderT(orderT); 
		} 
		else
		{
			orderTDao.modifyOrderT(orderT); 
		}
	
		
		//
		// orderItem
		//
		
		if(mode.equals("U"))
		{
			orderTDao.deleteOrderItem(orderNo);
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
			
			OrderItem orderItem = new OrderItem("T", orderNo, i+1, itemNo, itemCnt, itemPrice, userId); 
			orderTDao.insertOrderItem(orderItem);
		}
		
	}
	else if(mode.equals("D"))
	{
		int orderNo = Integer.parseInt(request.getParameter("orderNo"));

		orderTDao.deleteOrderT(orderNo);
		orderTDao.deleteOrderItem(orderNo);
	}
	else if(mode.equals("A")) // ���� 
	{
		int orderNo = Integer.parseInt(request.getParameter("orderNo"));

		orderTDao.acceptOrderT(orderNo);
	}	
	else if(mode.equals("S")) // ����� 
	{
		int orderNo = Integer.parseInt(request.getParameter("orderNo"));

		orderTDao.shipOrderT(orderNo);
	}	
	else if(mode.equals("F")) // �Ϸ� 
	{
		int orderNo = Integer.parseInt(request.getParameter("orderNo"));

		orderTDao.finishOrderT(orderNo);
	}	
	
%>
<script>
	alert("<%= modeStr %>�Ǿ����ϴ�.");
	document.location.href="toList.jsp";
</script>