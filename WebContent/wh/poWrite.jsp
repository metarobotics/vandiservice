<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" %>
<%@ page import = "java.sql.*" %>                    <!-- JSP에서 JDBC의 객체를 사용하기 위해 java.sql 패키지를 import 한다 -->
<%@ page import="wh.*" %>
<%@ page import="java.util.*" %>

<jsp:useBean id="orderPDao" class="wh.OrderPDAO"/>
<jsp:useBean id="itemDao" class="wh.ItemDAO"/>

<%
	// request 
	request.setCharacterEncoding("UTF-8");
	
	//parameter
	String mode = request.getParameter("mode"); //CUD + A(Accept.작성완료), G(GET.입고처리), F(Finish.입고완료)
	String modeStr = "";
	if(mode.equals("C")) 
	{
		modeStr = "등록";
	}
	else if(mode.equals("U")) 
	{
		modeStr = "수정";
	}
	else if(mode.equals("D"))
	{
		modeStr = "삭제";
	}
	else if(mode.equals("A"))
	{
		modeStr = "작성완료";
	}
	else if(mode.equals("G"))
	{
		modeStr = "입고처리";
	}
	else if(mode.equals("F"))
	{
		modeStr = "입고완료";
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
	else if(mode.equals("A")) // 접수 
	{
		int orderNo = Integer.parseInt(request.getParameter("orderNo"));

		orderPDao.acceptOrderP(orderNo);
	}	
	else if(mode.equals("G")) // 입고처리 
	{
		int orderNo = Integer.parseInt(request.getParameter("orderNo"));

		orderPDao.getItemOrderP(orderNo);
	}	
	else if(mode.equals("F")) // 입고완료 
	{
		int orderNo = Integer.parseInt(request.getParameter("orderNo"));

		orderPDao.finishOrderP(orderNo);
	}	
	
%>
<script>
	alert("<%= modeStr %>되었습니다.");
	document.location.href="poList.jsp";
</script>