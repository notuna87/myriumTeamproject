<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
  <title>상품 상세</title>
  <style>
    .productDetailWrap {
      padding: 40px;
    }
    .detailContents img {
      max-width: 100%;
    }
  </style>
</head>
<body>

  <div class="productDetailWrap">
    <div class="detailContents">
        <img src="${pageContext.request.contextPath}/upload/${productDetailImg.img_path}" alt="${product.product_name}" />
    </div>
  </div>

</body>
</html>
