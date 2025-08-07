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

  <h1 class="review-title">상품 리뷰</h1>
<div class="review-container">
  <div class="product-info-box">
    <img src="${pageContext.request.contextPath}/resources/img/sample/plant.png" alt="상품 이미지" class="product-img">
    <div class="product-detail">
      <p class="product-name">${product.productName}</p>
      <p class="product-price"><fmt:formatNumber value="${product.productPrice}" pattern="#,###" />원</p>
      <div class="product-buttons">
        <button class="btn-detail"
        onclick="location.href='${pageContext.request.contextPath}/sub?id=${product.productId}'">
  상품상세보기
</button>
      </div>
    </div>
  </div>

  <form action="${pageContext.request.contextPath}/mypage/review/submit" method="post" enctype="multipart/form-data" class="review-form">
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

<input type="file" name="uploadFile1" onchange="previewImage(this)" />
<img id="preview" src="#" alt="미리보기" style="width:150px; display:block; margin-top:10px;">
</body>
</html>
