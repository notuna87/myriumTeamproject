<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>비밀번호 찾기</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/reset.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/login/find_pw.css" />
</head>
<body>
<%@ include file="../main/header.jsp" %>

<div class="container">
  <h2>비밀번호 찾기</h2>
  <form>
    <div class="form_group">
      <label for="member_type">회원유형</label>
      <select id="member_type">
        <option value="personal">개인회원</option>
      </select>
    </div>

    <div class="form_group radio_group">
      <label><input type="radio" name="find_method" value="email" checked> 이메일</label>
      <label><input type="radio" name="find_method" value="phone"> 휴대폰번호</label>
    </div>

    <div class="form_group">
      <label for="userid">아이디</label>
      <input type="text" id="userid" placeholder="아이디 입력">
    </div>

    <div class="form_group">
      <label for="username">이름</label>
      <input type="text" id="username" placeholder="이름 입력">
    </div>

    <div class="form_group" id="email_wrap">
      <label for="email">이메일로 찾기</label>
      <input type="email" id="email" placeholder="이메일 입력">
    </div>

    <div class="form_group phone_wrap" style="display:none;">
      <label>휴대폰 번호로 찾기</label>
      <div class="phone_inputs">
        <input type="text" maxlength="3"> -
        <input type="text" maxlength="4"> -
        <input type="text" maxlength="4">
      </div>
    </div>

    <button type="button" class="submit_btn" onclick="goResultPage()">확인</button>

  </form>
</div>

<script>
  function goResultPage() {
    let method = document.querySelector('input[name="find_method"]:checked')?.value || 'email';
    let target = '';

    if (method === 'email') {
      target = document.querySelector('#emailInput')?.value || 'test@example.com';
    } else {
      target = document.querySelector('#phoneInput')?.value || '010-1234-5678';
    }

    // 템플릿 리터럴 쓰지 마세요!
    location.href = "/controller/find_pw_result?method=" + method + "&target=" + encodeURIComponent(target);

  }
</script>




</body>
</html>
