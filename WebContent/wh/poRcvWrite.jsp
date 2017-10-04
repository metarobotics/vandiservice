<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" %>
<% request.setCharacterEncoding("EUC-KR"); %>
<%@ page import = "java.sql.*" %>                    <!-- JSP에서 JDBC의 객체를 사용하기 위해 java.sql 패키지를 import 한다 -->
<%@ page import="java.util.*" %>
<%@ page import="wh.*" %>
<jsp:useBean id="orderPDao" class="wh.OrderPDAO"/>
<jsp:useBean id="itemDao" class="wh.ItemDAO"/>

<%
response.setContentType("text/html;charset=EUC-KR");
	
	// session 
	String userId = (String)session.getAttribute("userId");
	int userWhNo =  (Integer)session.getAttribute("whNo"); // 현재 구매는 mr 0만 사용하나 확장성을 위하여 세션값으로 설정함. 단 super는 모두 mr이라고 가정.

	
	//parameter
	String mode = request.getParameter("mode"); //CUD
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
	
	if(request.getParameter("orderNo")==null || request.getParameter("orderNo")=="")
	{
		System.out.println("orderNoErr : " + request.getParameter("orderNo"));
		return;
	}
	
	int orderNo = Integer.parseInt(request.getParameter("orderNo"));
	int rcvSeq = 0;
	
	if(mode.equals("C") || mode.equals("U")) 
	{
		if(mode.equals("C")) 
		{
			rcvSeq = orderPDao.getNextOrderRcvSeq(orderNo);
		}
		else //U,A
		{
			rcvSeq = Integer.parseInt(request.getParameter("rcvSeq"));
		}
		
		String rcvDt = request.getParameter("rcvDt").toString();
		String note = request.getParameter("note").toString();
		
		String rcvStr = request.getParameter("rcvStr").toString(); // 1:3|2:5 (itemNo:itemCnt)
		
		//out.print(srcWhId +"<br>"+destWhId +"<br>"+ subtotal +"<br>"+ tax +"<br>"+ totalAmt +"<br>"+ orderStr + "<br>" + userId + "<br>");
	
		//
		// orderPRcv
		//
		
		OrderPRcv orderPRcv = new OrderPRcv(orderNo, rcvSeq, rcvDt, note, userId, userId);
	
		if(mode.equals("C"))
		{
			orderPDao.insertOrderPRcv(orderPRcv); 
			orderPDao.getItemOrderP(orderNo);
		} 
		else
		{
			orderPDao.modifyOrderPRcv(orderPRcv); 
		}
	
		
		//
		// orderPItem
		//
		
		if(mode.equals("U"))
		{
			// 순서 바뀌면 안됨. 
			orderPDao.minusWhItemCnt(orderNo, rcvSeq, userId);
			orderPDao.deleteOrderPRcvItem(orderNo, rcvSeq);
		}
		
		int itemNo;
		int itemCnt;
		float itemPrice;
	
		//out.print("<br><br>");
		
		List<String> strList = new ArrayList<String>(Arrays.asList(rcvStr.split("/")));
		
		int len = strList.size();
				
		for(int i=0; i<len; i++)
		{
			String[] arr = strList.get(i).toString().split(":");	
			
			itemNo = Integer.parseInt(arr[0]);
			itemCnt = Integer.parseInt(arr[1]);
			
			OrderPRcvItem rcvItem = new OrderPRcvItem(orderNo, rcvSeq, i+1, itemNo, itemCnt, userId, userId);
			rcvItem.setWhNo(userWhNo);

			orderPDao.insertOrderPRcvItem(rcvItem);
			orderPDao.addWhItemCnt(rcvItem);
		}
	}
	else if(mode.equals("D"))
	{
		rcvSeq = Integer.parseInt(request.getParameter("rcvSeq"));
		
		// 순서 바뀌면 안됨. 
		orderPDao.minusWhItemCnt(orderNo, rcvSeq, userId);
		orderPDao.deleteOrderPRcvItem(orderNo, rcvSeq);
		
		orderPDao.deleteOrderPRcv(orderNo, rcvSeq);
	}
	
%>
<script>
	alert("<%= modeStr %>되었습니다.");
	opener.parent.location.reload();
	window.close();
</script>