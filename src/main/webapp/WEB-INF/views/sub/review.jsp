<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<html>
<head>
</head>
<body>
<div class="reviewWrap">
	<h3>리뷰</h3>
	<p style="font-size: 13px; color: #666;">고객님의 소중한 후기를 남겨주세요.</p>

	<div class="reviewBox">
		<div class="satisfaction">
			<p style="font-size: 13px;">상품만족도</p>
			<p>
				⭐ <span style="font-weight: bold; font-size: 23px;"> <fmt:formatNumber
						value="${averageRating}" maxFractionDigits="1" /> / 5
				</span>
			</p>
		</div>
		<div class="reviewsNumber">
			<p style="font-size: 13px;">리뷰 개수</p>
			<p style="font-weight: bold; font-size: 23px;">${reviewCount}</p>
		</div>
		<div class="writeReview">
			<p style="font-size: 13px;">고객님의 리뷰를 공유해주세요!</p>
			<div class="writereviewButton"
			     style="cursor: pointer;"
			     onclick="location.href='${pageContext.request.contextPath}/mypage'">
			  리뷰 작성하기
			</div>
			
		</div>
	</div>
	<div class="cartWrap">
    <div class="photoreviewBox">
      <h5>
        포토리뷰<span style="font-size: 13px; color: #888;"> (최근 리뷰 ${reviewCount}개)</span>
      </h5>

      <c:choose>
        <c:when test="${empty reviewList}">
          <div class="photoreviewBulletin">게시물이 없습니다</div>
        </c:when>
        <c:otherwise>
          <div class="photoreviewList">
            <c:forEach var="review" items="${reviewList}">
             <div class="photoreviewItem">
			  <div class="review-info">
			    <c:if test="${not empty review.imageUrl}">
			      <img src="${pageContext.request.contextPath}${review.imageUrl}" class="review-image" alt="리뷰 이미지">
			    </c:if>
                    <!-- 텍스트를 별도 래퍼로 묶기 -->
			    <div class="review-text">
			      <p class="review-title">${fn:escapeXml(review.reviewTitle)}</p>
			      <p class="review-content">${fn:escapeXml(review.reviewContent)}</p>
			    </div>
			  </div>
                <div class="review-meta-box">
				    <p class="review-rating">
				      <c:forEach var="i" begin="1" end="5">
				        <span class="star">
				          <c:choose>
				            <c:when test="${i <= review.rating}">★</c:when>
				            <c:otherwise>☆</c:otherwise>
				          </c:choose>
				        </span>
				      </c:forEach>
				    </p>
				    <p class="review-writer">${review.maskedId}</p>
				    <p class="review-date"><fmt:formatDate value="${review.reviewDate}" pattern="yyyy-MM-dd" /></p>
				    <p class="review-views">조회 ${review.viewCount}</p>
				  </div>
				</div>
              <hr />
            </c:forEach>
          </div>

          <!-- 페이징 영역 -->
          <div class="review-pagination" style="text-align: center; margin-top: 20px;">
            <c:if test="${totalPages > 1}">
              <c:url var="basePageUrl" value="sub">
                <c:param name="id" value="${product.id}" />
              </c:url>

              <c:choose>
                <c:when test="${currentPage > 1}">
                  <a href="${basePageUrl}&page=1" class="page-arrow">≪</a>
                </c:when>
                <c:otherwise>
                  <span class="page-arrow disabled">≪</span>
                </c:otherwise>
              </c:choose>

              <c:choose>
                <c:when test="${currentPage > 1}">
                  <a href="${basePageUrl}&page=${currentPage - 1}" class="page-arrow">&lt;</a>
                </c:when>
                <c:otherwise>
                  <span class="page-arrow disabled">&lt;</span>
                </c:otherwise>
              </c:choose>

              <span class="current-page">${currentPage}</span>

              <c:choose>
                <c:when test="${currentPage < totalPages}">
                  <a href="${basePageUrl}&page=${currentPage + 1}" class="page-arrow">&gt;</a>
                </c:when>
                <c:otherwise>
                  <span class="page-arrow disabled">&gt;</span>
                </c:otherwise>
              </c:choose>

              <c:choose>
                <c:when test="${currentPage < totalPages}">
                  <a href="${basePageUrl}&page=${totalPages}" class="page-arrow">≫</a>
                </c:when>
                <c:otherwise>
                  <span class="page-arrow disabled">≫</span>
                </c:otherwise>
              </c:choose>
            </c:if>
          </div>
        </c:otherwise>
      </c:choose>

      <div class="review-buttons">
        <div class="allButton">전체 보기</div>
		<div class="writeButton"
		     style="cursor: pointer;"
		     onclick="location.href='${pageContext.request.contextPath}/mypage'">
		  리뷰작성
		</div>
      </div>
    </div>
  </div>
</div>


<script>
  // 페이지 나가기 전에 현재 스크롤 위치 저장
  window.addEventListener("beforeunload", function () {
    sessionStorage.setItem("scrollY", window.scrollY);
  });

  // 페이지 로드 시 저장된 위치로 이동
  window.addEventListener("load", function () {
    const scrollY = sessionStorage.getItem("scrollY");
    if (scrollY !== null) {
      window.scrollTo(0, parseInt(scrollY));
      sessionStorage.removeItem("scrollY"); // 복원 후 제거
    }
  });
</script>
</body>
</html>
