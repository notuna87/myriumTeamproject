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

<c:if test="${param.error eq 'Y'}">
  <script>
    alert('입력하신 정보와 일치하는 회원이 없습니다.');
    history.back();
  </script>
</c:if>

<div class="container">
  <h2>비밀번호 찾기</h2>
  <c:choose>
  <c:when test="${not empty password}">
    <div class="result_box">
      <p>회원님의 임시 비밀번호는 아래와 같습니다.</p>
      <p class="password_display"><strong>${password}</strong></p>
      <p style="color:red;">※ 로그인 후 반드시 비밀번호를 변경해주세요.</p>
    </div>
  </c:when>
  <c:otherwise>
    <div class="result_box">
      <p style="color:red;">일치하는 회원 정보가 없습니다.</p>
    </div>
  </c:otherwise>
</c:choose>

  <div class="btn_group">
    <button class="btn cancel_btn" onclick="history.back()">취소</button>
    <button class="btn submit_btn" onclick="location.href='${pageContext.request.contextPath}/login'">로그인 하기</button>
  </div>
</div>
 <%@ include file="/WEB-INF/views/main/footer.jsp" %>

</body>
</html>
