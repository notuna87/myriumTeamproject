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
        <input type="text" id="userId" class="half_input" value="sks0716ek" readonly/>
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
        <input type="text" id="username" class="half_input" value="고나영" readonly />
    </div>
  </div>

  <div class="form_row">
    <label>주소 <span class="required">*</span></label>
    <div class="form_input">
      <div class="address_line">
        <input type="text" class="short_input" value="1234" readonly/>
        <button type="button" class="btn_search">주소검색</button>
      </div>
      <input type="text" class="input_full" value="경기 안산시 상록구" readonly/>
      <input type="text" class="input_full" value="00호" />
    </div>
  </div>

  <div class="form_row">
    <label>휴대전화 <span class="required">*</span></label>
    <div class="form_input phone_wrap">
      <select class="phone_select">
        <option>010</option>
        <option>011</option>
        <option>016</option>
        <option>017</option>
        <option>018</option>
        <option>019</option>
    </select>
      <input type="text" class="phone_input" value="1234" />
      <input type="text" class="phone_input" value="1234" />
      <button type="button" class="btn_cert">인증번호받기</button>
    </div>
  </div>

  <div class="form_row">
    <label>SMS 수신여부 <span class="required">*</span></label>
    <div class="form_input">
      <label><input type="radio" name="sms" checked /> 수신함</label>
      <label><input type="radio" name="sms" /> 수신안함</label>
      <p class="desc">쇼핑몰에서 제공하는 유익한 이벤트 소식을 SMS로 받으실 수 있습니다.</p>
    </div>
  </div>

  <div class="form_row">
    <label for="email">이메일 <span class="required">*</span></label>
    <div class="form_input">
        <input type="text" id="email" class="half_input" value="sks0716ek@naver.com" />
    </div>
  </div>
</div>

<div class="additional_info_table">
    <h2>추가정보</h2>
    <div class="form_row">
      <label>성별</label>
      <div class="form_input">
        <label><input type="radio" name="gender" value="M" /> 남자</label>
        <label><input type="radio" name="gender" value="F" checked /> 여자</label>
      </div>
    </div>
  
    <div class="form_row">
      <label>생년월일</label>
      <div class="form_input birth_wrap">
        <div class="birth_inputs">
          <input type="text" class="birth_input" placeholder="1999" /> <span>년</span>
          <input type="text" class="birth_input" placeholder="01" /> <span>월</span>
          <input type="text" class="birth_input" placeholder="01" /> <span>일</span>
        </div>
        <div class="calendar_select">
          <label><input type="radio" name="calendar" value="solar" /> 양력</label>
          <label><input type="radio" name="calendar" value="lunar" checked /> 음력</label>
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
</body>
</html>
