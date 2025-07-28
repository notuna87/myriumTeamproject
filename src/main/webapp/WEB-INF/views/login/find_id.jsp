<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
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

  <form id="findForm" action="${pageContext.request.contextPath}/login/find_id_result" method="post">


    <div class="form_group">
      <label>회원유형</label>
      <select name="memberType">
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
      <input type="text" name="customerName" placeholder="이름을 입력하세요" required />
    </div>

    <div class="form_group auth_input" id="emailInput">
      <label>이메일</label>
      <input type="email" name="email" placeholder="이메일을 입력하세요" />
    </div>

    <div class="form_group auth_input" id="phoneInput" style="display: none;">
      <label>휴대폰번호</label>
      <div class="phone_input_group">
		<input type="text" name="phone1" id="phone1" maxlength="3" /> -
		<input type="text" name="phone2" id="phone2" maxlength="4" /> -
		<input type="text" name="phone3" id="phone3" maxlength="4" />

      </div>
    </div>

    <!-- 숨겨진 필드 -->
    <input type="hidden" id="methodInput" name="method" value="email" />
    <input type="hidden" id="phoneNumber" name="phoneNumber" />

    <!-- form 내부에서 submit 버튼 -->
	<button type="button" class="submit_btn" onclick="submitForm()">확인</button>




  </form>
</div>

<script>

function submitForm() {
  console.log(">> [submitForm 호출됨]");

  const authRadio = document.querySelector('input[name="auth"]:checked');
  const auth = authRadio ? authRadio.value : "email";

  const name = document.querySelector('input[name="customerName"]')?.value.trim();
  const methodInput = document.getElementById("methodInput");
  const phoneHidden = document.getElementById("phoneNumber");

  if (!name) {
    alert("이름을 입력하세요.");
    return;
  }

  if (auth === "email") {
    const email = document.querySelector('input[name="email"]')?.value.trim();
    if (!email) {
      alert("이메일을 입력하세요.");
      return;
    }
    phoneHidden.value = "";
  } else {
    const p1 = document.getElementById("phone1")?.value.trim();
    const p2 = document.getElementById("phone2")?.value.trim();
    const p3 = document.getElementById("phone3")?.value.trim();

    if (!p1 || !p2 || !p3) {
      alert("휴대폰 번호를 모두 입력하세요.");
      return;
    }

    const fullPhone = `${p1}-${p2}-${p3}`;
    phoneHidden.value = fullPhone;
  }

  methodInput.value = auth;

  console.log(">> 이름:", name);
  console.log(">> 방식:", auth);
  console.log(">> phoneNumber:", phoneHidden.value);
  console.log(">> auth radio checked:", document.querySelector('input[name="auth"]:checked'));


  // ★ 중요: 강제 서밋
  document.getElementById("findForm").submit();
}

document.querySelectorAll('input[name="auth"]').forEach((radio) => {
	  radio.addEventListener('change', function () {
	    document.getElementById('emailInput').style.display = this.value === 'email' ? 'block' : 'none';
	    document.getElementById('phoneInput').style.display = this.value === 'phone' ? 'block' : 'none';
	  });
	});
</script>




</body>
</html>
