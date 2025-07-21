<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>회원가입 완료</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/reset.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/join/complete.css" />
</head>
<body>
<%@ include file="../main/header.jsp" %>

  <div class="complete_wrap">
    <h2 class="page_title">회원 가입 완료</h2>

    <div class="step_bar">
      <span>1. 약관동의</span>
      <span style="font-size: 16px;"> > </span>
      <span>2. 정보입력</span>
      <span style="font-size: 16px;"> > </span>
      <span class="active">3. 가입완료</span>
    </div>

    <div class="complete_box">
      <p class="success_msg">회원가입이 완료 되었습니다.</p>
      <p class="welcome"><strong>고나영</strong> 님은 [씨앤닥터] 회원이십니다.</p>
      <p class="info">0원 이상 구매 시 0원으로 추가할인앱을 받으실 수 없습니다.</p>

      <table class="user_info">
        <tr>
          <th>아이디</th>
          <td>sks0716ek</td>
        </tr>
        <tr>
          <th>이름</th>
          <td>고나영</td>
        </tr>
        <tr>
          <th>이메일</th>
          <td>sks0716ek@naver.com</td>
        </tr>
      </table>

	     <button type="button" class="btn_main" onclick="location.href='${pageContext.request.contextPath}/home'">
	  		메인으로 이동
		</button>
    </div>
  </div>
</body>
</html>
