<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>아이디 찾기</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/reset.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/login/find_id.css" />
</head>
<body>
	<%@ include file="../main/header.jsp" %>
  <div class="container">
    <h2>아이디 찾기</h2>
    <ul class="info_text">
      <li>가입하신 방법에 따라 아이디 찾기가 가능합니다.</li>
    </ul>

    <form class="find_form">
      <div class="form_group">
        <label for="memberType">회원유형</label>
        <select id="memberType">
          <option>개인회원</option>
        </select>
      </div>

      <div class="form_group">
        <label>인증방법</label>
        <div class="radio_wrap">
          <label><input type="radio" name="auth" value="email" checked /> 이메일</label>
          <label><input type="radio" name="auth" value="phone" /> 휴대폰번호</label>
        </div>
      </div>

      <div class="form_group">
        <label>이름</label>
        <input type="text" placeholder="이름을 입력하세요" />
      </div>

      <div class="form_group auth_input" id="emailInput">
        <label>이메일</label>
        <input type="email" placeholder="이메일을 입력하세요" />
      </div>

      <div class="form_group auth_input" id="phoneInput" style="display: none;">
        <label>휴대폰번호</label>
        <div class="phone_input_group">
          <input type="text" maxlength="3" /> -
          <input type="text" maxlength="4" /> -
          <input type="text" maxlength="4" />
        </div>
      </div>
    
      <button type="button" class="submit_btn" onclick="location.href='find_id_result.html'">확인</button>
    </form>
  </div>

	<script src="${pageContext.request.contextPath}/resources/js/find_id.js"></script>
</body>
</html>


