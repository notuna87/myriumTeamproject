<%@ page contentType="text/html; charset=UTF-8" %>
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
<%@ include file="../main/header.jsp" %>
  <div class="member-container">
    <div class="page-header">
      <h2>회원 정보 수정</h2>
    </div>

    <div class="user-summary">
      <div class="profile-icon"></div>
      <div class="user-info">
        <strong>안녕하세요. 고나영님</strong>
        <p>씨앗친구</p>
      </div>
      <div class="user-benefit">
        <span>0원 이상 구매 시 0원을 추가할인없음 받으실 수 있습니다.</span>
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
    
    <div class="form_title_wrap">
        <h4 class="form_title">기본정보</h4>
        <span class="required_note"><span class="required">*</span> 필수입력사항</span>
    </div>
    
    <form action="${pageContext.request.contextPath}/join/complete" method="get">
    
    <div class="form_section">
        <label for="userid">아이디 <span class="required">*</span></label>
        <input type="text" id="userid" name="userid" placeholder="영문소문자/숫자, 4~16자" />
    </div>

    <div class="form_section tooltip_wrap">
        <label for="pw">비밀번호 <span class="required">*</span></label>
        <input type="password" id="pw" name="pw" placeholder="영문 대/소문자+숫자+특수문자 조합 10~16자" />
        
        <div id="pw_tooltip" class="pw_tooltip">
          <span>※ 비밀번호 입력 조건</span><br />
          - 대소문자/숫자/특수문자 중 2가지 이상 조합, 10자~16자<br />
          - 입력 가능한 특수문자: ~!@#$%^&*()-_=+[]{}<>?<br />
          - 공백 입력 불가능<br />
          - 연속된 문자, 숫자 사용 불가능<br />
          - 동일한 문자, 숫자 반복 사용 불가능<br />
          - 아이디 포함 불가능
        </div>
      </div>

    <div class="form_section">
        <label for="pw2">비밀번호 확인 <span class="required">*</span></label>
        <input type="password" id="pw2" name="pw2" />
    </div>

    <div class="form_section">
        <label for="name">이름 <span class="required">*</span></label>
        <input type="text" id="name" name="name" />
    </div>

    <div class="form_section address">
        <label>주소 <span class="required">*</span></label>
        <div class="address_group">
            <input type="text" placeholder="우편번호" />
            <button type="button">주소검색</button>
        </div>
            <input type="text" placeholder="기본주소" />
            <input type="text" placeholder="나머지 주소" />
    </div>

    <div class="form_section phone">
        <label>휴대전화 <span class="required">*</span></label>
        <div class="phone_group">
        <select>
            <option>010</option>
            <option>011</option>
            <option>016</option>
            <option>018</option>
            <option>019</option>
        </select> -
        <input type="text" /> -
        <input type="text" />
        <button type="button">인증번호받기</button>
        </div>
    </div>

    <div class="form_section">
        <label for="email">이메일 <span class="required">*</span></label>
        <input type="email" id="email" name="email" />
    </div>

    <h4 class="form_title">추가정보 <span class="optional_note">(선택)</span></h4>

    <div class="form_section">
      <label>성별</label>
      <div class="radio_wrap">
        <input type="radio" id="male" name="gender" />
        <label for="male">남자</label>
        <input type="radio" id="female" name="gender" />
        <label for="female">여자</label>
      </div>
    </div>

    <div class="form_section">
      <label>생년월일</label>
      <div class="birth_group">
        <input type="text" placeholder="YYYY" /> <span>년</span>
        <input type="text" placeholder="MM" /> <span>월</span>
        <input type="text" placeholder="DD" /> <span>일</span>
      </div>
      <div class="radio_wrap">
        <input type="radio" id="solar" name="calendar" checked />
        <label for="solar">양력</label>
        <input type="radio" id="lunar" name="calendar" />
        <label for="lunar">음력</label>
      </div>
    </div>
    
  </div>
   <%@ include file="/WEB-INF/views/main/footer.jsp" %>
   
   <script> const ctx = "${pageContext.request.contextPath}"; </script>
<script src="${pageContext.request.contextPath}/resources/js/join_terms.js"></script>
</body>
</html>
