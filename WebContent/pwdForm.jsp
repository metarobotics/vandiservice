<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>VANDI Service - Change Password</title>
<link rel="stylesheet" href="css/vandiservice.css">

<script>
function chk(f)
{
    if(f.id.value==""){
		alert("id..");
		f.id.focus();
		return false;
	}

    if(f.oldPwd.value=="")
    {
		alert("old password..");
		f.oldPwd.focus();
		return false;
	} 
	
    if(f.newPwd.value=="")
    {
		alert("new password..");
		f.newPwd.focus();
		return false;
	} 
	
    return true;
}

</script>
</head>
<body onload="javascript:document.frm.id.focus()">

<div class="div_centered">
  <div class="form">
    <form name=form_login class="form_login" action="pwdChange.jsp" method="post" onSubmit="return chk(this)">
	  <p class="message_h1">VANDI service</p>
      <p><input id="form_login" type="text" placeholder="ID" name="id"></p>
      <p><input class="input_style" type="password" placeholder="Old Password" name="oldPwd"></p>
      <p><input class="input_style" type="password" placeholder="New Password" name="newPwd"></p>
      <p><button class="submit_style" type="submit">Change Password</button></p>
    </form>
  </div>
</div>
</body>
</html>
