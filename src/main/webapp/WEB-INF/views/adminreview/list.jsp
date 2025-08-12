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

	<div class="row">
		<div class="col-lg-12">
			<h1 class="page-header">리뷰관리<span class="badge">관리자</span></h1>
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
						<span class="badge">NEW</span> 3일 이내 작성된 리뷰입니다.
						<c:out value="${groupedReviews}"></c:out>
					</div> 
			
			        <div class="panel-body">			          
					    <!-- <form action="/adminproduct/list" method="get" class="form-inline" style="margin-bottom:10px;">
					        <select name="category" class="form-control">
							    <option value= "">카테고리</option>
							    <option value="원예용품" <c:if test="${param.category == '원예용품'}">selected</c:if>>원예용품</option>
							    <option value="식물키트모음" <c:if test="${param.category == '식물키트모음'}">selected</c:if>>식물키트모음</option>
							    <option value="허브키우기" <c:if test="${param.category == '허브키우기'}">selected</c:if>>허브키우기</option>
							    <option value="채소키우기" <c:if test="${param.category == '채소키우기'}">selected</c:if>>채소키우기</option>
							    <option value="꽃씨키우기" <c:if test="${param.category == '꽃씨키우기'}">selected</c:if>>꽃씨키우기</option>
							    <option value="기타키우기키트" <c:if test="${param.category == '기타키우기키트'}">selected</c:if>>기타키우기키트</option>
							</select>
					        <select name="is_discount" class="form-control">
					            <option value= -1>일반할인여부</option>
					            <option value= 1 <c:if test="${param.is_discount == 1}">selected</c:if>>할인중</option>
					            <option value= 0 <c:if test="${param.is_discount == 0}">selected</c:if>>없음</option>
					        </select>
					        <select name="is_timesales" class="form-control">
					            <option value= -1>타임세일여부</option>
					            <option value= 1 <c:if test="${param.is_timesales == 1}">selected</c:if>>할인중</option>
					            <option value= 0 <c:if test="${param.is_timesales == 0}">selected</c:if>>없음</option>
					        </select>
					        <select name="is_deleted" class="form-control">
					            <option value= -1>노출여부</option>
					            <option value= 0 <c:if test="${param.is_deleted == 0}">selected</c:if>>노출</option>
					            <option value= 1 <c:if test="${param.is_deleted == 1}">selected</c:if>>비노출</option>
					        </select>
					        <button type="submit" class="btn btn-primary">필터</button>
					        <button type="button" class="btn btn-info" onclick="location.href='/adminproduct/list'">필터 초기화</button>
	
					    </form> -->
				    
            <!-- 리뷰 목록 테이블 -->
            <table class="table table-bordered table-hover">
              <thead>
                <tr>
                  <th class="text-center">최종리뷰일</th>
                  <th class="text-center">리뷰이미지</th>
                  <th class="text-center">상품ID</th>
                  <th class="text-center">상품명</th>
                  <th class="text-center">리뷰수</th>
                  <th class="text-center">평균평점</th>
                  <th class="text-center">보기</th>                
                </tr>
              </thead>
              <tbody>
                <c:forEach var="items" items="${productReviewSummary}">
                  <tr>
                    <td class="text-center"><fmt:formatDate value="${items.lastReviewDate}" pattern="yyyy-MM-dd" /></td>
                	<td class="text-center">
		            	<img src="${pageContext.request.contextPath}/upload/${items.imageUrl}" style="width: 60px; height: 60px; object-fit: cover; border-radius: 4px;">
		            </td>
                    <td class="text-center">${items.productId}</td>
                    <td class="text-left">
                      <a href="javascript:void(0);" class="product-link" data-productId="${items.productId}">
                        ${items.productName}
                      </a>
                    </td>
                    <td class="text-center">${items.reviewCount}</td>
                    <td class="text-center">
					  <fmt:formatNumber value="${items.avgRating}" type="number" minFractionDigits="1" maxFractionDigits="1"/>
					</td>
                    <td class="text-center">
                      <button class="btn btn-sm btn-primary review-detail-btn" data-productId="${items.productId}" data-productName="${items.productName}">
                        보기
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
										<option value="T" <c:out value="${pageMaker.cri.type eq 'C'?'selected':''}"/>>제목</option>
										<option value="P" <c:out value="${pageMaker.cri.type eq 'P'?'selected':''}"/>>상품명</option>
										<option value="C" <c:out value="${pageMaker.cri.type eq 'CP'?'selected':''}"/>>고객ID</option>
										<option value="TP" <c:out value="${pageMaker.cri.type eq 'TC'?'selected':''}"/>>제목 or 상품명</option>
										<option value="TC" <c:out value="${pageMaker.cri.type eq 'TW'?'selected':''}"/>>제목	or 고객ID</option>
										<option value="TPC" <c:out value="${pageMaker.cri.type eq 'TWC'?'selected':''}"/>>제목 or 상품명 or 고객ID</option>
									</select>
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
	
						<form id='actionForm' action="/adminreview/list" method='get'>
							<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum}'> <input
								type='hidden' name='amount' value='${pageMaker.cri.amount}'> <input type='hidden'
								name='type' value='${pageMaker.cri.type}'> <input type='hidden' name='keyword'
								value='${pageMaker.cri.keyword}'>
						</form>
			        </div>
			      </sec:authorize>
			
			      
			              <!-- 리뷰 모달 (페이징 포함) -->
			        <div class="modal fade" id="reviewModal" tabindex="-1" role="dialog" aria-labelledby="reviewModalLabel" aria-hidden="true">
			          <div class="modal-dialog modal-lg">
			            <div class="modal-content">
			              <div class="modal-header">
			                <button type="button" class="close" data-dismiss="modal" aria-label="닫기">
			                  <span aria-hidden="true">&times;</span>
			                </button>
			                <h4 class="modal-title" id="reviewModalLabel">상품 리뷰 목록</h4>
			              </div>
			              <div class="modal-body" id="reviewList">
			                <p>상품명: <span id="modalProductName"></span></p>
        					<p><a href="#" id="modalProductLink" target="_blank">상품페이지 바로가기</a></p>
			                <!-- 리뷰 리스트 동적으로 로드 -->
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
    
    //var ordersList = JSON.parse('${ordersJson}');
    //var reviewsData = ${list};
    //var ordersList = JSON.parse('${fn:escapeXml(ordersJson)}');
    //console.log("ReviewsJson:", reviewsData); // 정상 출력 확인용
    
    
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
    

	  // 상품명 클릭 또는 '보기' 버튼 클릭 시 모달 열기 & 리뷰 로드
	  $('.product-link, .review-detail-btn').on('click', function() {
	    const productName = $(this).data('productname');
	    const productId = $(this).data('productid');	    
	    // 모달 내부 상품명 표시
	    $('#modalProductName').text(productName);
	    
	    // 상품페이지 링크 URL 만들기 (예)
	    let productPageUrl = '/product/detail/' + productId;
	    
	    // 모달 내 링크 href 설정 및 텍스트 지정
	    $('#modalProductLink')
	        .attr('href', productPageUrl)
	        .text('상품페이지 바로가기');
	    
	    loadReviews(productId, 1); // 1페이지부터 로드
	    $('#reviewModal').modal('show');
	  });

	  // 리뷰 목록 및 페이징 AJAX 로드 함수
	  function loadReviews(productId, pageNum) {
	    $.ajax({
	      url: '/adminreview/productreviewlist', // 서버에서 페이징 리뷰 리스트 반환하는 API 주소로 변경
	      method: 'GET',
	      dataType: 'json',
	      data: { productId: productId, pageNum: pageNum },
	      success: function(data) {
	    	  
	    	  
	        // 서버에서 JSON 형식으로 리뷰 리스트와 페이징 정보 반환 가정
	        // 예) data = { reviews: [...], pagination: { currentPage, totalPages } }

	        // 리뷰 리스트 렌더링
	        console.log("랜더링:------>" );
	        let html = '<table class="table table-bordered">';	        
	        html += '<thead><tr><th>이미지</th><th>리뷰일</th><th>작성자</th><th>리뷰 내용</th><th>평점</th><th>관리</th></tr></thead><tbody>';
	        data.list.forEach(function(review) {
	          html += '<tr>';
	          html += '<td><img src="${pageContext.request.contextPath}/upload/' + review.imageUrl + ' style="width: 100px; height: 100px; object-fit: cover; border-radius: 4px;"></td>';
	          html += '<td>' + review.reviewDate + '</td>';
	          html += '<td>' + review.customerId + '</td>';
	          html += '<td>' + review.reviewContent + '</td>';
	          html += '<td>' + review.rating + '</td>';
	          html += '<td>';
	          html += '<button class="btn btn-xs btn-warning review-edit-btn" data-reviewId="' + review.id + '">내림</button> ';
	          html += '<button class="btn btn-xs btn-danger review-delete-btn" data-reviewId="' + review.id + '">삭제</button>';
	          html += '</td>';
	          html += '</tr>';
	        });
	        html += '</tbody></table>';
	        $('#reviewList').html(html);

	        // 페이징 렌더링
	        let paginationHtml = '';
	        for(let i=1; i<=data.pagination.totalPages; i++) {
	          paginationHtml += '<li class="page-item ' + (i === data.pagination.currentPage ? 'active' : '') + '">';
	          paginationHtml += '<a href="javascript:void(0);" class="page-link review-page-link" data-page="' + i + '" data-productid="' + productId + '">' + i + '</a></li>';
	        }
	        $('#reviewPagination').html(paginationHtml);
	      },
	      error: function() {
	        $('#reviewList').html('<p>리뷰를 불러오는 중 오류가 발생했습니다.</p>');
	        $('#reviewPagination').html('');
	      }
	    });
	  }

	  // 페이징 클릭 시 리뷰 다시 로드
	  $(document).on('click', '.review-page-link', function() {
	    const page = $(this).data('page');
	    const productId = $(this).data('productid');
	    loadReviews(productId, page);
	  });

	  // 리뷰 수정, 삭제 버튼 클릭 이벤트 처리 추가 필요
	  $(document).on('click', '.review-edit-btn', function() {
	    const reviewId = $(this).data('reviewid');
	    alert('리뷰 수정 - 리뷰ID: ' + reviewId);
	    // 실제 수정 모달 혹은 페이지 이동 코드 작성
	  });

	  $(document).on('click', '.review-delete-btn', function() {
	    const reviewId = $(this).data('reviewid');
	    if(confirm('리뷰를 삭제하시겠습니까?')) {
	      // 삭제 AJAX 호출 작성
	      alert('리뷰 삭제 - 리뷰ID: ' + reviewId);
	    }
	  });

});
</script>

</body>

<%@include file="../includes_admin/footer.jsp"%>
<%@include file="../main/footer.jsp"%>