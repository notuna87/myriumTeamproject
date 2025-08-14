<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
  <title>상품 리뷰</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/review.css" />
   <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/reset.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage/review.css" />
</head>
<body>
<%@ include file="../main/header.jsp" %>

  <h1 class="page-title">상품 리뷰</h1>
<div class="review-container">
  <div class="product-info-box">
    <img src="${pageContext.request.contextPath}/upload/${product.img_path}" alt="상품 이미지" class="product-img">
    <div class="product-detail">
      <p class="product-name">${product.productName}</p>
      <p class="product-price"><fmt:formatNumber value="${product.productPrice}" pattern="#,###" />원</p>
      <div class="product-buttons">
		  <button class="btn-detail"
		  onclick="location.href='${pageContext.request.contextPath}/mypage/review/viewAndRedirect?productId=${product.productId}'">
		  상품상세보기
		</button>
		</div>
    </div>
  </div>

  <form id="reviewForm"
      action="${pageContext.request.contextPath}/mypage/review/submit"
      method="post"
      enctype="multipart/form-data"
      class="review-form"
      novalidate>
  <input type="hidden" name="productId" value="${product.productId}" />
    <div class="form-row">
      <label>제목</label>
      <input type="text" name="title" />
    </div>

    <div class="form-row">
      <label>평점</label>
      <div class="rating">
        <label><input type="radio" name="rating" value="5" /> ★★★★★</label>
        <label><input type="radio" name="rating" value="4" /> ★★★★☆</label>
        <label><input type="radio" name="rating" value="3" /> ★★★☆☆</label>
        <label><input type="radio" name="rating" value="2" /> ★★☆☆☆</label>
        <label><input type="radio" name="rating" value="1" /> ★☆☆☆☆</label>
      </div>
    </div>

    <div class="form-row">
      <label>본문</label>
      <textarea name="content" rows="10"></textarea>
    </div>
    
    <div class="form-row">
	  <label>첨부파일</label>
	  <input type="file" name="uploadFile1" onchange="previewImage(this)" />
	</div>
	<img id="preview" style="display:none; width:150px; margin-top:10px;" />

    <div class="btn-bottom-group">
	  <button type="button" class="btn-list" onclick="location.href='/mypage/order-history'">목록</button>
	  <button type="reset" class="btn-cancel">취소</button>
	  <button type="submit" class="btn-submit-final">등록</button>
	</div>
  </form>
  </div>
  
  <%@ include file="/WEB-INF/views/main/footer.jsp" %>
  
	<script>
	function previewImage(input) {
	  const preview = document.getElementById('preview');
	  if (input.files && input.files[0]) {
	    const reader = new FileReader();
	    reader.onload = function(e) {
	      preview.src = e.target.result;
	      preview.style.display = "block";
	    };
	    reader.readAsDataURL(input.files[0]);
	  }
	}
	</script>
	<script>
(function () {
  const form = document.getElementById('reviewForm');

  form.addEventListener('submit', function (e) {
    // 초기화
    clearErrors();

    const title   = form.querySelector('input[name="title"]');
    const content = form.querySelector('textarea[name="content"]');
    const rating  = form.querySelector('input[name="rating"]:checked');
    const file    = form.querySelector('input[name="uploadFile1"]');

    const errors = [];

    if (!title.value.trim()) {
      errors.push({el: title, msg: '제목을 입력해 주세요.'});
    }

    if (!rating) {
      // 라디오 그룹은 대표 라디오를 찾아 포커스 주기
      const firstRating = form.querySelector('input[name="rating"]');
      errors.push({el: firstRating, msg: '평점을 선택해 주세요.'});
    }

    if (!content.value.trim()) {
      errors.push({el: content, msg: '본문을 입력해 주세요.'});
    }


    if (!file.files || file.files.length === 0) {
    errors.push({el: file, msg: '첨부파일을 선택해 주세요.'});
     }

    if (errors.length > 0) {
      e.preventDefault(); // 서버 전송 막기

      // 첫 번째 에러에 포커스
      errors[0].el.focus();

      // 간단 팝업
      alert(errors.map(e => '• ' + e.msg).join('\n'));

      // 시각적 표시(선택)
      errors.forEach(e => e.el.classList.add('is-error'));
    }
  });

  function clearErrors() {
    form.querySelectorAll('.is-error').forEach(el => el.classList.remove('is-error'));
  }
})();
</script>
</body>
</html>
