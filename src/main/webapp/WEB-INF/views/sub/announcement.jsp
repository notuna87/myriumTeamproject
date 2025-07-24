<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
  <title>안내 사항</title>
</head>
<body>
  <div class="AnnouncementWrap">
    <!-- 상품 결제 정보 -->
    <div class="payment" onclick="toggleSection('payment')">
      상품 결제 정보
    </div>
    <div class="paymentContent" id="payment">
      <p>고액결제의 경우 안전을 위해 카드사에서 확인전화를 드릴 수도 있습니다. 확인과정에서 도난 카드의 사용이나 타인 명의의 주문등 정상적인 주문이 아니라고 판단될 경우 임의로 주문을 보류 또는 취소할 수 있습니다.</p>
      <br/>
      <p>무통장 입금은 상품 구매 대금은 PC뱅킹, 인터넷뱅킹, 텔레뱅킹 혹은 가까운 은행에서 직접 입금하시면 됩니다.</p>
      <p>주문시 입력한 입금자명과 실제입금자의 성명이 반드시 일치하여야 하며, 7일 이내로 입금을 하셔야 하며 입금되지 않은 주문은 자동취소 됩니다.</p>
    </div>

    <!-- 배송안내 -->
    <div class="shipping" onclick="toggleSection('shipping')">
      배송안내
    </div>
    <div class="shippingContent" id="shipping">
      <p>배송 방법: 택배</p>
      <p>배송 지역: 전국지역</p>
      <p>배송 비용: 3,000원</p>
      <p>배송 기간: 1일 ~ 3일</p>
      <p>배송 안내 : - 산간벽지나 도서지방은 별도의 추가금액을 지불하셔야 하는 경우가 있습니다.</p>
      <p>고객님께서 주문하신 상품은 입금 확인 후 배송해 드립니다. 다만, 상품종류에 따라서 상품의 배송이 다소 지연될 수 있습니다.</p>
    </div>

    <!-- 교환/반품 안내 -->
    <div class="exchange" onclick="toggleSection('exchange')">
      교환/반품 안내
    </div>
    <div class="exchangeContent" id="exchange">
      <p>교환 및 반품 주소</p>
      <p>- [47006] 부산광역시 사상구 주례로9번길 30 (주례동) 2층</p>
      <br/>
      <p>교환 및 반품이 가능한 경우</p>
      <p>- 계약내용에 관한 서면을 받은 날부터 7일. 단, 그 서면을 받은 때보다 재화등의 공급이 늦게 이루어진 경우에는 재화등을 공급받거나 재화등의 공급이 시작된 날부터 7일 이내</p>
      <p>- 공급받으신 상품 및 용역의 내용이 표시·광고 내용과 다르거나 계약내용과 다르게 이행된 때에는 당해 재화 등을 공급받은 날부터 3개월 이내, 그 사실을 알게 된 날 또는 알 수 있었던 날부터 30일 이내</p>
      <br/>
      <p>교환 및 반품이 불가능한 경우</p>
      <p>- 이용자에게 책임 있는 사유로 재화 등이 멸실 또는 훼손된 경우 (다만, 포장 훼손은 제외)</p>
      <p>- 이용자의 사용 또는 일부 소비에 의하여 재화 등의 가치가 현저히 감소한 경우</p>
      <p>- 시간의 경과에 의하여 재판매가 곤란할 정도로 가치가 감소한 경우</p>
      <p>- 복제가 가능한 재화 등의 포장을 훼손한 경우</p>
      <p>- 개별 주문 생산되는 재화 등 소비자의 사전 동의를 얻은 경우</p>
      <p>- 디지털 콘텐츠 제공이 개시된 경우 (단, 일부 미사용 콘텐츠는 철회 가능)</p>
      <br/>
      <p>※ 고객님의 단순 변심에 의한 교환·반품은 고객 부담입니다. (색상, 사이즈 교환 등 포함)</p>
    </div>
  </div>

  <script>
    function toggleSection(sectionId) {
      const section = document.getElementById(sectionId);
      if (section.classList.contains("open")) {
        section.classList.remove("open");
      } else {
        document.querySelectorAll(".paymentContent, .shippingContent, .exchangeContent")
          .forEach((el) => el.classList.remove("open"));
        section.classList.add("open");
      }
    }
  </script>
</body>
</html>
