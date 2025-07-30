<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>회원 정보 수정</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/reset.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage/member_update.css" />
</head>
<body>

   <sec:authentication property="principal" var="pinfo" />
   <c:set var="phoneNumber" value="${pinfo.member.phoneNumber}" />
   <c:set var="phone1" value="${fn:split(phoneNumber, '-')[0]}" />
   <c:set var="phone2" value="${fn:split(phoneNumber, '-')[1]}" />
   <c:set var="phone3" value="${fn:split(phoneNumber, '-')[2]}" />
   
   <fmt:formatDate value="${pinfo.member.birthdate}" pattern="yyyy" var="birthYear" />
   <fmt:formatDate value="${pinfo.member.birthdate}" pattern="MM" var="birthMonth" />
   <fmt:formatDate value="${pinfo.member.birthdate}" pattern="dd" var="birthDay" />

<jsp:include page="../main/header.jsp" />

    <div class="container">
        <h1 class="page-title">회원 정보 수정</h1>
      
        <div class="profile-section">
          <div class="profile-left">
            <div class="profile-icon">
              <img src="" alt="프로필 이미지">
            </div>
            <div class="profile-info">
              <p class="welcome">안녕하세요. <strong>고나영님</strong></p>
              <p class="level">씨앗친구</p>
            </div>
          </div>
      
          <div class="benefit-info">
            <p><strong>0원</strong> 이상 구매 시 <strong>0원</strong>을 추가할인없음 받으실 수 있습니다.</p>
          </div>
        </div>
      
        <div class="event-box">
          <p><strong>회원정보 수정 시 적립금을 지급하는 이벤트를 진행중입니다.</strong></p>
          <ul>
            <li>이벤트 기간 : 2026년 12월 31일 23시까지</li>
            <li>아래의 조건을 충족한 경우 적립금 1,000원이 지급됩니다.
              <ul>
                <li>- SMS 수신동의</li>
              </ul>
            </li>
          </ul>
        </div>


      <div class="member_form_table">
        <h2>기본정보</h2>
  <div class="form_row">
    <label for="userId">아이디 <span class="required">*</span></label>
    <div class="form_input">
        <input type="text" name="customerId" value="${member.customerId}" readonly />
      <p class="desc">(영문소문자/숫자, 4~16자)</p>
    </div>
  </div>

  <div class="form_row">
    <label for="password">비밀번호 <span class="required">*</span></label>
    <div class="form_input">
        <input type="password" id="password" class="half_input" />
      <p class="desc">(영문 대소문자/숫자/특수문자 중 2가지 이상 조합, 10자~16자)</p>
    </div>
  </div>

  <div class="form_row">
    <label for="password2">비밀번호 확인 <span class="required">*</span></label>
    <div class="form_input">
        <input type="password" id="password2" class="half_input" />
    </div>
  </div>

  <div class="form_row">
    <label for="username">이름 <span class="required">*</span></label>
    <div class="form_input">
        <input type="text" id="username" class="half_input" value="${member.customerName}" readonly />
    </div>
  </div>

  <div class="form_row">
    <label>주소 <span class="required">*</span></label>
    <div class="form_input">
      <div class="address_line">
        <input type="text" name="zipcode" value="${member.zipcode}" readonly />
        <button type="button" class="btn_search">주소검색</button>
      </div>
      <input type="text" name="addr1" value="${member.addr1}" readonly />
      <input type="text" name="addr2" value="${member.addr2}" />
    </div>
  </div>

<div class="form_row">
     <label>휴대전화 <span class="required">*</span></label>
     <div class="form_input phone_wrap">
       <select class="phone_select" name="phone1">
         <option value="010" <c:if test="${phone1 == '010'}">selected</c:if>>010</option>
         <option value="011" <c:if test="${phone1 == '011'}">selected</c:if>>011</option>
         <option value="016" <c:if test="${phone1 == '016'}">selected</c:if>>016</option>
         <option value="017" <c:if test="${phone1 == '017'}">selected</c:if>>017</option>
         <option value="018" <c:if test="${phone1 == '018'}">selected</c:if>>018</option>
         <option value="019" <c:if test="${phone1 == '019'}">selected</c:if>>019</option>
       </select>   
       <input type="text" class="phone_input" name="phone2" value="${phone2}" />
       <input type="text" class="phone_input" name="phone3" value="${phone3}" />
       <button type="button" class="btn_cert">인증번호받기</button>
     </div>
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
	    <p class="desc">쇼핑몰에서 제공하는 유익한 이벤트 소식을 SMS로 받으실 수 있습니다.</p>
	  </div>
	</div>

  <div class="form_row">
    <label for="email">이메일 <span class="required">*</span></label>
    <div class="form_input">
        <input type="text" id="email" class="half_input" value="${member.email}" />
    </div>
  </div>
</div>

<div class="additional_info_table">
    <h2>추가정보</h2>
	<div class="form_row">
	  <label>성별</label>
	  <div class="form_input">
	    <label>
	      <input type="radio" name="gender" value="M"
	        <c:if test="${member.gender == 'M'}">checked</c:if> /> 남자
	    </label>
	    <label>
	      <input type="radio" name="gender" value="F"
	        <c:if test="${member.gender == 'F'}">checked</c:if> /> 여자
	    </label>
	  </div>
	</div>
  
     <div class="form_row">
      <label>생년월일</label>
      <div class="form_input birth_wrap">
        <div class="birth_inputs">
          <input type="text" class="birth_input" placeholder="${birthYear}" /> <span>년</span>
          <input type="text" class="birth_input" placeholder="${birthMonth}" /> <span>월</span>
          <input type="text" class="birth_input" placeholder="${birthDay}" /> <span>일</span>
        </div>
        <div class="calendar_select">
          <label><input type="radio" name="calendar" value="solar" /> 양력</label>
          <label><input type="radio" name="calendar" value="lunar" checked /> 음력</label>
        </div>
      </div>      
    </div>
      
  </div>

  <div class="terms_section">
    <div class="terms_item">
      <label class="checkbox_label">
        <input type="checkbox" name="agree3rd" checked />
        개인정보 제3자 제공 동의(선택)
      </label>
      <div class="terms_box">
        아래 내용의 동의 여부는 회원가입에 영향을 미치지 않습니다.  
        단, 동의 거부시 서비스 이용에 제한이 있을 수 있습니다.
        <br><br>
        - 제공 받는 자 :<br>
        - 제공 항목 :<br>
        - 제공 목적 :<br>
        - 보유 및 이용기간 :<br>
      </div>
    </div>
  
    <div class="terms_item">
      <label class="checkbox_label">
        <input type="checkbox" name="agreeDelegate" checked />
        개인정보 처리 위탁 동의(선택)
      </label>
      <div class="terms_box">
        아래 내용의 동의 여부는 회원가입에 영향을 미치지 않습니다. 단, 동의 거부시 서비스 이용에 제한이 있을 수 있습니다.
        <br><br>
        - 위탁받는 자(수탁업체) :<br>
        - 위탁업무의 내용:<br>
      </div>
    </div>
  </div>
  
  <div class="form_buttons">
    <button type="button" class="btn_cancel_account">회원탈퇴</button>
  
    <div class="btn_right_group">
      <button type="button" class="btn_cancel">취소</button>
      <button type="submit" class="btn_submit">회원정보수정</button>
    </div>
  </div>
  
          
</div>
</div>

<%@ include file="/WEB-INF/views/main/footer.jsp" %>

<script>const ctx = "${pageContext.request.contextPath}";</script>
<script src="${pageContext.request.contextPath}/resources/js/join_terms.js"></script>

<script>
document.querySelector('.btn_search').addEventListener('click', function () {
    // 다음 주소 API 호출
    new daum.Postcode({
        oncomplete: function(data) {
            document.querySelector('input[name="zipcode"]').value = data.zonecode;
            document.querySelector('input[name="addr1"]').value = data.address;
            document.querySelector('input[name="addr2"]').focus();
        }
    }).open();
});
</script>
</body>
</html>
