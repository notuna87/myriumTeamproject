<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>비밀번호 찾기 결과</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/reset.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/login/find_pw_result.css" />
</head>
<body>
<%@ include file="../main/header.jsp" %>

<div class="container">
  <h2>비밀번호 찾기</h2>
  <div class="result_box">
    <p class="label">임시 비밀번호</p>
    <div class="radio_group">
      <input type="radio" id="${method}" checked>
      <label for="${method}">
        <c:choose>
          <c:when test="${method eq 'email'}">이메일</c:when>
          <c:when test="${method eq 'phone'}">휴대폰</c:when>
        </c:choose>
      </label>
    </div>
    <p class="info_label">
      <c:choose>
        <c:when test="${method eq 'email'}">이메일</c:when>
        <c:when test="${method eq 'phone'}">휴대폰 번호</c:when>
      </c:choose>
    </p>
    <p class="info_text">${targetValue}</p>
  </div>
  <div class="btn_group">
    <button class="btn cancel_btn" onclick="history.back()">취소</button>
    <button class="btn submit_btn">임시 비밀번호 전송</button>
  </div>
</div>
 <%@ include file="/WEB-INF/views/main/footer.jsp" %>

<script>
  document.querySelector('.submit_btn').addEventListener('click', function () {
    alert("임시 비밀번호가 전송되었습니다.");
  });
</script>
</body>
</html>
