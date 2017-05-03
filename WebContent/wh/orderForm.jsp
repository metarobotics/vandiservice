<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
String curPage = request.getParameter("curPage");
String keyword = request.getParameter("keyword");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문서 작성</title>
</head>
<body>
<h1>글쓰기</h1>
<form action="order.jsp" method="post">
<table>
<tr>
    <td>제목</td>
    <td><input type="text" name="title" size="50"></td>
</tr>
<tr>
    <td colspan="2">
        <textarea name="content" rows="20" cols="100"></textarea>
    </td>
</tr>
<tr>
    <td colspan="2">
        <input type="submit" value="전송">
        <input type="reset" value="취소">
        <a href="list.jsp?curPage=<%=curPage %>&keyword=<%=keyword %>">목록</a>
    </td>
</tr>
</table>
</form>
</body>
</html>