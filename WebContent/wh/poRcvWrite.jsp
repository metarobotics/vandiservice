<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" %>
<% request.setCharacterEncoding("EUC-KR"); %>
<%@ page import = "java.sql.*" %>                    <!-- JSP���� JDBC�� ��ü�� ����ϱ� ���� java.sql ��Ű���� import �Ѵ� -->
<%@ page import="java.util.*" %>
<%@ page import="wh.*" %>
<jsp:useBean id="orderPDao" class="wh.OrderPDAO"/>
<jsp:useBean id="itemDao" class="wh.ItemDAO"/>

<%
response.setContentType("text/html;charset=EUC-KR");
	
	// session 
	String userId = (String)session.getAttribute("userId");
	int userWhNo =  (Integer)session.getAttribute("whNo"); // ���� ���Ŵ� mr 0�� ����ϳ� Ȯ�强�� ���Ͽ� ���ǰ����� ������. �� super�� ��� mr�̶�� ����.

	
	//parameter
	String mode = request.getParameter("mode"); //CUD
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
			// ���� �ٲ�� �ȵ�. 
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
		
		// ���� �ٲ�� �ȵ�. 
		orderPDao.minusWhItemCnt(orderNo, rcvSeq, userId);
		orderPDao.deleteOrderPRcvItem(orderNo, rcvSeq);
		
		orderPDao.deleteOrderPRcv(orderNo, rcvSeq);
	}
	
%>
<script>
	alert("<%= modeStr %>�Ǿ����ϴ�.");
	opener.parent.location.reload();
	window.close();
</script>