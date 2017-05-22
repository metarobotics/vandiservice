<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
 
    <% 
    	String userId =  (String)session.getAttribute("userId");
    
    	if( userId == null)
    	{
    %>
      		<script>alert('session expired !'); </script>
    		<script>parent.document.location.href="../index.jsp";</script>
    <%
    	}
    	else
    	{
	%>     	
  			<script> 
  				//alert('valid');
  				//parent.document.location.href="../index.jsp;
  				//alert(parent.document.location.href);
  			</script>
	<%
    	}
    %>
