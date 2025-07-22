<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>아이디 찾기 결과</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/reset.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/login/find_id_result.css" />
</head>
<body>
<%@ include file="../main/header.jsp" %>

  <div class="wrap">
    <h2 class="title">아이디 찾기</h2>

    <div class="result_box">
      <p class="result_msg">
        고객님 아이디 찾기가 완료되었습니다.<br />
        가입된 아이디가 총 1개 있습니다!
      </p>

      <table class="info_table">
        <tr>
          <th>이름</th>
          <td>${name}</td>
        </tr>
        <tr>
          <th>이메일</th>
          <td>${email}</td>
        </tr>
      </table>

      <div class="found_id">
        <label>
          <input type="radio" checked />
          ${userId}
          <span class="info">(개인회원, ${joinDate} 가입)</span>
        </label>
      </div>

      <div class="btn_group">
        <button class="btn login_btn" onclick="location.href='${pageContext.request.contextPath}/login'">로그인</button>
        <button class="btn find_pw_btn" onclick="location.href='${pageContext.request.contextPath}/find_pw'">비밀번호 찾기</button>
      </div>
    </div>
  </div>
 <%@ include file="/WEB-INF/views/main/footer.jsp" %>
</body>
</html>
