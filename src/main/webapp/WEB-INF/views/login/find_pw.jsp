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
  <form action="${pageContext.request.contextPath}/login/find_pw" method="post">

  <div class="form_group">
    <label for="member_type">회원유형</label>
    <select id="member_type" name="memberType">
      <option value="personal">개인회원</option>
    </select>
  </div>

  <div class="form_group radio_group">
    <label><input type="radio" name="find_method" value="email" checked> 이메일</label>
    <label><input type="radio" name="find_method" value="phone_number" checked> 이메일</label>
  </div>

  <div class="form_group">
    <label for="userid">아이디</label>
    <input type="text" id="userid" name="customerId" placeholder="아이디 입력">
  </div>

  <div class="form_group">
    <label for="username">이름</label>
    <input type="text" id="username" name="customerName" placeholder="이름 입력">
  </div>

  <div class="form_group" id="email_wrap">
    <label for="email">이메일로 찾기</label>
    <input type="email" id="email" name="email" placeholder="이메일 입력">
  </div>

  <div class="form_group phone_wrap" style="display:none;">
    <label>휴대폰 번호로 찾기</label>
    <div class="phone_inputs">
      <input type="text" id="phone1" name="phone1" maxlength="3"> -
      <input type="text" id="phone2" name="phone2" maxlength="4"> -
      <input type="text" id="phone3" name="phone3" maxlength="4">
    </div>
  </div>

  <button type="submit" class="submit_btn">확인</button>
</form>

</div>
 <%@ include file="/WEB-INF/views/main/footer.jsp" %>

<script>
document.querySelector('.submit_btn').addEventListener('click', function () {
  const method = document.querySelector('input[name="find_method"]:checked').value;

  if (method === 'phone') {
    const p1 = document.querySelector('#phone1').value;
    const p2 = document.querySelector('#phone2').value;
    const p3 = document.querySelector('#phone3').value;
    const fullPhone = p1 + "-" + p2 + "-" + p3;

    // hidden input 생성
    let hidden = document.createElement("input");
    hidden.type = "hidden";
    hidden.name = "phoneNumber";
    hidden.value = fullPhone;
    document.querySelector('form').appendChild(hidden);
  }

  document.querySelector('form').submit();
});
</script>





</body>
</html>
