<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<title>VANDI inventory manager</title>
</head>

<frameset rows=100,*,300 bordercolor=7983d5 border="1"> 
	<frame src=top.jsp       name=top    id=top		scrolling=yes marginwidth=20 marginheight=15 noresize=no> 
	<frame src=loginForm.jsp name=center id=center 	scrolling=auto marginwidth=50 marginheight=30 noresize=yes> 
	<frame src=bottom.jsp    name=bottom id=bottom 	scrolling=yes marginwidth=0 marginheight=0 noresize=no> 
</frameset> 
<!-- 
<body style="font-size:12">
<%@ include file="/top.jsp"%>
<table height=100>
<tr><td></td></tr>
</table>
<%@ include file="/loginForm.jsp"%>
<table height=100>
<tr><td></td></tr>
</table>
<%@ include file="/bottom.jsp"%>
</body>
 -->
</html>

