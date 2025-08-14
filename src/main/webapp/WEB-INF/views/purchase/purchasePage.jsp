<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/reset.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/purchasePage.css" />

<!-- 카카오 주소 api -->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

</head>
<body>

	<form action="/purchasecomplete" method="post">
		<div class="purchaseWrap">
			<header>
				<div class="header">
					<a class="beforeButton" href="${pageContext.request.contextPath}/cart"><img src="${pageContext.request.contextPath}/resources/img/button/sfix_header.png" alt="afterButton"></a>마이리움
				</div>
				<div class="headerPurchase">주문/결제</div>
			</header>
			<section>
				<!-- 주문 정보 시작 -->
				<div class="orderInfoWrap">
					<div class="orderInfoTitle">주문자 정보</div>
					<div class="orderInfoContent">
						<table>
							<tr>
								<th>주문자</th>
								<td>${memberInfo.customerName}</td>
							</tr>
							<tr>
								<th>휴대전화</th>
								<td>${fn:split(memberInfo.phoneNumber, '-')[0]}-${fn:split(memberInfo.phoneNumber, '-')[1]}-${fn:split(memberInfo.phoneNumber, '-')[2]}</td>
							</tr>
							<tr>
								<th class="addressTopTh" rowspan="3">주소</th>
								<td>${memberInfo.address}</td>
							</tr>
						</table>
					</div>
				</div>
				<!-- 주문정보 끝 -->
				<!-- 배송지 시작 -->
				<div class="orderInfoWrap">
					<div class="orderInfoTitle">배송지</div>
					<div class="orderInfoContent">
						<table>
							<tr>
								<th>주문자${directPurchaseStatus}</th>

								<td><input type="text" name="customerName" class="bigTextBox" value="${memberInfo.customerName}"></td>
							</tr>
							<tr>
								<th class="addressTopTh" rowspan="3">주소</th>
								<td><input type="text" name="zipcode" id="postcode" class="addressTop" value="${memberInfo.zipcode}" readonly> <input type="button" class="addressSearchButton" value="주소검색" onclick="execDaumPostcode()"></td>
							</tr>
							<tr>
								<td><input type="text" id="roadAddress" name="addr1" class="bigTextBox" value="${memberInfo.addr1}" readonly></td>
							</tr>
							<tr>
								<td><input type="text" id="detailAddress" name="addr2" class="bigTextBox" value="${memberInfo.addr2}"></td>
							</tr>
							<tr>
								<th>휴대전화</th>
								<td><c:set var="phoneParts" value="${fn:split(memberInfo.phoneNumber, '-')}" /> <c:set var="phoneFirst" value="${phoneParts[0]}" /> <select class="phoneTextBox" name="phone1" style="padding: 7px;">
										<option value="010" <c:if test="${phoneFirst == '010'}">selected</c:if>>010</option>
										<option value="011" <c:if test="${phoneFirst == '011'}">selected</c:if>>011</option>
										<option value="016" <c:if test="${phoneFirst == '016'}">selected</c:if>>016</option>
										<option value="018" <c:if test="${phoneFirst == '018'}">selected</c:if>>018</option>
										<option value="019" <c:if test="${phoneFirst == '019'}">selected</c:if>>019</option>
								</select> - <input type="text" name="phone2" class="phoneTextBox" value="${fn:split(memberInfo.phoneNumber, '-')[1]}"> - <input type="text" name="phone3" class="phoneTextBox" value="${fn:split(memberInfo.phoneNumber, '-')[2]}"></td>
							</tr>
						</table>
					</div>
					<div class="messageSelectWrap">
						<select id="messageSelect" name="messageSelect" class="messageSelect">
							<option value="msgSelect-0" selected="selected">-- 메시지 선택 (선택사항) --</option>
							<option>배송 전에 미리 연락바랍니다.</option>
							<option>부재 시 경비실에 맡겨주세요.</option>
							<option>부재 시 문 앞에 놓아주세요.</option>
							<option>빠른 배송 부탁드립니다.</option>
							<option>택배함에 보관해 주세요.</option>
							<option value="msgSelect-6">직접 입력</option>
						</select>
						<input type="text" name="customMessage" class="bigTextBox" id="customMessage" style="display: none; margin-top: 15px;">
					</div>
				</div>
				<!-- 배송지 끝 -->
				<!-- 주문 상품 시작 -->
				<div class="orderProductWrap">
					<div class="orderProductTitle">주문상품</div>
					<div class="orderProduct">
						<!-- 서브페이지에서 바로 구매시 -->
						<c:if test="${directPurchaseStatus == 1}">
							<div class="cartContentsWrap">
								<table style="border-bottom: 1px dashed #E9E9E9; width: 100%;">
									<tr>
										<th><img src="${pageContext.request.contextPath}/upload/${productDirectPurchase.thumbnail.img_path}" alt="test" class="orderProductThumbnail"></th>
										<td><input type="hidden" name="productId" value="${productDirectPurchase.product.id}">
											<p style="margin-bottom: 10px;">${productDirectPurchase.product.product_name}</p>
											<p style="color: #888">${productDirectPurchase.product.product_content}</p> <input type="hidden" name="quantity" value="${quantity}">
											<p class="productQty" style="color: #888; margin-bottom: 10px;" data-qty="${quantity}">수량 : ${quantity}개</p>
											<p style="margin-bottom: 10px;">
												<c:if test="${productDirectPurchase.product.discount_price != 0 }">
													<span class="productPrice" data-price="${productDirectPurchase.product.discount_price}"><fmt:formatNumber value="${productDirectPurchase.product.discount_price * quantity}" type="number" groupingUsed="true" />원</span>
												</c:if>
												<c:if test="${productDirectPurchase.product.discount_price == 0}">
													<span class="productPrice" data-price="${productDirectPurchase.product.product_price}"><fmt:formatNumber value="${productDirectPurchase.product.product_price * quantity}" type="number" groupingUsed="true" />원</span>
												</c:if>
											</p></td>
									</tr>
								</table>
							</div>
						</c:if>
						<!-- 장바구니에서 구매 시 -->
						<c:if test="${directPurchaseStatus != 1}">
							<c:if test="${cartList == null || cartList.isEmpty()}">
								<script>
       								 alert('장바구니가 비어있습니다. 홈으로 이동합니다.');
    							     window.location.href = '${pageContext.request.contextPath}/';
   								 </script>
							</c:if>
							<c:forEach var="item" items="${cartList}">
								<div class="cartContentsWrap">
									<table style="border-bottom: 1px dashed #E9E9E9; width: 100%;">
										<tr>
											<th><img src="${pageContext.request.contextPath}/upload/${item.thumbnail.img_path}" alt="test" class="orderProductThumbnail"></th>
											<td><input type="hidden" name="productId" value="${item.product.id}">
												<p style="margin-bottom: 10px;">${item.product.product_name}</p>
												<p style="color: #888">${item.product.product_content}</p> <input type="hidden" name="quantity" value="${item.inCart.quantity}">
												<p class="productQty" style="color: #888; margin-bottom: 10px;" data-qty="${item.inCart.quantity}">수량 : ${item.inCart.quantity}개</p>
												<p style="margin-bottom: 10px;">
													<c:if test="${item.product.discount_price != 0 }">
														<span class="productPrice" data-price="${item.product.discount_price}"><fmt:formatNumber value="${item.product.discount_price * item.inCart.quantity}" type="number" groupingUsed="true" />원</span>
													</c:if>
													<c:if test="${item.product.discount_price == 0}">
														<span class="productPrice" data-price="${item.product.product_price}"><fmt:formatNumber value="${item.product.product_price * item.inCart.quantity}" type="number" groupingUsed="true" />원</span>
													</c:if>

												</p></td>
											<td style="width: 77px;">
												<button type="button" class="deleteButton" onclick="deleteProduct('increase', this)" data-product-id="${item.product.id}">삭제하기</button>
											</td>
										</tr>
									</table>
								</div>
							</c:forEach>
						</c:if>
						<!-- 배송비 시작 -->
						<div class="totalPriceDiv"></div>
					</div>
				</div>
				<!-- 배송비 끝 -->
				<!-- 주문 상품 끝 -->

				<!-- 결제 정보 시작 -->
				<div class="paymentInfoWrap">
					<div class="paymentInfoTitle">결제정보</div>
					<div class="paymentInfo">
						<table>
							<tr>
								<th>주문상품</th>
								<td class="cartTotal"></td>
							</tr>
							<tr class="deliveryPay">

							</tr>
						</table>
					</div>
					<div class="finalPaymentAmount">
						<table>
							<tr>
								<th>최종 결제 금액</th>
								<td class="cartTotalwithDelivery"></td>

							</tr>
						</table>
					</div>
				</div>
				<!-- 결제 정보 끝-->
				<!-- 결제 수단 시작-->
				<div class="paymentMethodWrap">
					<div class="paymentMethodTitle">결제 수단</div>
					<div class="paymentMethod">
						<p>결제수단 선택</p>
						<div class="methodSelect">
							<label>
								<input type="radio" name="payment" value="0" checked>
								<span>무통장입금</span>
							</label>

							<label>
								<input type="radio" name="payment" value="1">
								<span>신용카드</span>
							</label>

							<label>
								<input type="radio" name="payment" value="2">
								<span>가상계좌</span>
							</label>

							<label>
								<input type="radio" name="payment" value="3">
								<span>실시간 계좌이체</span>
							</label>
						</div>
					</div>
				</div>
				<!-- 결제 수단 끝 -->
				<!-- 구매 조건 동의서 시작 -->
				<div class="purchaseAgreeWrap">
					<div class="purchaseAgree">
						<p>구매조건 확인 및 결제진행 동의</p>
						<p>
							배송정보 제공방침 동의<span>&nbsp;&nbsp;&nbsp;<a href="#">자세히 ></a></span>
						</p>
						<p>
							청약철회방침 동의<span>&nbsp;&nbsp;&nbsp;<a href="#">자세히 ></a></span>
						</p>
					</div>
					<h4>주문 내용을 확인하였으며 약관에 동의합니다.</h4>
				</div>
				<!-- 구매 조건 동의서 끝 -->
				<!-- 구매하기 버튼 시작 -->
				<button type="submit" class="purchaseButton"></button>
				<!-- 구매하기 버튼 끝 -->
				<!-- 푸터 시작 -->
				<div class="footer">
					<p>무이자할부가 적용되지 않은 상품과 무이자할부가 가능한 상품을 동시에 구매할 경우 전체 주문 상품 금액에 대해 무이자할부가 적용되지 않습니다. 무이자할부를 원하시는 경우 장바구니에서 무이자할부 상품만 선택하여 주문하여 주시기 바랍니다.</p>
					<br>
					<p>최소 결제 가능 금액은 결제금액에서 배송비를 제외한 금액입니다.</p>
				</div>
				<!-- 푸터 끝 -->
			</section>
		</div>
	</form>
</body>
<script>

	// 배송 메시지 선택 직접입력 보이기, 숨기기 스크립트
	document.addEventListener("DOMContentLoaded", function() {
		const selectBox = document.getElementById("messageSelect");
		const customInput = document.getElementById("customMessage");

		selectBox.addEventListener("change", function() {
			if (selectBox.value === "msgSelect-6") {
				customInput.style.display = "inline-block"; // 보이게
			} else {
				customInput.style.display = "none"; // 숨기기
				customInput.value = ""; // 선택 바뀌면 입력 초기화
			}
		});
	});
	// 총 가격 계산
	  function updateTotalPrice(){
		  const productContainers = document.querySelectorAll('.cartContentsWrap');
		  let total = 0;
		  let newtotal = 0;
		  
		  productContainers.forEach(container => {
			  const priceE1 = container.querySelector('.productPrice');
			  const qtyE1 = container.querySelector('.productQty');
			  if (priceE1 && qtyE1) {
				  const price = parseInt(priceE1.getAttribute('data-price')) || 0;
				  const qty = parseInt(qtyE1.getAttribute('data-qty')) || 1;
				  
				  total += price * qty;
				  
			  }
		  });
		  
		  if (total < 49900){
			newtotal = total + 3000;
			  document.querySelector('.totalPriceDiv').innerHTML = `
					<div class="totalPriceWrap"><span>배송비</span> <span style="float: right; font-weight: 600;">3,000원</span></div>
			  `;
			  
			  document.querySelector('.deliveryPay').innerHTML = `
					<th>배송비</th>
					<td><span style="float: right;">+ 3,000원</span></td>	
			  `;
			  
			  
		  } else {
			newtotal = total;
		  }
		  
		  
		  const formattedTotal = total.toLocaleString(); // 3자리 단위 콤마
		  const deliveryTotal = newtotal.toLocaleString();

		  document.querySelector('.cartTotal').innerHTML = `
			  <span style="float: right;">$${'{formattedTotal}'}원</span>
			  <input type="hidden" name="formattedTotal" value="$${'{total}'}">
		  `;
		  
		  document.querySelector('.cartTotalwithDelivery').innerHTML = `
			  <span style="float: right;">$${'{deliveryTotal}'}원</span>
			  <input type="hidden" name="totalprice" value="$${'{newtotal}'}">
		  `;

		  document.querySelector('.purchaseButton').innerHTML = `
			  <span>$${'{deliveryTotal}'}원 결제하기</span>
		  `;
	  }
	  document.addEventListener("DOMContentLoaded", updateTotalPrice);
	  
	  function execDaumPostcode() {
		    new daum.Postcode({
		        oncomplete: function(data) {
		            // 선택된 주소 정보로 input 채우기
		            document.getElementById('postcode').value = data.zonecode; // 우편번호
		            document.getElementById('roadAddress').value = data.roadAddress; // 도로명주소
		            document.getElementById('detailAddress').focus(); // 포커스를 상세주소로 이동
		        }
		    }).open();
		}

	  // 삭제시
	  function deleteProduct(action, button) {
		  
		 	const isConfirmed = confirm("장바구니에서도 삭제됩니다. 정말 삭제하시겠습니까?");
		    if (!isConfirmed) return; // 취소 누르면 함수 종료

		  	const productContainer = button.closest('.cartContentsWrap');
		    const container = button.closest('.cartDelete');
		    const productId = button.getAttribute('data-product-id');
			const meta = document.querySelector('meta[name="_csrf"]');
			const csrfToken = meta ? meta.getAttribute('content') : '';
			
		    // AJAX 요청 보내기 (서버에 수량 업데이트)
		    fetch('/cart/delete', {
		      method: 'POST',
		      headers: {
	  			'Content-Type': 'application/json',
	  			'X-CSRF-TOKEN': csrfToken
		      },
		      body: JSON.stringify({
		        productId: productId
		      })
		    })
		    .then(response => {
		      if (!response.ok) {
		        throw new Error('서버 오류 발생');
		      }
		      return response.json();
		    })
		    .then(data => {
		      console.log('삭제완료', data);
		      productContainer.remove();
		      
		      const remainingItems = document.querySelectorAll('.cartContentsWrap');
		        if (remainingItems.length === 0) {
		            alert('주문상품이 비었습니다. 홈으로 이동합니다.');
		            window.location.href = '/'; // 홈 페이지 URL로 이동
		        }
		      updateTotalPrice();
		    })
		    .catch(error => {
		      console.error('삭제 실패:', error);
		      alert('삭제에 실패했습니다.');
		    });
		  }
</script>
</html>