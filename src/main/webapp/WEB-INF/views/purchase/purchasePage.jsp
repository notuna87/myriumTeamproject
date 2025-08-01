<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/reset.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/purchasePage.css" />
</head>
<body>
<div class="purchaseWrap">
        <header>
            <div class="header"><a class="beforeButton"><img src="${pageContext.request.contextPath}/resources/img/button/sfix_header.png" alt="afterButton"></a>마이리움</div>
            <div class="headerPurchase">주문/결제</div>
        </header>
        <section>
            <!-- 주문 정보 시작 -->
            <div class="orderInfoWrap">
                <div class="orderInfoTitle">주문 정보</div>
                <div class="orderInfoContent">
                    <table>
                        <tr>
                            <th>주문자</th>
                            <td><input type="text" class="bigTextBox"></td>
                        </tr>
                        <tr>
                            <th>휴대전화</th>
                            <td><input type="text" class="phoneTextBox"> - <input type="text" class="phoneTextBox"> -
                                <input type="text" class="phoneTextBox">
                            </td>
                        </tr>
                        <tr>
                            <th class="addressTopTh" rowspan="3">주소</th>
                            <td><input type="text" class="addressTop" readonly><input type="button"
                                    class="addressSearchButton" value="주소검색"></td>
                        </tr>
                        <tr>
                            <td><input type="text" class="bigTextBox" readonly></td>
                        </tr>
                        <tr>
                            <td><input type="text" class="bigTextBox"></td>
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
                            <th>주문자</th>
                            <td><input type="text" class="bigTextBox"></td>
                        </tr>

                        <tr>
                            <th class="addressTopTh" rowspan="3">주소</th>
                            <td><input type="text" class="addressTop" readonly><input type="button"
                                    class="addressSearchButton" value="주소검색"></td>
                        </tr>
                        <tr>
                            <td><input type="text" class="bigTextBox" readonly></td>
                        </tr>
                        <tr>
                            <td><input type="text" class="bigTextBox"></td>
                        </tr>
                        <tr>
                            <th>휴대전화</th>
                            <td><input type="text" class="phoneTextBox"> - <input type="text" class="phoneTextBox"> -
                                <input type="text" class="phoneTextBox">
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="messageSelectWrap">
                    <select id="messageSelect" class="messageSelect">
                        <option value="msgSelect-0" selected="selected">-- 메시지 선택 (선택사항) --</option>
                        <option value="msgSelect-1">배송 전에 미리 연락바랍니다.</option>
                        <option value="msgSelect-2">부재 시 경비실에 맡겨주세요.</option>
                        <option value="msgSelect-3">부재 시 문 앞에 놓아주세요.</option>
                        <option value="msgSelect-4">빠른 배송 부탁드립니다.</option>
                        <option value="msgSelect-5">택배함에 보관해 주세요.</option>
                        <option value="msgSelect-6">직접 입력</option>
                    </select>
                    <input type="text" class="bigTextBox" id="customMessage" style="display: none; margin-top: 15px;">
                </div>
            </div>
            <!-- 배송지 끝 -->
            <!-- 주문 상품 시작 -->
            <div class="orderProductWrap">
                <div class="orderProductTitle">주문상품</div>
                <div class="orderProduct">
                    <table style="border-bottom: 1px dashed #E9E9E9; width: 100%;">
                        <tr>
                            <th><img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRgcKJBzVf6xWEHZX3rvDJU-W8IQ1O45zsU_g&s"
                                    alt="test" class="orderProductThumbnail"></th>
                            <td>
                                <p style="margin-bottom: 10px;">몰티즈 리트리버</p>
                                <p style="color: #888">몰티즈 리트리버는 기엽습니다</p>
                                <p style="color: #888; margin-bottom: 10px;">수량 : 2마리</p>
                                <p style="margin-bottom: 10px;">150,000원</p>
                            </td>
                            <td style="width:77px;">
                                <div class="deleteButton">삭제하기</div>
                            </td>
                        </tr>
                    </table>
                    <table style="border-bottom: 1px dashed #E9E9E9; width: 100%;">
                        <tr>
                            <th><img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRgcKJBzVf6xWEHZX3rvDJU-W8IQ1O45zsU_g&s"
                                    alt="test" class="orderProductThumbnail"></th>
                            <td>
                                <p style="margin-bottom: 10px;">몰티즈 리트리버</p>
                                <p style="color: #888">몰티즈 리트리버는 기엽습니다</p>
                                <p style="color: #888; margin-bottom: 10px;">수량 : 2마리</p>
                                <p style="margin-bottom: 10px;">150,000원</p>
                            </td>
                            <td style="width:77px;">
                                <div class="deleteButton">삭제하기</div>
                            </td>
                        </tr>
                    </table>

                    <!-- 배송비 시작 -->
                    <div class="totalPriceWrap">
                        <span>배송비</span>
                        <span style="float: right; font-weight:600;">3,000원</span>
                    </div>
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
                            <td><span style="float: right;">150,000원</span></td>
                        </tr>
                        <tr>
                            <th>배송비</th>
                            <td><span style="float: right;">+ 3,000원</span></td>
                        </tr>
                    </table>
                </div>
                <div class="finalPaymentAmount">
                    <table>
                        <tr>
                            <th>최종 결제 금액</th>
                            <td><span style="float: right;">153,000원</span></td>
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
                            <input type="radio" name="payment" value="card" checked>
                            <span>무통장입금</span>
                        </label>

                        <label>
                            <input type="radio" name="payment" value="card">
                            <span>신용카드</span>
                        </label>

                        <label>
                            <input type="radio" name="payment" value="card" >
                            <span>가상계좌</span>
                        </label>

                        <label>
                            <input type="radio" name="payment" value="card" >
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
                    <p>배송정보 제공방침 동의<span>&nbsp;&nbsp;&nbsp;<a href="#">자세히 ></a></span></p>
                    <p>청약철회방침 동의<span>&nbsp;&nbsp;&nbsp;<a href="#">자세히 ></a></span></p>
                </div>
                <h4>주문 내용을 확인하였으며 약관에 동의합니다.</h4>
            </div>
            <!-- 구매 조건 동의서 끝 -->
            <!-- 구매하기 버튼 시작 -->
            <div class="purchaseButton">153,000원 결제하기</div>
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


</body>
<script>
    // 배송 메시지 선택 직접입력 보이기, 숨기기 스크립트
    document.addEventListener("DOMContentLoaded", function () {
        const selectBox = document.getElementById("messageSelect");
        const customInput = document.getElementById("customMessage");

        selectBox.addEventListener("change", function () {
            if (selectBox.value === "msgSelect-6") {
                customInput.style.display = "inline-block"; // 보이게
            } else {
                customInput.style.display = "none"; // 숨기기
                customInput.value = ""; // 선택 바뀌면 입력 초기화
            }
        });
    });
</script>
</html>