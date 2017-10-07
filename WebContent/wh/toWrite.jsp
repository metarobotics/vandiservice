<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" %>
<% request.setCharacterEncoding("EUC-KR"); %>
<%@ page import = "java.sql.*" %>                    <!-- JSP에서 JDBC의 객체를 사용하기 위해 java.sql 패키지를 import 한다 -->
<%@ page import="java.util.*" %>
<%@ page import="wh.*" %>
<jsp:useBean id="orderTDao" class="wh.OrderTDAO"/>
<jsp:useBean id="itemDao" class="wh.ItemDAO"/>
<jsp:useBean id="itemStockHistDao" class="wh.ItemStockHistDAO"/>

<%
	// session 
	String userId = (String)session.getAttribute("userId");

	//parameter
	String mode = request.getParameter("mode"); //CUD + A(Accept.접수), S(Ship.배송중), F(Finish.완료)
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
		modeStr = "접수";
	}
	else if(mode.equals("S"))
	{
		modeStr = "배송처리";
	}
	else if(mode.equals("F"))
	{
		modeStr = "완료";
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
		
		
		//out.print("\n1:"+request.getParameter("srcWh"));
		//out.print("\n2:"+request.getParameter("destWh"));
		//out.print("\n3:"+orderNo);
		//out.print("\n4:"+Integer.parseInt(request.getParameter("subtotal")));
		
		//out.print("\n5:"+Integer.parseInt(request.getParameter("tax")));
		//out.print("\n6:"+Integer.parseInt(request.getParameter("totalAmt")));
		
		
		int srcWhNo = Integer.parseInt(request.getParameter("srcWh"));
		int destWhNo = Integer.parseInt(request.getParameter("destWh"));
		
		int subtotal = Integer.parseInt(request.getParameter("subtotal"));
		int tax = Integer.parseInt(request.getParameter("tax"));
		int totalAmt = Integer.parseInt(request.getParameter("totalAmt"));
		String note = request.getParameter("note").toString();
		
		String orderStr = request.getParameter("orderStr").toString(); // 1:3:25000/2:5:15000
		
		
		//out.print(srcWhNo +"<br>"+destWhNo +"<br>"+ subtotal +"<br>"+ tax +"<br>"+ totalAmt +"<br>"+ orderStr + "<br>" + userId + "<br>");
	
		//-------------------------
		// orderT
		//-------------------------
		
		OrderT orderT = new OrderT(orderNo, orderDt, srcWhNo, destWhNo, null, subtotal, tax, totalAmt, note, userId, userId);
	
		if(mode.equals("C"))
		{
			//out.print("[L] orderT note : " + note + " : " + orderT.getNote());
			orderTDao.insertOrderT(orderT);
		} 
		else
		{
			orderTDao.modifyOrderT(orderT); 
		}
	
		
		//-------------------------
		// orderItem
		//-------------------------
		
		if(mode.equals("U"))
		{
			orderTDao.deleteOrderTItem(orderNo);
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
			
			OrderTItem orderTItem = new OrderTItem(orderNo, i+1, itemNo, itemCnt, itemPrice, userId); 
			orderTDao.insertOrderTItem(orderTItem);
		}
		
	}
	else if(mode.equals("D"))
	{
		int orderNo = Integer.parseInt(request.getParameter("orderNo"));

		orderTDao.deleteOrderT(orderNo);
		orderTDao.deleteOrderTItem(orderNo);
	}
	else if(mode.equals("A")) // 접수 
	{
		int orderNo = Integer.parseInt(request.getParameter("orderNo"));

		orderTDao.acceptOrderT(orderNo);
	}	
	else if(mode.equals("S")) // 배송중 
	{
		int orderNo = Integer.parseInt(request.getParameter("orderNo"));

		orderTDao.shipOrderT(orderNo);
	}	
	else if(mode.equals("F")) // 완료 
	{
		int orderNo = Integer.parseInt(request.getParameter("orderNo"));
		int srcWhNo = Integer.parseInt(request.getParameter("srcWhNo"));

		// 배송완료 처리 가능여부 체크 - 출고지 재고가 주문수량보다 적으면 배송완료 불가. 그 전에 입고처리부터 해야함.  
		//if(orderTDao.chkFinishPossible(orderNo))
		//{
			orderTDao.finishOrderT(orderNo);
			
			// 배송완료시 자재재고history쌓기
			// beforCnt를 whItem에서 가져오므로 minusWhItemCnt와 순서 바뀌면 안됨. 
			orderTDao.writeItemStockHist(orderNo, srcWhNo, userId);
			
			// 창고 자재갯수 감소 
			orderTDao.minusWhItemCnt(orderNo, srcWhNo, userId);
		//}
		//else
		//{
		//	returnVal = false;
			
			
			//<script>
			//alert("출고지 재고가 부족하여 배송완료 처리가 불가능합니다.\n입고처리를 먼저 하여 재고를 올려주세요.");
			//window.history.back();
			//</script>
			
		//}
	}	
	
%>
<script>
		alert("<%= modeStr %>되었습니다.");
		document.location.href="toList.jsp";
</script>

