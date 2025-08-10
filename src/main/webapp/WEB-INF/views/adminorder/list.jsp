<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<jsp:useBean id="now" class="java.util.Date" />

<%@include file="../main/header.jsp"%>
<%@include file="../includes_admin/header.jsp"%>

<style>
  .category-label {
    display: inline-block;
    margin: 1px;
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
<div class="wrapper">

  <div class="content-wrapper" style="min-height: 600px; padding: 15px;">
    <section class="content-header">
      <h1>
        주문 현황
        <small>사용자별 주문 관리</small>
      </h1>
    </section>

    <section class="content">
      <sec:authorize access="isAuthenticated()">
        <sec:authorize access="isAuthenticated()">
          <input type="hidden" name="updatedBy" value='<sec:authentication property="principal.username"/>' />
        </sec:authorize>

        <div class="box box-primary">
          <div class="box-header with-border">
            <h3 class="box-title">주문 리스트</h3>
          </div>

          <div class="box-body table-responsive no-padding">
            <table class="table table-bordered table-hover">
              <thead>
                <tr>
                  <th>주문번호</th>
                  <th>주문일</th>
                  <th>주문상품</th>
                  <th>상품수</th>
                  <th>주문상태</th>
                  <th>고객명</th>
                  <th>주소</th>
                  <th>전화번호</th>
                  <th>자세히보기</th>
                </tr>
              </thead>
              <tbody>
                <c:forEach var="entry" items="${groupedOrders}">
                  <c:set var="ordersKey" value="${entry.key}" />
                  <c:set var="items" value="${entry.value}" />
                  
                  <tr>
                    <td>${items[0].ordersId}</td>
                    <td>${items[0].orderDate}</td>
                    <td>
                      ${items[0].productName}
                      <c:if test="${fn:length(items) > 1}">
                        외 ${fn:length(items) - 1}
                      </c:if>
                    </td>
                    <td>${fn:length(items)}</td>
                    <td>${items[0].orderStatusText}</td>
                    <td>${items[0].receiver}</td>
                    <td>${items[0].address}</td>
                    <td>${items[0].phoneNumber}</td>
                    <td>
                      <button class="btn btn-sm btn-primary"
                              onclick="showOrderModal('${items[0].ordersId}')">
                        자세히보기
                      </button>
                    </td>
                  </tr>
                </c:forEach>
              </tbody>
            </table>
          </div>
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



<!-- jQuery -->
<script src="/resources/bsAdmin2/resources/vendor/jquery/jquery.min.js"></script>
<script src="/resources/bsAdmin2/resources/vendor/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
    var result = '${result}'; 
    
    var ordersList = JSON.parse('${ordersJson}');
    //var ordersList = JSON.parse('${fn:escapeXml(ordersJson)}');
    console.log("ordersList:", ordersList); // 정상 출력 확인용
    
    
    $(document).on('click', '.btn-box-tool', function() {
        var box = $(this).closest('.box');
        var icon = $(this).find('i');
        var body = box.find('.box-body');

        if (box.hasClass('collapsed-box')) {
            body.slideDown();
            box.removeClass('collapsed-box');
            icon.removeClass('fa-plus').addClass('fa-minus');
        } else {
            body.slideUp();
            box.addClass('collapsed-box');
            icon.removeClass('fa-minus').addClass('fa-plus');
        }
    });

    window.showOrderModal = function(ordersId) {
        console.log("showOrderModal called with ordersId:", ordersId);

        var modalBody = $('#modalBody');

        // 주문번호(ordersId) 기준 필터링
        var filteredItems = ordersList.filter(function(item) {
          return item.ordersId === ordersId;
        });

        console.log("Filtered items:", filteredItems);

        if (filteredItems.length === 0) {
          modalBody.html('<p>해당 주문에 대한 상품이 없습니다.</p>');
          $('#orderModal').modal('show');
          return;
        }

        // 주문 정보(대표 상품명, 주문일, 고객명 등) 가져오기 (첫 번째 아이템 기준)
        var orderInfo = filteredItems[0];

        var html = '<h5>주문번호: ' + ordersId + '</h5>' +
          '<p>주문일: ' + orderInfo.orderDate + '</p>' +
          '<p>고객명: ' + orderInfo.receiver + '</p>' +
          '<p>주소: ' + orderInfo.address + '</p>' +
          '<p>전화번호: ' + orderInfo.phoneNumber + '</p>' +

          '<table class="table table-bordered">' +
          '<thead><tr>' +
          '<th>주문상품번호</th>' +
          '<th>상품명</th>' +
          '<th>수량</th>' +
          '<th>상태</th>' +
          '<th>승인처리</th>' +
          '</tr></thead><tbody>';

        filteredItems.forEach(function(item) {
          html += '<tr>' +
            '<td>' + item.orders_product_id + '</td>' +
            '<td>' + item.productName + '</td>' +
            '<td>' + item.quantity + '</td>' +
            '<td>' + (function(status) {
              switch(status) {
	              case 0: return "입금전";
	              case 1: return "배송준비중";
	              case 2: return "배송중";
	              case 3: return "배송완료";
	              case 4: return "교환신청중";
	              case 5: return "교환완료";
	              case 6: return "환불신청중";
	              case 7: return "환불완료";
	              case 8: return "주문취소중";
	              case 9: return "취소완료";
              }
            })(item.orderStatus) + '</td>' +
            '<td>';

          if (item.orderStatus === 4 || item.orderStatus === 6) {
            html += '<button class="btn btn-sm btn-success">승인</button>' +
            '<button class="btn btn-sm btn-warning">보류</button>' +
            '<button class="btn btn-sm btn-danger">거절</button>' +
            '<button class="btn btn-sm btn-primary">취소</button>';
          }

          html += '</td></tr>';
        });

        html += '</tbody></table>';

        modalBody.html(html);
        $('#orderModal').modal('show');
    };
    
	checkModal(result);
	//상태 객체, 제목,  URL, 현재 상태를 빈 상태로 대체, 뒤로가기 버튼을 눌렀을 때 이전 페이지로 되돌아가지 않고 현재 페이지에 그대로 만듬
	history.replaceState({}, null,null);   // 뒤로가기 모달창을 보여준 뒤에는 더 이상 모달창이 필요하지 않음
	//페이지 이동(뒤로가기)하므로 세션 기록(history)을 조작하는history.replaceState({}, null, null); 메서드 사용
           //마지막 값이 null로 설정되면 현재 URL이 유지
	
	function checkModal(result){
		if(result === '' || history.state){  //빈문자열이거나 history.state true일 때 모달이 보이지 않음
			return ;
		}else{
			if(parseInt(result)>0){
				$(".modal-body").html("상품 " + parseInt(result) + "번이 등록되었습니다.");
			}
			$("#myModal").modal("show");
		}
	}
	
	$("#regBtn").on("click",function(){
		self.location = "/adminmember/register";
	})
	
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
	
	$(".move").on("click", function(e) {
		e.preventDefault();
		
		actionForm.find("input[name='id']").remove(); //뒤로가기 후 기존 파라미터 누적문제 해결
		
		actionForm.append("<input type='hidden' name='id' value='" + $(this).attr("href") + "'>");
		actionForm.attr("action","/adminmember/modify");
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
    
	// 관리자용 버튼 이벤트
	$(document).on("click", ".edit-btn", function () {
	    const id = $(this).data("id");
	    window.location.href = "/adminmember/modify?id=" + id;
	});

	$(document).on("click", ".harddel-btn", function () {
	    const id = $(this).data("id");
	    if (confirm("삭제 후 복구할 수 없습니다. 정말 삭제하시겠습니까?")) {
	        $.ajax({
	            type: "post",
	            url: "/adminmember/harddel",
	            data: { id: id },
	            success: function () {
	                location.reload();
	            },
	            error: function () {
	                alert("계정 삭제 실패");
	            }
	        });
	    }
	});
	
	$(document).on("click", ".softdel-btn", function () {
	    const id = $(this).data("id");
	    if (confirm("계정이 비활성됩니다.")) {
	        $.ajax({
	            type: "post",
	            url: "/adminmember/softdel",
	            data: { id: id },
	            success: function () {
	                location.reload();
	            },
	            error: function () {
	                alert("계정 비활성 실패");
	            }
	        });
	    }
	});

	$(document).on("click", ".restore-btn", function () {
	    const id = $(this).data("id");
	    if (confirm("계정이 활성됩니다.")) {
	        $.ajax({
	            type: "post",
	            url: "/adminmember/restore",
	            data: { id: id },
	            success: function () {
	                location.reload();
	            },
	            error: function () {
	                alert("계정 활성 실패");
	            }
	        });
	    }
	});
    
});
</script>

</body>

<%@include file="../includes_admin/footer.jsp"%>
<%@include file="../main/footer.jsp"%>