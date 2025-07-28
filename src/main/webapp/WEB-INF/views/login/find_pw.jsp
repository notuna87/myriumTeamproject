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
  <form id="findPwForm" action="${pageContext.request.contextPath}/login/find_pw" method="post">

    <div class="form_group">
      <label for="member_type">회원유형</label>
      <select id="member_type" name="memberType">
        <option value="personal">개인회원</option>
      </select>
    </div>

    <div class="form_group radio_group">
	  <label><input type="radio" name="find_method" value="email" checked> 이메일</label>
	  <label><input type="radio" name="find_method" value="phone"> 휴대폰번호</label>
	</div>


    <div class="form_group">
      <label for="userid">아이디</label>
      <input type="text" id="userid" name="customerId" placeholder="아이디 입력" required>
    </div>

    <div class="form_group">
      <label for="username">이름</label>
      <input type="text" id="username" name="customerName" placeholder="이름 입력" required>
    </div>

    <div class="form_group" id="email_wrap">
      <label for="email">이메일</label>
      <input type="email" id="email" name="email" placeholder="이메일 입력">
    </div>

    <div class="form_group phone_wrap" id="phone_wrap" style="display: none;">
      <label>휴대폰번호</label>
      <div class="phone_inputs">
        <input type="text" id="phone1" name="phone1" maxlength="3"> -
        <input type="text" id="phone2" name="phone2" maxlength="4"> -
        <input type="text" id="phone3" name="phone3" maxlength="4">
      </div>
    </div>

    <!-- 숨겨진 필드 -->
    <input type="hidden" id="method" name="method" value="email" />
    <input type="hidden" id="phoneNumber" name="phoneNumber" />

    <button type="submit" class="submit_btn">확인</button>
  </form>
</div>

<input type="hidden" name="method" id="methodInput" value="email" />


<%@ include file="/WEB-INF/views/main/footer.jsp" %>

<script>
  const radios = document.querySelectorAll('input[name="find_method"]');
  radios.forEach(radio => {
    radio.addEventListener('change', function () {
      const methodInput = document.getElementById('methodInput');
      methodInput.value = this.value;

      document.getElementById('email_wrap').style.display = this.value === 'email' ? 'block' : 'none';
      document.querySelector('.phone_wrap').style.display = this.value === 'phone' ? 'block' : 'none';
    });
  });

  // 확인 버튼 눌렀을 때 폰번호 조합하여 hidden input 추가
  document.querySelector('.submit_btn').addEventListener('click', function () {
    const method = document.getElementById('methodInput').value;

    if (method === 'phone') {
      const p1 = document.getElementById('phone1').value;
      const p2 = document.getElementById('phone2').value;
      const p3 = document.getElementById('phone3').value;

      const fullPhone = p1 + "-" + p2 + "-" + p3;

      let hidden = document.createElement("input");
      hidden.type = "hidden";
      hidden.name = "phoneNumber";
      hidden.value = fullPhone;
      document.querySelector('form').appendChild(hidden);
    }
  });
</script>


</body>
</html>
