<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js"></script>
    <title>회원가입</title>
    <style>
    	input[type="number"]::-webkit-outer-spin-button,
		input[type="number"]::-webkit-inner-spin-button {
		    -webkit-appearance: none;
		    margin: 0;
		}
    </style>
</head>

<body style="margin-bottom: 200px">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
    <div class="container mt-3" style="width:40%;">

        <div class="row mt-5">
            <div class="col-12 text-center">
                <h1>회원가입</h1>
            </div>
        </div>
        <div class="row mt-5">
            <div class="col-12 text-danger">
                ${error }
            </div>
        </div>
        <div class="row">
            <form id="frm" method="POST" action="${pageContext.request.contextPath}/user/register">
                <div class="form-group mt-3">
                    <label for="username">사용자 아이디</label>
                    <input type="text" class="form-control" id="username" name="username" placeholder="사용자아이디" value="${username }" required>
                </div>
                <div class="form-group mt-3">
                    <label for="name">사용자 이름</label>
                    <input type="text" class="form-control" id="name" name="name" placeholder="사용자 이름" value="${name }" required>
                </div>
                <div class="form-group mt-3">
                    <label for="password">비밀번호</label>
                    <input type="password" class="form-control" id="password" name="password" placeholder="비밀번호" required>
                </div>
                <div class="form-group mt-3">
                    <label for="re-password">비밀번호 확인</label>   <%-- binding 을 위해 hyphen 사용 자제 --%>
                    <input type="password" class="form-control" id="re_password" name="re_password" placeholder="비밀번호 확인" required>
                </div>
                <div class="form-group mt-3">
                    <label for="phonenum">휴대폰번호</label><br>
                	<input type="number" id="phonenum" name="phonenum" class="form-control w-50 d-inline-flex p-2" pattern="^(010|011|016|017|018|019)[0-9]{3,4}[0-9]{4}$" placeholder="예) 01012341234" value="${phonenum }" required/>
                	<span id="phoneChk" class="btn btn-outline-dark doubleChk ">인증번호 전송</span><br>
                	<input id="phone2" type="text" name="phone2" class="form-control d-inline-flex w-50" placeholder="인증번호 입력" required/>
					<span id="phoneChk2" class="btn btn-outline-dark doubleChk">본인인증 확인</span><br>
					<span class="point successPhoneChk"><b>휴대폰 번호 입력후 인증번호 전송을 눌러주세요</b></span>
					<input type="hidden" id="phoneDoubleChk"/>
                </div>
                <div class="form-group mt-3">
                	<input type="text" class="form-control d-inline-flex w-50" id="sample4_postcode" name="address1" placeholder="우편번호" disabled required>
					<input type="button" class="btn btn-outline-dark mb-1" onclick="sample4_execDaumPostcode()" value="우편번호 찾기"><br>
					<input type="text" class="form-control" id="sample4_roadAddress" name="address2" placeholder="도로명주소" size="60" disabled required><br>
					<input type="hidden" id="sample4_jibunAddress" placeholder="지번주소"  size="60">
					<span id="guide" style="color:#999;display:none"></span>
					<input type="text" class="form-control" id="sample4_detailAddress" name="address3" placeholder="상세주소"  size="60" required><br>
					<input type="hidden" id="sample4_extraAddress" placeholder="참고항목"  size="60">
					<input type="hidden" id="sample4_engAddress" placeholder="영문주소"  size="60" ><br>
                </div>
                <button type="button" onclick="frmsubmit()" class="w-100 btn btn-lg btn-primary mt-3">등록</button>
            </form>
        </div>
    </div>
</body>
<script>
//휴대폰 번호 인증
let code2 = "";
let checkNum = false;
$("#phoneChk").click(function(){
	
	if(($("#phonenum").val() == "")){
		alert("휴대폰 번호가 올바르지 않습니다.")
		$(".successPhoneChk").text("유효한 번호를 입력해주세요.");
		$(".successPhoneChk").css("color","red");
	}else if(!($("#phonenum").val() == "") && $("#phonenum").val().length == 11){
		alert("인증번호 발송이 완료되었습니다.\n휴대폰에서 인증번호 확인을 해주십시오.");
		var phone = $("#phonenum").val();
		$.ajax({
	        type:"GET",
	        url:"phoneCheck?phone=" + phone,
	        cache : false,
	        success:function(data){
	        	if(data == "error"){
	        		alert("휴대폰 번호가 올바르지 않습니다.")
					$(".successPhoneChk").text("유효한 번호를 입력해주세요.");
					$(".successPhoneChk").css("color","red");
					$("#phonenum").attr("autofocus",true);
	        	}else{	        		
	        		$("#phone2").attr("disabled",false);
	        		$("#phoneChk2").css("display","inline-block");
	        		$(".successPhoneChk").text("인증번호를 입력한 뒤 본인인증을 눌러주십시오.");
	        		$(".successPhoneChk").css("color","green");
	        		$("#phonenum").attr("readonly",true);
	        		code2 = data;
	        	}
	        }
	    });
	}else{
		alert("휴대폰 번호가 올바르지 않습니다.")
		$(".successPhoneChk").text("유효한 번호를 입력해주세요");
		$(".successPhoneChk").css("color","red")
	}
	
});

//휴대폰 인증번호 대조
$("#phoneChk2").click(function(){
	console.log(phoneChk2);
	
	if(code2.length <= 0 ){
		$("#phone2").attr("disabled",false);
		$("#phoneChk2").css("display","inline-block");
		$(".successPhoneChk").text("인증번호를 입력한 뒤 본인인증을 눌러주십시오.");
		$(".successPhoneChk").css("color","green");
	}
	else if(
		$("#phone2").val() == code2){
		$(".successPhoneChk").text("인증번호가 일치합니다.");
		$(".successPhoneChk").css("color","green");
		$("#phoneDoubleChk").val("true");
		$("#phone2").attr("disabled",true);
		checkNum = true;
	}else{
		$(".successPhoneChk").text("인증번호가 일치하지 않습니다. 확인해주시기 바랍니다.");
		$(".successPhoneChk").css("color","red");
		$("#phoneDoubleChk").val("false");
		$(this).attr("autofocus",true);
		return;
	}
});

</script>
<script>
	let frm = document.getElementById("frm");
	function frmsubmit() {
		if (checkNum == true) frm.submit();
		else alert("인증번호를 확인해 주세요");
	}
</script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
    function sample4_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample4_postcode').value = data.zonecode;
                document.getElementById("sample4_roadAddress").value = roadAddr;
                document.getElementById("sample4_jibunAddress").value = data.jibunAddress;
         
                document.getElementById("sample4_engAddress").value = data.addressEnglish;
                       
                // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
                if(roadAddr !== ''){
                    document.getElementById("sample4_extraAddress").value = extraRoadAddr;
                } else {
                    document.getElementById("sample4_extraAddress").value = '';
                }

                var guideTextBox = document.getElementById("guide");
                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                if(data.autoRoadAddress) {
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                    guideTextBox.style.display = 'block';

                } else if(data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
                    guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                    guideTextBox.style.display = 'block';
                } else {
                    guideTextBox.innerHTML = '';
                    guideTextBox.style.display = 'none';
                }
            }
        }).open();
    }
</script>
</html>



