/*
chkSession();

function chkSession()
{
    <%
    	String userId =  (String)session.getAttribute("userId");
    %>
            alert('<%= userId %> ');
    <%
    
    	if( userId == null)
    	{
    %>
    		parent.document.location.href="index.jsp";
    <%
    	}
    %>
}
 */

function moveTo(url) {
	location.href = url;
}

function today() {

	var date = new Date();

	var year = date.getFullYear();
	var month = date.getMonth() + 1; // 0부터 시작하므로 1더함 더함
	var day = date.getDate();

	if (("" + month).length == 1) {
		month = "0" + month;
	}
	if (("" + day).length == 1) {
		day = "0" + day;
	}

	// alert("" + year + month + day);
	return "" + year + "-" + month + "-" + day;
}

// ---------------------------------------------
// 숫자 컴마 관련
// ---------------------------------------------

$(function() {

	var $input = $("#input");
	$input.on('keyup', function() {
		// 입력 값 알아내기
		var _this = this;
		numberFormat(_this)
	})

});

// 콤마 찍기
function comma(str) {
	str = String(str);
	return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
}

// 콤마 풀기
function uncomma(str) {
	str = String(str);
	return str.replace(/[^\d]+/g, '');
}

function numberFormat(obj) {
	obj.value = comma(uncomma(obj.value));
}

function setComma(obj) {
	obj.value = addComma(obj.value);
}

function addComma(dataValue) {
	isNumber(dataValue);
	var separateValue = Number(dataValue).toLocaleString('en');
	if (separateValue == 'NaN') {
		return '';
	}
	return separateValue;
}

function isNumber(checkValue) {
	checkValue = '' + checkValue;
	if (isNaN(checkValue) || checkValue == "") {
		alert('숫자만 입력해 주세요!!!');
		return;
	}
}
