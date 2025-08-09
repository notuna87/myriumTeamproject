<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!doctype html>
<html lang="ko">
<head>
  <meta charset="utf-8" />
  <title>상품 리뷰 - 토탈리뷰</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/reset.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/total_review.css" />
</head>
<body>
  		<%@ include file="/WEB-INF/views/main/header.jsp"%>
<!-- 제목 영역 -->
<div class="review-container">
<div class="tr-header">
  <h2>상품 리뷰</h2>
</div>

<!-- 리뷰 리스트 영역 -->
<section class="tr-list">
  <c:if test="${empty reviews}">
    <div class="tr-empty">등록된 리뷰가 없습니다.</div>
  </c:if>

  <c:forEach var="r" items="${reviews}">
    <article class="tr-item">
      <!-- 좌: 썸네일/포토 -->
      <div class="tr-left">
        <div class="tr-thumbs">
          <!-- 리뷰의 이미지 경로 사용 -->
          <c:if test="${not empty r.imageUrl}">
            <img class="tr-thumb" src="${pageContext.request.contextPath}${r.imageUrl}" alt="리뷰 이미지" />
          </c:if>
        </div>
        <div class="tr-prodname"><c:out value="${r.productName}"/></div>
      </div>

      <!-- 중: 리뷰 본문 -->
      <div class="tr-main">
        <h3 class="tr-title">
          <c:out value="${r.reviewTitle}"/>
          <!-- 댓글 수 없으면 이 블록 삭제 -->
          <c:if test="${r.commentCount > 0}">
            <span class="tr-badge">[<c:out value='${r.commentCount}'/>]</span>
          </c:if>
        </h3>
        <p class="tr-text">
          <!-- summary를 서비스/매퍼에서 SUBSTR로 내려주면 summary 사용 -->
          <c:out value="${empty r.summary ? r.reviewContent : r.summary}"/>
        </p>
		<a class="tr-more"
		   href="${pageContext.request.contextPath}/mypage/review/viewAndRedirect?productId=${r.productId}">
		   상품 상세보기
		</a>
      </div>

      <!-- 우: 메타 -->
      <aside class="tr-meta">
        <div class="tr-stars" aria-label="별점">
          <c:forEach var="i" begin="1" end="5">
            <c:choose>
              <c:when test="${i <= r.rating}">★</c:when>
              <c:otherwise>☆</c:otherwise>
            </c:choose>
          </c:forEach>
        </div>
        <div class="tr-writer"><c:out value="${r.maskedId}"/></div>
        <div class="tr-date">
          <fmt:formatDate value="${r.reviewDate}" pattern="yyyy-MM-dd"/>
        </div>
        <div class="tr-counters">
          <span>조회 <c:out value="${r.viewCount}"/></span>
        </div>
      </aside>
    </article>
  </c:forEach>
</section>

<div class="tr-footer">
  <button type="button" class="btn-write" onclick="checkLoginAndWrite()">글쓰기</button>
</div>

<c:if test="${not empty reviews}">
  <div class="tr-pagination">

    <c:url var="base" value="/total_review" />

    <!-- 처음 / 이전 -->
    <a class="tr-page ${paginationCurrent == 1 ? 'disabled' : ''}"
       href="${base}?page=1&size=${size}&q=${fn:escapeXml(q)}">처음</a>
    <a class="tr-page ${paginationCurrent == 1 ? 'disabled' : ''}"
       href="${base}?page=${paginationPrev}&size=${size}&q=${fn:escapeXml(q)}">이전</a>

    <!-- 번호 -->
    <c:forEach var="i" begin="${paginationStart}" end="${paginationEnd}">
      <c:choose>
        <c:when test="${i == paginationCurrent}">
          <span class="tr-page current" aria-current="page">${i}</span>
        </c:when>
        <c:otherwise>
          <a class="tr-page"
             href="${base}?page=${i}&size=${size}&q=${fn:escapeXml(q)}">${i}</a>
        </c:otherwise>
      </c:choose>
    </c:forEach>

    <!-- 다음 / 마지막 -->
    <a class="tr-page ${paginationCurrent == last ? 'disabled' : ''}"
       href="${base}?page=${paginationNext}&size=${size}&q=${fn:escapeXml(q)}">다음</a>
    <a class="tr-page ${paginationCurrent == last ? 'disabled' : ''}"
       href="${base}?page=${last}&size=${size}&q=${fn:escapeXml(q)}">마지막</a>
  </div>
</c:if>

<!-- 비어있을 때 -->
<c:if test="${empty reviews}">
  <div class="tr-empty">등록된 리뷰가 없습니다.</div>
</c:if>
</div>

  	<%@ include file="/WEB-INF/views/main/footer.jsp"%>
  <!-- 간단 탭 스크립트 -->
  <script>
    (function(){
      var tabs = document.querySelectorAll('.tab');
      var panels = {
        photo: document.getElementById('panel-photo'),
        normal: document.getElementById('panel-normal')
      };
      tabs.forEach(function(btn){
        btn.addEventListener('click', function(){
          tabs.forEach(function(b){ b.classList.remove('is-active'); });
          btn.classList.add('is-active');
          Object.keys(panels).forEach(function(k){ panels[k].classList.remove('is-active'); });
          panels[btn.dataset.tab].classList.add('is-active');
        });
      });
    })();
  </script>

<script>
  function checkLoginAndWrite() {
    // JSP EL로 로그인 여부 확인 (예: 세션에 member 객체 있는 경우)
    var isLoggedIn = ${sessionScope.member != null ? 'true' : 'false'};

    if (!isLoggedIn) {
      alert("회원만 작성 가능합니다.\n로그인 화면으로 이동합니다.");
      location.href = "${pageContext.request.contextPath}/login";
    } else {
      location.href = "${pageContext.request.contextPath}/mypage";
    }
  }
</script>
</body>
</html>
