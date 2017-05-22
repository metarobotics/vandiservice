<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script>
function chk(f)
  {
     if(f.id.value==""){alert("id..");f.id.focus();return false;} //아이디의 값이 없음alert.focus주고
     if(f.password.value=="")
           {alert("password..");f.password.focus();return false;} //역시 패스워드도 마찬가지
     return true;
  }
</script>
</head>
 
<body onload="javascript:document.frm.id.focus()" >
<form name=frm method=post action="login_result.jsp" onSubmit="return chk(this)" >
<table>
     <Tr>
           <Td> I D </Td>
           <Td><input type=text name="id" size=20></Td>
     </Tr>
     <Tr>
          <Td>PassWord</Td>
          <Td><input type=password name="password" size=20></Td>
    </Tr>
    <Tr>
       <Td>
             <input type=submit value="로그인">
             <input type=button value="취소" onClick="javascript:location.href='/index.jsp'" >
             <input type=button value="가입" onClick="javascript:location.href='/register.jsp'" >
       </Td>
     </Tr>
  </table>
 </form>
    <%@ include file="../bottom.jsp"%>
</body>
</html>