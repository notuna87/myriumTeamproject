<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="loginUser" value="${sessionScope.loginUser}" />
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>비밀번호 변경</title>
     <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/reset.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage/change_password.css" />
</head>
<body>
<jsp:include page="../main/header.jsp" />

<c:if test="${not empty msg}">
  <script>
    alert("${msg}");
    history.replaceState(null, null, location.pathname); // 뒤로가기 alert 방지
  </script>
</c:if>

  <main class="container">
    <h2 class="page-title">비밀번호 변경</h2>
    <p class="description">
      회원님의 개인정보를 안전하게 보호하고,<br />
      개인정보 도용으로 인한 피해를 예방하기 위해 90일 이상 비밀번호를 변경하지 않은 경우 비밀번호 변경을 권장하고 있습니다.
    </p>

    <div class="form-box">
      <form class="pw-form" method="post" action="${pageContext.request.contextPath}/member/changePassword">
        <div class="form-group">
          <label for="user-id">아이디</label>
           <div id="user-id" class="static-text">${loginUser.customerId}</div>
        </div>

        <div class="form-group">
          <label for="current-password">현재 비밀번호</label>
          <input type="password" id="current-password" name="current-password" />
        </div>

        <div class="form-group">
          <label for="new-password">새 비밀번호</label>
          <input type="password" id="new-password" name="new-password" />
          <p class="pw-rule">(영문 대소문자/숫자/특수문자 중 2가지 이상 조합, 10자~16자)</p>
        </div>

        <div class="form-group">
          <label for="confirm-password">새 비밀번호 확인</label>
          <input type="password" id="confirm-password" name="confirm-password" />
        </div>

        <div class="btn-group">
         <button type="button" class="btn btn-white"
        onclick="location.href='${pageContext.request.contextPath}/mypage/mypage'">다음에 변경</button>
          <button type="submit" class="btn btn-green">비밀번호 변경</button>
        </div>
      </form>
    </div>
  </main>
     <%@ include file="/WEB-INF/views/main/footer.jsp" %>
</body>
</html>
