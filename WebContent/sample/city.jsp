<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    String cp = request.getContextPath();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="<%=cp%>/data/js/jquery-1.9.1.min.js"></script>

<script type="text/javascript">
$(function(){
	// 시도테이블의 리스트 가져오기
	var url="<%=cp%>/city/sidoList.action";
	var params="dumi="+new Date();
	
	$.ajax({
		type:"post"		// 포스트방식
		,url:url		// url 주소
		,data:params	//  요청에 전달되는 프로퍼티를 가진 객체
		,dataType:"json"
		,success:function(args){	//응답이 성공 상태 코드를 반환하면 호출되는 함수
			 for(var idx=0; idx<args.data.length; idx++) {
				 $("#sido").append("<option value='"+args.data[idx].snum+"'>"+args.data[idx].sido+"</option>");
				 //id가 sido인 요소선택
				 //append로 기존 셀렉터로 선택된 요소 다음에 다음내용이 들어감
				 //<option value='0'>서울</option> 이런식으로 sido의 요소안에 자식으로 들어감
   // args.data[idx] : args 는 function(args)의 인자. data는 controller.java에서 json객체에 넣어준 key(여기서는 list가 값이 된다). [idx]는 list의 몇번쨰 데이터를 가져올지 배열을 나타냄
			 }
		}
	    ,error:function(e) {	// 이곳의 ajax에서 에러가 나면 얼럿창으로 에러 메시지 출력
	    	alert(e.responseText);
	    }
	});
});

function cityList() {
	var snum=$("#sido").val();	// ID가 sido인 요소의 값을 불러옴
	if(snum=="") {	                // snum에 ""가 선택되어있다면
		$("#city option").each(function() {	//ID가 city이며 option인 요소를 
			$("#city option:eq(1)").remove();	//city option의 1번째를 계속 삭제(0번째만 남기고 모두 지우게 된다) ,  eq : 지정된 index 번째의 엘리먼트 선택
		});

		//$("#city").append("<option value=''>::도시선ㅋ::</option>");	// 위의 반복문으로 모두 삭제되어 있으므로 추가해준다.
		// 위의 명령문은 바로의 위의 엘리먼트가 1이아닌 0이었을 때 사용하면 됨.
		return;
	}
	
	var url="<%=cp%>/city/cityList.action";
	var params="snum="+snum+"&dumi="+new Date();
	
	$.ajax({
		type:"post"
		,url:url	
		,data:params
		,dataType:"json"
		,success:function(args){
			$("#city option").each(function() {	//id가 city인 option요소에 적용할 반복문
				$("#city option:eq(0)").remove();	// city option의 0번째 항목이 없을때까지 0번쨰 항목을 지운다. (기존에 있는거 모두 지운다.)
			});

			 $("#city").append("<option value=''>::도시선택::</option>");	// 도시선택을 붙인다.
			 
			 for(var idx=0; idx<args.data.length; idx++) {	// 새로 가져온 데이터를 데이터 갯수만큼 반복해서 붙여준다.
				 $("#city").append("<option value='"+args.data[idx].cnum+"'>"+args.data[idx].city+"</option>");	
// append : 셀렉터로 선택된 놈의(여기서는 id가 city인 놈) 자식에게 계속 내용을 붙여준다. 기존 자식이 있다면 그 뒤에 붙여줌.
			 }
		}
	    ,error:function(e) {
	    	alert(e.responseText);
	    }
	});
}

//확인 버튼을 누르면 실행될 함수
function result() {	
	var snum=$("#sido").val();
	var cnum=$("#city").val();
	var sido=$("#sido :selected").text();
	var city=$("#city :selected").text();

	if(snum=="" || cnum=="")
		return;
	
	var s=sido+":"+snum+", "+city+":"+cnum;
	alert(s);
	
}
</script>

</head>
<body>

<select id="sido" onchange="cityList();">	<!-- onchange로 선택이 될때마다 cityList()실행 -->
  <option value="">::시도선택::</option>
</select>

<select id="city">
  <option value="">::도시선택::</option>
</select>

<input type="button" value=" 확인 " onclick="result();">

</body>
</html>


