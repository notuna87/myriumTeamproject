<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<jsp:useBean id="now" class="java.util.Date" />

<%@include file="../main/header.jsp"%>
<%@include file="../includes_admin/header.jsp"%>

<style>
   table.table td, table.table th {
      vertical-align: middle !important;
      text-align: center;
   }
   table.table {
      font-size: 13px;
   }
</style>

<!-- 뒤로가기 시 조회수 증가를 위해 새로고침 -->
<!-- 한 세션에서 여러번 조회수 늘릴수 있음 : 세션 당 조회수 중복 방지 적용 안됨 -> 구현과제 -->
<script>
    window.onpageshow = function(event) {
        if (event.persisted || window.performance.navigation.type === 2) {
            location.reload();
        }
    };
</script>

<body>

	<div class="row">
		<div class="col-lg-12">
			<h1 class="page-header">주문관리<span class="badge">관리자</span></h1>
		</div>
	</div>
	<div class="row">
		<div class="col-lg-12">
			<div class="panel panel-default">
			    <section class="content">
			      <sec:authorize access="isAuthenticated()">
			        <sec:authorize access="isAuthenticated()">
			          <input type="hidden" name="updatedBy" value='<sec:authentication property="principal.username"/>' />
			        </sec:authorize>
					<div class="panel-heading">
						<span class="badge">NEW</span> 새로운 주문입니다. 주문확인 후 발송준비 하세요.
					</div> 
			
			        <div class="panel-body">			          
  					    <!-- 필터링 섹션 -->
					    <form action="/adminorder/list" method="get" class="form-inline" style="margin-bottom:10px;">
					        <select name="orderStatus" class="form-control">
					            <option value= -1 <c:if test="${param.orderStatus == -1}">selected</c:if>>주문상태</option>
					            <option value= 0 <c:if test="${param.orderStatus == 0}">selected</c:if>>입금전</option>
					            <option value= 1 <c:if test="${param.orderStatus == 1}">selected</c:if>>배송준비중</option>				            
					            <option value= 2 <c:if test="${param.orderStatus == 2}">selected</c:if>>배송중</option>				            
					            <option value= 3 <c:if test="${param.orderStatus == 3}">selected</c:if>>배송완료</option>				            
					            <option value= 4 <c:if test="${param.orderStatus == 4}">selected</c:if>>교환신청</option>				            
					            <option value= 5 <c:if test="${param.orderStatus == 5}">selected</c:if>>교환완료</option>				            
					            <option value= 6 <c:if test="${param.orderStatus == 6}">selected</c:if>>반품신청</option>				            
					            <option value= 7 <c:if test="${param.orderStatus == 7}">selected</c:if>>반품완료</option>				            
					            <option value= 8 <c:if test="${param.orderStatus == 8}">selected</c:if>>취소신청</option>				            
					            <option value= 9 <c:if test="${param.orderStatus == 9}">selected</c:if>>취소완료</option>				            
					            <option value= 10 <c:if test="${param.orderStatus == 10}">selected</c:if>>환불거절</option>				            
					            <option value= 11 <c:if test="${param.orderStatus == 11}">selected</c:if>>환불완료</option>				            
					            <option value= 12 <c:if test="${param.orderStatus == 12}">selected</c:if>>교환승인</option>				            
					            <option value= 13 <c:if test="${param.orderStatus == 13}">selected</c:if>>교환거절</option>				            
					            <option value= 14 <c:if test="${param.orderStatus == 14}">selected</c:if>>반품승인</option>				            
					            <option value= 15 <c:if test="${param.orderStatus == 15}">selected</c:if>>반품거절</option>				            
					            <option value= 16 <c:if test="${param.orderStatus == 16}">selected</c:if>>취소승인</option>				            
					            <option value= 17 <c:if test="${param.orderStatus == 17}">selected</c:if>>취소거절</option>				            
					            <option value= 18 <c:if test="${param.orderStatus == 18}">selected</c:if>>구매확정</option>        
					        </select>

					        <button type="submit" class="btn btn-primary">필터</button>
					        <button type="button" class="btn btn-info" onclick="location.href='/adminorder/list'">필터 초기화</button>
	
					    </form>
				    
			            <table class="table table-bordered table-hover">
			              <thead>
			                <tr>
			                  <th class="text-center">주문일</th>
			                  <th class="text-center">주문번호</th>			                  
			                  <th class="text-center">주문상품</th>
			                  <th class="text-center">상품수</th>
			                  <th class="text-center">주문상태</th>
			                  <th class="text-center">고객명</th>
			                  <th class="text-center">주소</th>
			                  <th class="text-center">전화번호</th>
			                  <th class="text-center">주문정보</th>
			                </tr>
			              </thead>
			              <tbody>
			                <c:forEach var="entry" items="${groupedOrders}">
			                  <c:set var="ordersKey" value="${entry.key}" />
			                  <c:set var="items" value="${entry.value}" />
			                  
			                  <tr>
			                    <td class="text-center">${items[0].orderDate}</td>
			                    <td class="text-center">${items[0].ordersId}
			                    	<!-- NEW 라벨: 발송처리되지 않은 주문 -->
			                    	
				                    <c:if test="${items[0].orderStatus == 1}">
				                    <c:out value="${items[0].orderStatus}"></c:out>
				                        <span class="badge badge-danger ml-1">NEW</span>
				                    </c:if></td>			                    
			                    <td class="text-left">
			                      ${items[0].productName}
			                      <c:if test="${fn:length(items) > 1}">
			                        외 ${fn:length(items) - 1}
			                      </c:if>
			                    </td>
			                    <td class="text-right">${fn:length(items)}</td>
			                    <td class="text-center">${items[0].orderStatusText}</td>
			                    <td class="text-center">${items[0].receiver}</td>
			                    <td class="text-left">${items[0].address}</td>
			                    <td class="text-center">${items[0].phoneNumber}</td>
			                    <td class="text-center">
			                      <button class="btn btn-sm btn-primary"
			                              onclick="showOrderModal('${items[0].ordersId}')">
			                        자세히
			                      </button>
			                    </td>
			                  </tr>
			                </c:forEach>
			              </tbody>
			            </table>
			            
						<!-- 검색조건 -->
						<div class='row'>
							<div class="col-lg-12">
								<form id='searchForm' action="/adminorder/list" method='get'>
									<select name='type' >
										<option value="C" <c:out value="${pageMaker.cri.type eq 'C'?'selected':''}"/>>고객명</option>
										<option value="P" <c:out value="${pageMaker.cri.type eq 'P'?'selected':''}"/>>상품</option>
										<option value="CP" <c:out value="${pageMaker.cri.type eq 'CP'?'selected':''}"/>>고객명 or 상품</option>
									</select>
									<input type='hidden' name='type' value="C" />
									<input type='hidden' name='type' value="P" />
									<input type='text' name='keyword' value='<c:out value="${pageMaker.cri.keyword}"/>' /> 
									<input type='hidden' name='pageNum' value='<c:out value="${pageMaker.cri.pageNum}"/>' /> 
									<input type='hidden' name='amount' value='<c:out value="${pageMaker.cri.amount}"/>' />
	
									
									<button type="submit" class="btn btn-sm btn-primary">
										<i class="fa fa-search"></i> 주문검색
									</button>
								</form>
							</div>
						</div>
						<!-- end 검색조건 -->
	
	
	
						<!-- 페이지 처리 -->
						<div class="pull-right">
							<ul class="pagination">
								<c:if test="${pageMaker.prev}">
									<li class="paginate_button"><a class="page-link" href="${pageMaker.startPage-1}">Previous</a></li>
								</c:if>
	
								<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
									<li class="paginate_button ${pageMaker.cri.pageNum == num ? 'active': ''} "><a
										href="${num}">${num}</a></li>
								</c:forEach>
	
								<c:if test="${pageMaker.next}">
									<li class="paginate_button"><a href="${pageMaker.endPage+1}">Next</a></li>
								</c:if>
							</ul>
						</div>
						<!-- end 페이지 처리 -->
	
						<form id='actionForm' action="/adminorder/list" method='get'>
							<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum}'> <input
								type='hidden' name='amount' value='${pageMaker.cri.amount}'> <input type='hidden'
								name='type' value='${pageMaker.cri.type}'> <input type='hidden' name='keyword'
								value='${pageMaker.cri.keyword}'>
						</form>
			        </div>
			      </sec:authorize>
			
			      <!-- 주문 상세 모달 -->
			      <div class="modal fade" id="orderModal" tabindex="-1" role="dialog" aria-labelledby="orderModalLabel" aria-hidden="false">
			        <div class="modal-dialog modal-lg">
			          <div class="modal-content">
			            <div class="modal-header">
			              <button type="button" class="close" data-dismiss="modal" aria-label="닫기">
			                <span aria-hidden="false">&times;</span>
			              </button>
			              <h4 class="modal-title" id="orderModalLabel">주문 상세 내역</h4>
			            </div>
			            <div class="modal-body" id="modalBody">
			              <!-- 주문 상세 내용 동적으로 로드 -->
			            </div>
			            <div class="modal-footer">
			              <button type="button" class="btn btn-default pull-left" data-dismiss="modal">닫기</button>
			            </div>
			          </div>
			        </div>
			      </div>			
			    </section>			
			</div>
  		</div>
	</div>



<!-- jQuery -->
<script src="/resources/bsAdmin2/resources/vendor/jquery/jquery.min.js"></script>
<script src="/resources/bsAdmin2/resources/vendor/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
    var result = '${result}'; 
    
    var ordersList = JSON.parse('${ordersJson}');
    //var ordersList = JSON.parse('${fn:escapeXml(ordersJson)}');
    console.log("ordersList:", ordersList); // 정상 출력 확인용
    
    window.showOrderModal = function (ordersId) {
        console.log("showOrderModal called with ordersId:", ordersId);

        var modalBody = $('#modalBody');

        // 주문번호(ordersId) 기준 필터링
        var filteredItems = ordersList.filter(function (item) {
            return item.ordersId === ordersId;
        });

        console.log("Filtered items:", filteredItems);

        if (filteredItems.length === 0) {
            modalBody.html('<p>해당 주문에 대한 상품이 없습니다.</p>');
            $('#orderModal').modal('show');
            return;
        }

        // 주문 정보 (첫 번째 아이템 기준)
        var orderInfo = filteredItems[0];

        var html = '<h5>주문번호: ' + ordersId + '</h5>' +
            '<p>주문일: ' + orderInfo.orderDate + '</p>' +
            '<p>고객명: ' + orderInfo.receiver + '</p>' +
            '<p>주소: ' + orderInfo.address + '</p>' +
            '<p>전화번호: ' + orderInfo.phoneNumber + '</p>' +

            '<table class="table table-bordered">' +
            '<thead><tr>' +
            '<th class="text-center">주문상품번호</th>' +
            '<th class="text-center">상품명</th>' +
            '<th class="text-center">수량</th>' +
            '<th class="text-center">상태</th>' +
            '<th class="text-center">처리</th>' +
            '</tr></thead><tbody>';

            filteredItems.forEach(function (item) {
                var statusText = '';
                switch (item.order_status_product) {
                    case 0: statusText = "<span class='label label-default'>입금전</span>"; break;
                    case 1: statusText = "<span class='label label-primary'>배송준비중</span>"; break;
                    case 2: statusText = "<span class='label label-secondary'>배송중</span>"; break;
                    case 3: statusText = "<span class='label label-success'>배송완료</span>"; break;
                    case 4: statusText = "<span class='label label-warning'>교환신청</span>"; break;
                    case 5: statusText = "<span class='label label-success'>교환완료</span>"; break;
                    case 6: statusText = "<span class='label label-warning'>반품신청</span>"; break;
                    case 7: statusText = "<span class='label label-success'>반품완료</span>"; break;
                    case 8: statusText = "<span class='label label-warning'>취소신청</span>"; break;
                    case 9: statusText = "<span class='label label-success'>취소완료</span>"; break;
                    case 10: statusText = "<span class='label label-danger'>환불거절</span>"; break;
                    case 11: statusText = "<span class='label label-success'>환불완료</span>"; break;
                    case 12: statusText = "<span class='label label-success'>교환승인</span>"; break;
                    case 13: statusText = "<span class='label label-danger'>교환거절</span>"; break;
                    case 14: statusText = "<span class='label label-success'>반품승인</span>"; break;
                    case 15: statusText = "<span class='label label-danger'>반품거절</span>"; break;
                    case 16: statusText = "<span class='label label-success'>취소승인</span>"; break;
                    case 17: statusText = "<span class='label label-danger'>취소거절</span>"; break;
                    case 18: statusText = "<span class='label label-info'>구매확정</span>"; break;
                }

            html += '<tr>' +
                '<td class="text-center">' + item.orders_product_id + '</td>' +
                '<td class="text-left">' + item.productName + '</td>' +
                '<td class="text-right">' + item.quantity + '</td>' +
                '<td class="text-center">' + statusText + '</td>' +                            
                '<td class="text-center">';
                
            switch (item.order_status_product) {
                case 0: html += '<button class="btn btn-sm btn-success update-status-btn" data-oid="' + item.ordersId + '" data-pid="' + item.orders_product_id + '" data-status="1">배송준비중</button>'; break;
                case 1: html += '<button class="btn btn-sm btn-success update-status-btn" data-oid="' + item.ordersId + '" data-pid="' + item.orders_product_id + '" data-status="2">배송중</button>'; break;
                case 2: html += '<button class="btn btn-sm btn-success update-status-btn" data-oid="' + item.ordersId + '" data-pid="' + item.orders_product_id + '" data-status="3">배송완료</button>'; break;
                case 3: html += '<button class="btn btn-sm btn-success update-status-btn" data-oid="' + item.ordersId + '" data-pid="' + item.orders_product_id + '" data-status="18">구매확정</button>'; break;
                case 4: html += '<button class="btn btn-sm btn-success update-status-btn" data-oid="' + item.ordersId + '" data-pid="' + item.orders_product_id + '" data-status="12">교환승인</button>' +
                				'<button class="btn btn-sm btn-danger update-status-btn" data-oid="' + item.ordersId + '" data-pid="' + item.orders_product_id + '" data-status="13">교환거절</button>'; break;
                case 5: html += '<button class="btn btn-sm btn-success update-status-btn" data-oid="' + item.ordersId + '" data-pid="' + item.orders_product_id + '" data-status="2">배송중</button>'; break;
                case 6: html += '<button class="btn btn-sm btn-success update-status-btn" data-oid="' + item.ordersId + '" data-pid="' + item.orders_product_id + '" data-status="14">반품승인</button>' +
                				'<button class="btn btn-sm btn-danger update-status-btn" data-oid="' + item.ordersId + '" data-pid="' + item.orders_product_id + '" data-status="15">반품거절</button>'; break;
                case 7: html += '<button class="btn btn-sm btn-success update-status-btn" data-oid="' + item.ordersId + '" data-pid="' + item.orders_product_id + '" data-status="11">환불완료</button>'; break;
                case 8: html += '<button class="btn btn-sm btn-success update-status-btn" data-oid="' + item.ordersId + '" data-pid="' + item.orders_product_id + '" data-status="16">취소승인</button>' +
                				'<button class="btn btn-sm btn-danger update-status-btn" data-oid="' + item.ordersId + '" data-pid="' + item.orders_product_id + '" data-status="17">취소거절</button>'; break;
                case 9: html += '<button class="btn btn-sm btn-success update-status-btn" data-oid="' + item.ordersId + '" data-pid="' + item.orders_product_id + '" data-status="11">환불완료</button>'; break;
                case 10: html += '<button class="btn btn-sm btn-success update-status-btn" data-oid="' + item.ordersId + '" data-pid="' + item.orders_product_id + '" data-status="11">환불완료</button>'; break;
                case 12: html += '<button class="btn btn-sm btn-success update-status-btn" data-oid="' + item.ordersId + '" data-pid="' + item.orders_product_id +'" data-status="2">배송중</button>'; break;
                case 13: html += '<button class="btn btn-sm btn-success update-status-btn" data-oid="' + item.ordersId + '" data-pid="' + item.orders_product_id +'" data-status="12">교환승인</button>'; break;
                case 14: html += '<button class="btn btn-sm btn-success update-status-btn" data-oid="' + item.ordersId + '" data-pid="' + item.orders_product_id +'" data-status="11">환불완료</button>'; break;
                case 15: html += '<button class="btn btn-sm btn-success update-status-btn" data-oid="' + item.ordersId + '" data-pid="' + item.orders_product_id +'" data-status="14">반품승인</button>'; break;
                case 16: html += '<button class="btn btn-sm btn-success update-status-btn" data-oid="' + item.ordersId + '" data-pid="' + item.orders_product_id +'" data-status="9">환불완료</button>'; break;
                case 17: html += '<button class="btn btn-sm btn-success update-status-btn" data-oid="' + item.ordersId + '" data-pid="' + item.orders_product_id +'" data-status="16">취소승인</button>'; break;
            }

        	html += '</td></tr>';
        });
        
        html += '</tbody></table>';

        modalBody.html(html);
        $('#orderModal').modal('show');
    };
    
    $(document).on('click', '.update-status-btn', function () {
        var $btn = $(this);
        var ordersId = $btn.data('oid');
        var ordersProductId = $btn.data('pid');
        var orderStatus = $btn.data('status');

        if (!confirm("상태를 변경하시겠습니까?")) return;

        $.ajax({
            url: '/adminorder/updateStatus',
            type: 'POST',
            data: {
                ordersId: ordersId,
                orders_product_id: ordersProductId,
                orderStatus: orderStatus
            },
            success: function (response) {
                alert("상태가 변경되었습니다.");

                // 버튼이 있는 행을 찾는다
                var $tr = $btn.closest('tr');

                // 상태 텍스트가 들어있는 4번째 <td> (0-based index: 3)
                var $statusTd = $tr.find('td').eq(3);

                // 상태 코드를 텍스트로 변환하는 함수 호출
                $statusTd.text(getStatusText(orderStatus));

                // 버튼 영역은 5번째 <td> (index:4)
                var $actionTd = $tr.find('td').eq(4);

                // 상태에 따라 버튼 다시 갱신 (아래 함수 참고)
                $actionTd.html(getActionButtons(orderStatus, ordersId, ordersProductId));
            },
            error: function (xhr, status, error) {
                console.error(error);
                alert("상태 변경 중 오류가 발생했습니다.");
            }
        });
    });

    // 상태 코드 -> 상태 텍스트 변환 함수 (모달 생성시와 동일하게 유지)
    function getStatusText(status) {
        switch (status) {
            case 0: return "입금전";
            case 1: return "배송준비중";
            case 2: return "배송중";
            case 3: return "배송완료";
            case 4: return "교환신청";
            case 5: return "교환완료";
            case 6: return "반품신청";
            case 7: return "반품완료";
            case 8: return "취소신청";
            case 9: return "취소완료";
            case 10: return "환불거절";
            case 11: return "환불완료";
            case 12: return "교환승인";
            case 13: return "교환거절";
            case 14: return "반품승인";
            case 15: return "반품거절";
            case 16: return "취소승인";
            case 17: return "취소거절";
            case 18: return "구매확정";
            default: return "알 수 없음";
        }
    }

    // 버튼 html 생성 함수 (모달 생성시 로직과 동일하게 맞춤 필요)
    function getActionButtons(status, ordersId, ordersProductId) {
        var html = '';
        switch (status) {
            case 0: 
                html = '<button class="btn btn-sm btn-success update-status-btn" data-oid="' + ordersId + '" data-pid="' + ordersProductId + '" data-status="1">배송준비중</button>'; 
                break;
            case 1: 
                html = '<button class="btn btn-sm btn-success update-status-btn" data-oid="' + ordersId + '" data-pid="' + ordersProductId + '" data-status="2">배송중</button>'; 
                break;
            case 2: 
                html = '<button class="btn btn-sm btn-success update-status-btn" data-oid="' + ordersId + '" data-pid="' + ordersProductId + '" data-status="3">배송완료</button>'; 
                break;
            case 3: 
                html = '<button class="btn btn-sm btn-success update-status-btn" data-oid="' + ordersId + '" data-pid="' + ordersProductId + '" data-status="18">구매확정</button>'; 
                break;
            case 4: 
                html = '<button class="btn btn-sm btn-success update-status-btn" data-oid="' + ordersId + '" data-pid="' + ordersProductId + '" data-status="12">교환승인</button>' +
                       '<button class="btn btn-sm btn-danger update-status-btn" data-oid="' + ordersId + '" data-pid="' + ordersProductId + '" data-status="13">교환거절</button>'; 
                break;
            case 5: 
                html = '<button class="btn btn-sm btn-success update-status-btn" data-oid="' + ordersId + '" data-pid="' + ordersProductId + '" data-status="2">배송중</button>'; 
                break;
            case 6: 
                html = '<button class="btn btn-sm btn-danger update-status-btn" data-oid="' + ordersId + '" data-pid="' + ordersProductId + '" data-status="14">반품승인</button>' +
                       '<button class="btn btn-sm btn-success update-status-btn" data-oid="' + ordersId + '" data-pid="' + ordersProductId + '" data-status="15">반품거절</button>'; 
                break;
            case 7: 
                html = '<button class="btn btn-sm btn-success update-status-btn" data-oid="' + ordersId + '" data-pid="' + ordersProductId + '" data-status="11">환불완료</button>'; 
                break;
            case 8: 
                html = '<button class="btn btn-sm btn-success update-status-btn" data-oid="' + ordersId + '" data-pid="' + ordersProductId + '" data-status="16">취소승인</button>' +
                       '<button class="btn btn-sm btn-danger update-status-btn" data-oid="' + ordersId + '" data-pid="' + ordersProductId + '" data-status="17">취소거절</button>'; 
                break;
            case 9: 
                html = '<button class="btn btn-sm btn-success update-status-btn" data-oid="' + ordersId + '" data-pid="' + ordersProductId + '" data-status="11">환불완료</button>'; 
                break;
            case 10: 
                html = '<button class="btn btn-sm btn-success update-status-btn" data-oid="' + ordersId + '" data-pid="' + ordersProductId + '" data-status="11">환불완료</button>'; 
                break;
            case 12: 
                html = '<button class="btn btn-sm btn-success update-status-btn" data-oid="' + ordersId + '" data-pid="' + ordersProductId +'" data-status="2">배송중</button>'; 
                break;
            case 13: 
                html = '<button class="btn btn-sm btn-success update-status-btn" data-oid="' + ordersId + '" data-pid="' + ordersProductId +'" data-status="12">교환승인</button>'; 
                break;
            case 14: 
                html = '<button class="btn btn-sm btn-success update-status-btn" data-oid="' + ordersId + '" data-pid="' + ordersProductId +'" data-status="11">환불완료</button>'; 
                break;
            case 15: 
                html = '<button class="btn btn-sm btn-success update-status-btn" data-oid="' + ordersId + '" data-pid="' + ordersProductId +'" data-status="14">반품승인</button>'; 
                break;
            case 16: 
                html = '<button class="btn btn-sm btn-success update-status-btn" data-oid="' + ordersId + '" data-pid="' + ordersProductId +'" data-status="9">환불완료</button>'; 
                break;
            case 17: 
                html = '<button class="btn btn-sm btn-success update-status-btn" data-oid="' + ordersId + '" data-pid="' + ordersProductId +'" data-status="16">취소승인</button>'; 
                break;
            default:
                html = ''; // 변경 가능한 상태가 없을 경우 빈 문자열 반환
        }
        return html;
    }
    
	var actionForm = $("#actionForm");
	$(".paginate_button a").on("click", function(e){
		e.preventDefault();
		console.log("click");
		
		actionForm.removeAttr("action"); //뒤로가기 후 기존 파라미터 누적문제 해결
		actionForm.find("input[name='id']").remove(); //뒤로가기 후 기존 파라미터 누적문제 해결
		
		// 클릭된 요소의 href 값을 찾아서 input 폼 안의 pageNum 필드에 설정		
		actionForm.find("input[name='pageNum']").val($(this).attr("href"));
		actionForm.submit();
	});
	
	var searchForm = $("#searchForm");

	$("#searchForm button").on("click", function(e){
		//if(!searchForm.find("option:selected").val()){
		//	alert("검색종류를 선택하세요");
		//	return false;
		//}

		//if(!searchForm.find("input[name='keyword']").val()){
		//	alert("키워드를 입력하세요");
		//	return false;
		//}
		searchForm.find("input[name='pageNum']").val("1");
		e.preventDefault();
		
		searchForm.submit();
		
	});	
    
});
</script>

</body>

<%@include file="../includes_admin/footer.jsp"%>
<%@include file="../main/footer.jsp"%>