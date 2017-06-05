<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" %>
<%@ page import = "java.sql.*" %>                    <!-- JSP���� JDBC�� ��ü�� ����ϱ� ���� java.sql ��Ű���� import �Ѵ� -->
<%@ page import="wh.*" %>
<%@ page import="java.util.*" %>

<jsp:useBean id="orderPDao" class="wh.OrderPDAO"/>
<jsp:useBean id="itemDao" class="wh.ItemDAO"/>

<%
	// request 
	request.setCharacterEncoding("UTF-8");
	
	//parameter
	String mode = request.getParameter("mode"); //CUD + A(Accept.�ۼ��Ϸ�), G(GET.�԰�ó��), F(Finish.�԰�Ϸ�)
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
		modeStr = "�ۼ��Ϸ�";
	}
	else if(mode.equals("G"))
	{
		modeStr = "�԰�ó��";
	}
	else if(mode.equals("F"))
	{
		modeStr = "�԰�Ϸ�";
	}
	
	
	if(mode.equals("C") || mode.equals("U")) 
	{
		
		int orderNo = 0;
		
		if(mode.equals("C")) 
		{
			orderNo = orderPDao.getNextOrderNo();
		}
		else //U,A
		{
			orderNo = Integer.parseInt(request.getParameter("orderNo"));
		}
		
		String orderDt = request.getParameter("orderDt").toString();
		
		
		
		int whNo = Integer.parseInt(request.getParameter("whNo"));
		
		float totalAmt = Integer.parseInt(request.getParameter("totalAmt"));
		float subtotal = totalAmt; //Integer.parseInt(request.getParameter("subtotal"));
		float tax = 0; //Integer.parseInt(request.getParameter("tax"));
		
		String curCd = request.getParameter("curCd").toString(); 
		
		String orderStr = request.getParameter("orderStr").toString(); // 1:3:25000|2:5:15000

		out.print("\n1:"+request.getParameter("whNo"));
		out.print("\n2:"+orderNo);
		out.print("\n4:"+request.getParameter("curCd"));
		//out.print("\n5:"+Integer.parseInt(request.getParameter("tax")));
		

		
		// session 
		String userId = (String)session.getAttribute("userId");
		
		//out.print(srcWhId +"<br>"+destWhId +"<br>"+ subtotal +"<br>"+ tax +"<br>"+ totalAmt +"<br>"+ orderStr + "<br>" + userId + "<br>");
	
		//
		// orderP
		//
		
		OrderP orderP = new OrderP(orderNo, orderDt, whNo, null, subtotal, tax, totalAmt, curCd, userId, userId);
	
		if(mode.equals("C"))
		{
			orderPDao.insertOrderP(orderP); 
		} 
		else
		{
			orderPDao.modifyOrderP(orderP); 
		}
	
		
		//
		// orderItem
		//
		
		if(mode.equals("U"))
		{
			orderPDao.deleteOrderItem(orderNo);
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
			
			OrderItem orderItem = new OrderItem("P", orderNo, i+1, itemNo, itemCnt, itemPrice, userId); 
			orderPDao.insertOrderItem(orderItem);
		}
		
	}
	else if(mode.equals("D"))
	{
		int orderNo = Integer.parseInt(request.getParameter("orderNo"));

		orderPDao.deleteOrderP(orderNo);
		orderPDao.deleteOrderItem(orderNo);
	}
	else if(mode.equals("A")) // ���� 
	{
		int orderNo = Integer.parseInt(request.getParameter("orderNo"));

		orderPDao.acceptOrderP(orderNo);
	}	
	else if(mode.equals("G")) // �԰�ó�� 
	{
		int orderNo = Integer.parseInt(request.getParameter("orderNo"));

		orderPDao.getItemOrderP(orderNo);
	}	
	else if(mode.equals("F")) // �԰�Ϸ� 
	{
		int orderNo = Integer.parseInt(request.getParameter("orderNo"));

		orderPDao.finishOrderP(orderNo);
	}	
	
%>
<script>
	alert("<%= modeStr %>�Ǿ����ϴ�.");
	document.location.href="poList.jsp";
</script>