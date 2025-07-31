<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<base href="${pageContext.request.contextPath}/">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>회원가입</title>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/reset.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/join/join.css" />

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

</head>
<body>

<%@ include file="../main/header.jsp" %>

<div class="join_wrap">

    <h2>회원가입</h2>

	<hr class="section_divider" />

    <h3>회원인증</h3>
    <div class="form_section">
    <label>회원구분 <span class="required">*</span></label>
    <div class="radio_wrap">
        <input type="radio" id="personal" name="member_type" checked />
        <label for="personal">개인회원</label>
    </div>
    </div>

    <div class="form_title_wrap">
        <h4 class="form_title">기본정보</h4>
        <span class="required_note"><span class="required">*</span> 필수입력사항</span>
    </div>
    
    <form action="${pageContext.request.contextPath}/join" method="post">
    
	  <div class="form_section">
	  <label for="userid">아이디 <span class="required">*</span></label>
	  <input type="text" id="userid" name="customerId" placeholder="영문소문자/숫자, 4~16자" />
	  <p class="error_msg" id="idError"></p> <!-- 유효성 메시지 영역 -->
	</div>

	<div class="form_section tooltip_wrap">
	  <label for="pw">비밀번호 <span class="required">*</span></label>
	  <input type="password" id="pw" name="password" placeholder="영문 대/소문자+숫자+특수문자 조합 10~16자" />
	  
	  <div id="pw_tooltip" class="pw_tooltip">
	    <span>※ 비밀번호 입력 조건</span><br />
	    - 대소문자/숫자/특수문자 중 2가지 이상 조합, 10자~16자<br />
	    - 입력 가능한 특수문자: ~!@#$%^&*()-_=+[]{}<>?<br />
	    - 공백 입력 불가능<br />
	    - 동일한 문자, 숫자 반복 사용 불가능<br />
	    - 아이디 포함 불가능
	  </div>
	  
	  <p class="error_msg" id="pwError"></p> <!-- 메시지 영역 추가 -->
	</div>
	
	<div class="form_section">
	  <label for="pw2">비밀번호 확인 <span class="required">*</span></label>
	  <input type="password" id="pw2" name="passwordConfirm" />
	  <p class="error_msg" id="pwMatchError"></p> <!-- 확인 메시지 영역 추가 -->
	</div>


    <div class="form_section">
        <label for="name">이름 <span class="required">*</span></label>
        <input type="text" id="name" name="customerName" />
    </div>

	<div class="form_section address">
	    <label>주소 <span class="required">*</span></label>
	    
	    <div class="address_group">
	        <input type="text" id="postcode" name="zipcode" placeholder="우편번호" readonly />
	        <button type="button" onclick="execDaumPostcode()">주소검색</button>
	    </div>
	    
	    <input type="text" id="roadAddress" name="addr1" placeholder="기본주소" readonly />
	    <input type="text" id="detailAddress" name="addr2" placeholder="나머지 주소" />
	</div>



	<div class="form_section phone">
	  <label>휴대전화 <span class="required">*</span></label>
	  <div class="phone_group">
	    <select name="phone1">
		  <option>010</option>
		  <option>011</option>
		  <option>016</option>
		  <option>018</option>
		  <option>019</option>
		</select> -
		<input type="text" name="phone2" maxlength="4"/> -
		<input type="text" name="phone3" maxlength="4"/>
	    <button type="button" id="sendCodeBtn" class="btn_cert">인증번호받기</button>
	  </div>
	  <p class="success_msg" id="phoneConfirmMsg" style="display: none; margin-top: 6px;">인증번호 확인 되었습니다.</p>
	</div>


	 <div class="form_section">
	  <label for="email">이메일 <span class="required">*</span></label>
	  <input type="email" id="email" name="email" />
	  <p class="error_msg" id="emailError"></p>
	</div>


    <h4 class="form_title">추가정보 <span class="optional_note">(선택)</span></h4>

    <div class="form_section">
      <label>성별</label>
      <div class="radio_wrap">
        <input type="radio" id="male" name="gender"  value="M"/>
        <label for="male">남자</label>
        <input type="radio" id="female" name="gender"  value="F" />
        <label for="female">여자</label>
      </div>
    </div>

    <div class="form_section">
      <label>생년월일</label>
      <div class="birth_group">
		<input type="text" name="birthYear" placeholder="YYYY" maxlength="4" /> <span>년</span>
		<input type="text" name="birthMonth" placeholder="MM" maxlength="2" /> <span>월</span>
		<input type="text" name="birthDay" placeholder="DD" maxlength="2" /> <span>일</span>
      </div>
      <div class="radio_wrap">
        <input type="radio" id="solar" name="calendar" checked />
        <label for="solar">양력</label>
        <input type="radio" id="lunar" name="calendar" />
        <label for="lunar">음력</label>
      </div>
    </div>

    <div class="terms_wrap">
      <div class="terms_all">
        <label>
          <input type="checkbox" id="check_all" />
          <strong>전체 동의</strong>
        </label>
        <p class="desc">이용약관 및 개인정보 수집 및 이용, 쇼핑정보 수신(선택)에 모두 동의합니다.</p>
      </div>
      <ul class="terms_list" id="termsList"></ul>
    </div>

    <div class="form_section">
        <button type="submit" class="submit_btn" id="submitBtn">회원가입</button>
      </div>
  </form>
</div>

 <%@ include file="/WEB-INF/views/main/footer.jsp" %>


<script> const ctx = "${pageContext.request.contextPath}"; </script>
<script src="${pageContext.request.contextPath}/resources/js/join_terms.js"></script>


</body>
</html>