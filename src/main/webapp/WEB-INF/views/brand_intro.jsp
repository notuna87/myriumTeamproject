<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>브랜드 소개 | myrium</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/reset.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/brand_intro.css" />
</head>
<body>
  <%@ include file="/WEB-INF/views/main/header.jsp" %>

<!-- 히어로(브랜드 메시지) -->
<section class="brand-hero"
  style="background-image:url('${pageContext.request.contextPath}/resources/img/brand_intro/1.png');">
  <div class="brand-hero__inner">
    <h1 class="brand-hero__title hero-text">식물을 키워보고 싶지만,<br/>어떻게 시작해야할지 모르시겠죠?</h1>
    <p class="brand-hero__subtitle hero-text hero-text--delay-1">
      나는 식물을 죽이기만 해서, 나는 식물을 잘 못키워서<br/>
      걱정이시라면 마이리움이 알려드려요.
    </p>
  </div>
</section>

  <!-- 인트로: 씨앗, 한번 키워보실래요? -->
  <section class="brand-intro section" aria-labelledby="seed-title">
  <div class="container">
    <div class="brand-intro__media reveal" data-delay="0">
      <img src="<c:url value='/resources/img/brand_intro/2.png'/>"
           alt="img2" loading="lazy" />
    </div>
    <div class="brand-intro__text reveal" data-delay="120">
      <h2 id="seed-title" class="section-title">씨앗, 한번 키워보실래요?</h2>
      <p class="section-desc">
      마이리움은 식물을 한번도 키워보지 않은 사람들과<br/>
      식물을 이제 막 키우는 초보자들을 위한 반려식물키트 쇼핑몰입니다.<br/>
      식물을 키워보고 싶지만 어디서부터 어떻게 시작해야할지<br/>
      모르겠다면 씨앗을 심어보는 일부터 시작해보세요.</p>
    </div>
  </div>
</section>

<section class="brand-section">
  <div class="container">
    <div class="brand-section__text reveal" data-delay="0">
      <h2 class="section-title">한 알의 씨앗이 주는 힘</h2>
      <p class="section-desc">
        한 알의 씨앗을 심고, 가꾸고, 키우다보면<br/>
        어느새 식물을 재배하고, 수확하는 기쁨을 알게될거예요.
      </p>
      <p class="section-desc">
        물론, 처음에는 실패할수도 있고<br/>
        생각하지도 못한 어려움이 생길지도 모르지만<br/>
        "그것만으로도 충분해요!"
      </p>
    </div>
    <div class="brand-section__image reveal" data-delay="120">
      <img src="${pageContext.request.contextPath}/resources/img/brand_intro/3.png"
           alt="img3" loading="lazy">
    </div>
  </div>
</section>

<!-- 내 마음건강을 위한 첫걸음 -->
<section class="brand-section brand-section--reverse">
  <div class="container">
    <div class="brand-section__image reveal" data-delay="0">
      <img src="${pageContext.request.contextPath}/resources/img/brand_intro/4.png"
           alt="img4" loading="lazy">
    </div>
    <div class="brand-section__text reveal" data-delay="120">
      <h2 class="section-title">내 마음건강을 위한 첫걸음</h2>
      <p class="section-desc">
      나만의 반려식물과 함께<br/>
      작은 즐거움과, 생명력의 기쁨을 알아가며<br/>
      바쁜 삶 속에서 힐링시간을 가져보세요.<br/>
      여러분의 도전을 언제나 옆에서 응원합니다.</p>
    </div>
  </div>
</section>


  <%-- 필요 시 더 아래 섹션 이어서 추가 --%>
  <%@ include file="/WEB-INF/views/main/footer.jsp" %>
  
  <script>
  (function () {
    const els = document.querySelectorAll('.reveal');
    if (!('IntersectionObserver' in window)) {
      els.forEach(el => el.classList.add('is-visible')); // 구형 브라우저 fallback
      return;
    }

    const io = new IntersectionObserver((entries) => {
      entries.forEach(entry => {
        if (entry.isIntersecting) {
          entry.target.classList.add('is-visible');
          // once 옵션이 있으면 관찰 중지
          if (entry.target.classList.contains('once')) io.unobserve(entry.target);
        }
      });
    }, { root: null, rootMargin: '0px 0px -10% 0px', threshold: 0.15 });

    els.forEach(el => io.observe(el));
  })();
</script>
</body>
</html>
