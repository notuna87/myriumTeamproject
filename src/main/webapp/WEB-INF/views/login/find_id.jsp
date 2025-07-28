<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>아이디 찾기</title>

<!-- CSS 링크 -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/reset.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/header.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/login/find_id.css" />
</head>

<body>
	<%@ include file="../main/header.jsp"%>

	<div class="container">
		<h2>아이디 찾기</h2>
		<ul class="info_text">
			<li>가입하신 방법에 따라 아이디 찾기가 가능합니다.</li>
		</ul>

		<form id="findForm"
			action="${pageContext.request.contextPath}/login/find_id_result"
			method="post">
			<div class="form_group">
				<label for="memberType">회원유형</label> <select id="memberType"
					name="memberType">
					<option>개인회원</option>
				</select>
			</div>

			<div class="form_group">
				<label>인증방법</label>
				<div class="radio_wrap">
					<label><input type="radio" name="auth" value="email"
						checked /> 이메일</label> <label><input type="radio" name="auth"
						value="phone" /> 휴대폰번호</label>
				</div>
			</div>

			<div class="form_group">
				<label>이름</label> <input type="text" name="customerName"
					placeholder="이름을 입력하세요" required />
			</div>

			<div class="form_group auth_input" id="emailInput">
				<label>이메일</label> <input type="email" name="email"
					placeholder="이메일을 입력하세요" />
			</div>

			<div class="form_group auth_input" id="phoneInput"
				style="display: none;">
				<label>휴대폰번호</label>
				<div class="phone_input_group">
					<input type="text" name="phone1" maxlength="3" /> - <input
						type="text" name="phone2" maxlength="4" /> - <input type="text"
						name="phone3" maxlength="4" />
				</div>
			</div>

			<button type="button" class="submit_btn" onclick="submitForm()">확인</button>
		</form>

		<script>
			function submitForm() {
				const auth = document
						.querySelector('input[name="auth"]:checked').value;
				const name = document
						.querySelector('input[name="customerName"]').value;

				if (!name.trim()) {
					alert("이름을 입력하세요.");
					return;
				}

				if (auth === "email") {
					const email = document.querySelector('input[name="email"]').value;
					if (!email.trim()) {
						alert("이메일을 입력하세요.");
						return;
					}
				} else {
					const p1 = document.querySelector('input[name="phone1"]').value;
					const p2 = document.querySelector('input[name="phone2"]').value;
					const p3 = document.querySelector('input[name="phone3"]').value;
					if (!p1 || !p2 || !p3) {
						alert("휴대폰 번호를 모두 입력하세요.");
						return;
					}
				}

				document.getElementById("findForm").submit();
			}

			document
					.querySelectorAll('input[name="auth"]')
					.forEach(
							function(radio) {
								radio
										.addEventListener(
												'change',
												function() {
													document
															.getElementById('emailInput').style.display = this.value === 'email' ? 'block'
															: 'none';
													document
															.getElementById('phoneInput').style.display = this.value === 'phone' ? 'block'
															: 'none';
												});
							});
		</script>
</body>
</html>
