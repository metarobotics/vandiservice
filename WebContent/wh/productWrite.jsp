<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" %>
<% request.setCharacterEncoding("EUC-KR"); %>
<%@ page import = "java.sql.*" %>                    <!-- JSP에서 JDBC의 객체를 사용하기 위해 java.sql 패키지를 import 한다 -->
<%@ page import="java.util.*" %>
<%@ page import="wh.*" %>
<jsp:useBean id="dao" class="wh.ProductDAO"/>

<%
response.setContentType("text/html;charset=EUC-KR");

//parameter
String mode = request.getParameter("mode");
String modeStr;
if(mode.equals("C")) 
{
	modeStr = "등록";
}
else if(mode.equals("U")) 
{
	modeStr = "수정";
}
else //D 
{
	modeStr = "삭제";
}
out.println(mode);

//session 
String userId = (String)session.getAttribute("userId");


Product product;

if(mode.equals("C") || mode.equals("U")) 
{
	int productNo = 0;
	if(mode.equals("C")) 
	{
		productNo = dao.getNextProductNo();
	}
	else //U
	{
		productNo = Integer.parseInt(request.getParameter("productNo"));
	}

	int modelNo = Integer.parseInt(request.getParameter("modelNo"));
	String serialNo = request.getParameter("serialNo").toString();
	String prodDt = request.getParameter("prodDt").toString();
	String certDt = request.getParameter("certDt").toString();
	String registerNo = request.getParameter("registerNo").toString();
	int clientNo = Integer.parseInt(request.getParameter("clientNo"));
	
	int productCost = Integer.parseInt(request.getParameter("productCost"));
	String salesDt = request.getParameter("salesDt").toString();
	int salesAmt = Integer.parseInt(request.getParameter("salesAmt"));
	int addSalesAmt = Integer.parseInt(request.getParameter("addSalesAmt"));
	String payDt = request.getParameter("payDt").toString();
	int payAmt = Integer.parseInt(request.getParameter("payAmt"));
	int creditSalesAmt = Integer.parseInt(request.getParameter("creditSalesAmt"));
	String note = request.getParameter("note").toString();

	String orderStr = request.getParameter("orderStr").toString(); // 1:3/2:5
	
	product = new Product(productNo, modelNo, serialNo, prodDt, certDt, registerNo, clientNo, productCost, salesDt, salesAmt, addSalesAmt, payDt, payAmt, creditSalesAmt, note, userId, null, userId, null);
	
	//-------------------------
	// product 
	//-------------------------
	
	if(mode.equals("C"))
	{
		dao.insertProduct(product); 
	} 
	else if(mode.equals("U")) 
	{
		//out.println(product.getModelNo());
		//out.println(product.getSerialNo());
			
		dao.modifyProduct(product); 
	}
	
	//-------------------------
	// productAccessory : delete & insert 
	//-------------------------
	
	if(mode.equals("U"))
	{
		dao.deleteProductAcc(productNo);
	}
	
	int accNo;
	int accCnt;

	List<String> strList = new ArrayList<String>(Arrays.asList(orderStr.split("/")));
	
	int len = strList.size();
			
	for(int i=0; i<len; i++)
	{
		String[] arr = strList.get(i).toString().split(":");	
		
		accNo = Integer.parseInt(arr[0]);
		accCnt = Integer.parseInt(arr[1]);
		
		ProductAcc productAcc = new ProductAcc(productNo, accNo, accCnt, userId); 
		dao.insertProductAcc(productAcc);
	}	
}
else //D
{
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	
	dao.deleteProduct(productNo); 
	dao.deleteProductAcc(productNo); 
}

%>
<script>
	alert("<%= modeStr %>되었습니다.");
	document.location.href="productList.jsp";
</script>