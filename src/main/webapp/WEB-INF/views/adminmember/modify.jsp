<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>회원 정보 수정 - 관리자</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/reset.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/header.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/mypage/member_update.css" />

<style type="text/css">
   .badge {
     background-color: black;
     color: white;
     font-size: 18px;
     padding: 5px 10px;
     border-radius: 5px;
     margin: 0px 10px;
   }
</style>

</head>
<body>

	<c:if test="${not empty msg}">
		<script>alert("${msg}");</script>
	</c:if>

	<!--<sec:authentication property="principal" var="pinfo" />-->
	<c:set var="phoneNumber" value="${member.phoneNumber}" />
	<c:set var="phone1" value="${fn:split(phoneNumber, '-')[0]}" />
	<c:set var="phone2" value="${fn:split(phoneNumber, '-')[1]}" />
	<c:set var="phone3" value="${fn:split(phoneNumber, '-')[2]}" />

	<fmt:formatDate value="${member.birthdate}" pattern="yyyy"
		var="birthYear" />
	<fmt:formatDate value="${member.birthdate}" pattern="MM"
		var="birthMonth" />
	<fmt:formatDate value="${member.birthdate}" pattern="dd"
		var="birthDay" />

	<jsp:include page="../main/header.jsp" />

	<div class="container">
		<h1>회원 정보 수정<span class="badge">관리자</span></h1>


		<form name="updateForm"
			action="${pageContext.request.contextPath}/adminmember/modify"
			method="post">	
			<sec:authorize access="isAuthenticated()">
				<input type="hidden" name="updatedBy"
					value='<sec:authentication property="principal.username"/>' />
			</sec:authorize>
			<div class="additional_info_table">			
				<h2 class="additional_info_table">회원인증</h2>
				<div class="form_row">
					<label>권한<span class="required">*</span></label>
					<c:set var="isAdmin" value="false" />
					<c:forEach var="auth" items="${member.authList}">
					    <c:if test="${auth.role eq 'ADMIN'}">
					        <c:set var="isAdmin" value="true" />
					    </c:if>
					</c:forEach>
					<div class="form_input">
					    <input type="radio" name="role" value="MEMBER" <c:if test="${!isAdmin}">checked</c:if>>
		        		<!-- <input type="radio" id="role" name="member_type" checked /> -->
		        		<label for="role">일반</label>
		        		<input type="radio" name="role" value="ADMIN" <c:if test="${isAdmin}">checked</c:if>>
  				        <!-- <input type="radio" id="role" name="member_auth" />-->
	        			<label for="role">관리자</label>
				    </div>
			    </div>
				<div class="form_row">
				    <label>계정활성<span class="required">*</span></label>
				    <div class="form_input">
				        <input type="radio" name="isDeleted" value="0" <c:if test="${member.isDeleted != 1}">checked</c:if> />
				        <label for="is_deleted">활성</label>
				        <input type="radio" name="isDeleted" value="1" <c:if test="${member.isDeleted == 1}">checked</c:if>/>
				        <label for="is_deleted">비활성</label>
				    </div>
			    </div>
			</div>
			<div class="additional_info_table">
				<h2 class="page-title">기본정보</h2>
				<div class="form_row">
					<input type="hidden" name="id" value="${member.id}" />
					<label for="userid">아이디 <span class="required">*</span></label>
					<div class="form_input">
						<input type="text" id="userid" name="customerId" value="${member.customerId}" />
						<p class="desc">(영문소문자/숫자, 4~16자)</p>						
					</div>
				</div>

				<div class="form_row">
					<label for="password">비밀번호 <span class="required">*</span></label>
					<div class="form_input">
						<input type="password" id="password" name="password" class="half_input" />
						<p class="desc">(영문 대소문자/숫자/특수문자 중 2가지 이상 조합, 10자~16자)</p>
						<p class="error_msg" id="pwError"></p> <!-- 메시지 영역 추가 -->
					</div>
				</div>

				<div class="form_row">
					<label for="passwordConfirm">비밀번호 확인 <span class="required">*</span></label>
					<div class="form_input">
						<input type="password" id="passwordConfirm" name="passwordConfirm" class="half_input" />
						<p class="error_msg" id="pwMatchError"></p> <!-- 확인 메시지 영역 추가 -->
					</div>
				</div>

				<div class="form_row">
					<label for="name">이름 <span class="required">*</span></label>
					<div class="form_input">
						<input type="text" id="name" name="customerName" class="half_input"
							value="${member.customerName}" />
					</div>
				</div>

				<div class="form_row">
					<label>주소 <span class="required">*</span></label>
					<div class="form_input">
						<div class="address_line">
							<input type="text" id="zipcode" name="zipcode"
								value="${member.zipcode}"  />
							<button type="button" class="btn_search"
								onclick="execDaumPostcode()">주소검색</button>
						</div>
						<input type="text" id="addr1" name="addr1" value="${member.addr1}"
							 /> <input type="text" id="addr2" name="addr2"
							value="${member.addr2}" />
					</div>
				</div>

				<div class="form_row">
					<label>휴대전화 <span class="required">*</span></label>
					<div class="form_input phone_wrap">
						<select class="phone_select" name="phone1">
							<option value="010"
								<c:if test="${phone1 == '010'}">selected</c:if>>010</option>
							<option value="011"
								<c:if test="${phone1 == '011'}">selected</c:if>>011</option>
							<option value="016"
								<c:if test="${phone1 == '016'}">selected</c:if>>016</option>
							<option value="017"
								<c:if test="${phone1 == '017'}">selected</c:if>>017</option>
							<option value="018"
								<c:if test="${phone1 == '018'}">selected</c:if>>018</option>
							<option value="019"
								<c:if test="${phone1 == '019'}">selected</c:if>>019</option>
						</select>
						<input type="text" class="phone_input" name="phone2" value="${phone2}" maxlength="4" /> 
						<input type="text" class="phone_input" name="phone3" value="${phone3}" maxlength="4" /> 
						<!-- <button type="button" id="sendCodeBtn">인증번호받기</button> -->
					</div>
						  <p class="success_msg" id="phoneConfirmMsg" style="display: none; margin-top: 6px;">인증번호 확인 되었습니다.</p>
				</div>

				<div class="form_row">
					<label>SMS 수신여부 <span class="required">*</span></label>
					<div class="form_input">
						<label> 
							<input type="radio" name="agreeSms" value="1"
							<c:if test="${member.agreeSms == 1}">checked</c:if> /> 수신함
						</label> 
						<label>
							<input type="radio" name="agreeSms" value="0"
							<c:if test="${member.agreeSms == 0}">checked</c:if> /> 수신안함
						</label>
						<!-- <p class="desc">쇼핑몰에서 제공하는 유익한 이벤트 소식을 SMS로 받으실 수 있습니다.</p> -->
					</div>
				</div>

				<div class="form_row">
					<label for="email">이메일 <span class="required">*</span></label>
					<div class="form_input">
						<input type="text" id="email" class="half_input" name="email"
							value="${member.email}" />
						<p class="error_msg" id="emailError"></p>
					</div>
				</div>
			</div>

				<div class="additional_info_table">
					<h2>추가정보</h2>
					<div class="form_row">
						<label>성별</label>
						<div class="form_input">
							<label> <input type="radio" name="gender" value="M"
								<c:if test="${member.gender == 'M'}">checked</c:if> /> 남자
							</label> <label> <input type="radio" name="gender" value="F"
								<c:if test="${member.gender == 'F'}">checked</c:if> /> 여자
							</label>
						</div>
					</div>

					<div class="form_row">
						<label>생년월일</label>
						<div class="form_input birth_wrap">
							<div class="birth_inputs">
								<input type="text" class="birth_input" value="${birthYear}" name="birthYear" /><span>년</span>
								<input type="text" class="birth_input" value="${birthMonth}" name="birthMonth" /> <span>월</span>
								<input type="text" class="birth_input" value="${birthDay}" name="birthDay" /> <span>일</span>
							</div>
							<div class="calendar_select">
								<label><input type="radio" name="calendar" value="solar"
									checked /> 양력</label> <label><input type="radio"
									name="calendar" value="lunar" /> 음력</label>
							</div>
						</div>
					</div>
				<div class="terms_section">
					<div class="terms_item">
						<input type="hidden" name="agreeThirdParty" value="0">
						<label class="checkbox_label">
							<input type="checkbox" name="agreeThirdParty"
						       value="${member.agreeThirdParty == 1 ? 1 : 0}"
						       ${member.agreeThirdParty == 1 ? 'checked' : ''} /> 개인정보 제3자 제공 동의(선택)
						</label>
					</div>

					<div class="terms_item">
						<input type="hidden" name="agreeDelegate" value="0">
						<label class="checkbox_label">
							<input type="checkbox" name="agreeDelegate"
						       value="${member.agreeDelegate == 1 ? 1 : 0}"
						       ${member.agreeDelegate == 1 ? 'checked' : ''} /> 개인정보 제3자 제공 동의(선택)
						</label>
					</div>
				</div>
				
				<div class="form_row">
                    <label>생성일(생성자)</label>
                    <label><fmt:formatDate value="${member.createdAt}" pattern="yyyy-MM-dd HH:mm:ss" /> (${member.createdBy})</label>
                </div>
                <div class="form_row">    
                    <label>최종 수정일(수정자)</label>
                    <label><fmt:formatDate value="${member.updatedAt}" pattern="yyyy-MM-dd HH:mm:ss" /> (${member.updatedBy})</label>
				</div>

				<div class="form_buttons">
					<!-- <button type="button" class="btn_delete_account">회원삭제</button> -->

					<div class="btn_right_group">
						<button type="button" class="btn_cancel"
  onclick="location.href='${pageContext.request.contextPath}/adminmember/list'">취소</button>
						<button type="button" class="btn_submit"
							onclick="checkBeforeSubmit()">회원정보수정</button>
					</div>
				</div>
			</form>		
	</div>




	<%@ include file="/WEB-INF/views/main/footer.jsp"%>

	<script>const ctx = "${pageContext.request.contextPath}";</script>
	<!-- <script
		src="${pageContext.request.contextPath}/resources/js/join_terms.js"></script> -->

	<!-- 주소api -->
	<script
		src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
  function execDaumPostcode() {
    new daum.Postcode({
      oncomplete: function(data) {
        let fullAddr = '';
        let extraAddr = '';

        if (data.userSelectedType === 'R') {
          fullAddr = data.roadAddress;
        } else {
          fullAddr = data.jibunAddress;
        }

        if (data.userSelectedType === 'R') {
          if (data.bname !== '') {
            extraAddr += data.bname;
          }
          if (data.buildingName !== '') {
            extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
          }
          if (extraAddr !== '') {
            fullAddr += ' (' + extraAddr + ')';
          }
        }

        //주소 필드 값 덮어쓰기
        document.getElementById('zipcode').value = data.zonecode;
        document.getElementById('addr1').value = fullAddr;

        //addr2는 공란으로 초기화
        document.getElementById('addr2').value = '';

        //addr2에 포커스
        document.getElementById('addr2').focus();
      }
    }).open();
  }
</script>

	<!-- 유효성검사 -->
	
	<script>
document.addEventListener("DOMContentLoaded", function () {
  // 인증번호 받기 클릭 시 메시지 표시
  const sendBtn = document.getElementById("sendCodeBtn");
  const confirmMsg = document.getElementById("phoneConfirmMsg");

  if (sendBtn && confirmMsg) {
    sendBtn.addEventListener("click", function () {
      confirmMsg.style.display = "block";
    });
  }

  // 이메일 유효성 검사
  const emailInput = document.getElementById('email');
  const emailErrorEl = document.getElementById('emailError');

  emailInput.addEventListener('input', () => {
    const email = emailInput.value;
    const emailRule = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;

    if (!email) {
      emailErrorEl.textContent = '';
      emailErrorEl.className = '';
    } else if (!emailRule.test(email)) {
      emailErrorEl.textContent = '올바른 이메일 주소 형식이 아닙니다.';
      emailErrorEl.className = 'error_msg';
    } else {
      emailErrorEl.textContent = '사용 가능한 이메일입니다.';
      emailErrorEl.className = 'success_msg';
    }
  });
});
</script>
	
	
	
<script>
function checkBeforeSubmit() {
  const pw = document.getElementById("password").value.trim();
  const pw2 = document.getElementById("passwordConfirm").value.trim();
  const phone2 = document.querySelector('input[name="phone2"]').value.trim();
  const phone3 = document.querySelector('input[name="phone3"]').value.trim();
  const email = document.getElementById('email').value.trim();

  // 필수 항목 검사
  if (!pw || !pw2 || !phone2 || !phone3 || !email) {
    alert('모든 필수 항목을 입력해주세요.');
    return;
  }

  // 비밀번호 확인 일치 여부
  if (pw !== pw2) {
    alert('비밀번호와 비밀번호 확인이 일치하지 않습니다.');
    return;
  }

  // 유효성 통과 → 제출
  document.querySelector('form[name="updateForm"]').submit();
}

</script>




</body>
</html>
