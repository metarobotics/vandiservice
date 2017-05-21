<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script>
function chk(f)
  {
     if(f.id.value==""){alert("id..");f.id.focus();return false;} 
     if(f.password.value=="")
           {alert("password..");f.password.focus();return false;} 
     return true;
  }

</script>
</head>
<body onload="javascript:document.frm.id.focus()">

<%	
	if(session.getAttribute("userId") != null)
	{
%>

<script>
	document.location.href = "./wh/itemList.jsp";
</script>

<% 

}
	
%>

<div>
  <div class="form">
    <form name=frm class="login-form" action="login.jsp" method="post" onSubmit="return chk(this)">
      <p class="message">Already registered? <a href="#">Sign In</a></p>
      <input type="text" placeholder="id" name="id">
      <input type="password" placeholder="pwd" name="pwd">
      <button type="submit">login</button>
    </form>
    <form class="register-form" action="register.jsp" method="post" onSubmit="return chk(this)">
      <p class="message">Not registered? <a href="#">Create an account</a></p>
      <input type="text" placeholder="id">
      <input type="password" placeholder="pwd">
      <input type="text" placeholder="email address">
      <button>create</button>
    </form>
  </div>
</div>
</body>
</html>
