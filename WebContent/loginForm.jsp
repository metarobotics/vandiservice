<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/vandiservice.css">

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
		//String authLvl =  (String)session.getAttribute("authLvl");
%>
		<script>
			document.location.href = "./wh/itemList.jsp";
		</script>
<% 

	}
	
%>

<div class="div_centered">
  <div class="form">
    <form name=form_login class="form_login" action="login.jsp" method="post" onSubmit="return chk(this)">
<!--
      <p class="message">Already registered? <a href="#">Sign In</a></p>
-->
	  <p class="message_h1">VANDI service</p>
      <p><input id="form_login" type="text" placeholder="ID" name="id"></p>
      <p><input class="input_style" type="password" placeholder="Password" name="pwd"></p>
      <p><button class="submit_style" type="submit">Sign in</button></p>
    </form>
    <form class="register-form">
      <p class="message_h2"><a href="#" onclick="window.open('pwdForm.jsp');">Change Password</a></p>
    <p></p>
<!--
    <form class="register-form" action="register.jsp" method="post" onSubmit="return chk(this)">
      <p class="message_h2">Not registered? <a href="#">Create an account</a></p>
-->
<!--
      <input type="text" placeholder="id">
      <input type="password" placeholder="pwd">
      <input type="text" placeholder="email address">
      <button>create</button>
-->
    </form>
  </div>
</div>
</body>
</html>
