<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<jsp:useBean id="now" class="java.util.Date" />

<%@include file="../includes_admin/header.jsp"%>

<style>
  .category-label {
    display: inline-block;
    margin: 1px;
  }
    
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
<div style="width:1240px; margin:0 auto;">
<%@include file="../main/header.jsp"%>
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
				    
            <!-- 리뷰 목록 테이블 -->
            <table class="table table-bordered table-hover">
              <thead>
                <tr>
                  <th class="text-center" style="vertical-align:middle;">최종리뷰일</th>
                  <th class="text-center" style="vertical-align:middle;">리뷰이미지</th>
                  <th class="text-center" style="vertical-align:middle;">상품ID</th>
                  <th class="text-center" style="vertical-align:middle;">상품명</th>
                  <th class="text-center" style="vertical-align:middle;">리뷰수</th>
                  <th class="text-center" style="vertical-align:middle;">평균평점</th>
                  <th class="text-center" style="vertical-align:middle;">보기</th>                
                </tr>
              </thead>
              <tbody>
                <c:forEach var="items" items="${productReviewSummary}">
                  <tr>
                    <td class="text-center" style="vertical-align:middle;"><fmt:formatDate value="${items.lastReviewDate}" pattern="yyyy-MM-dd" /></td>
                	<td class="text-center" style="vertical-align:middle;">
		            	<img src="${pageContext.request.contextPath}/upload/${items.imageUrl}" style="width: 60px; height: 60px; object-fit: cover; border-radius: 4px;">
		            </td>
                    <td class="text-center" style="vertical-align:middle;">${items.productId}</td>
                    <td class="text-left" style="vertical-align:middle;">
                      <a href="javascript:void(0);" class="product-link" data-productid="${items.productId}">
                        ${items.productName}
                      </a>
                    </td>
                    <td class="text-center" style="vertical-align:middle;">${items.reviewCount}</td>
                    <td class="text-center" style="vertical-align:middle; color:#ffc107;">★ <fmt:formatNumber value="${items.avgRating}" type="number" minFractionDigits="1" maxFractionDigits="1"/>
					</td>
                    <td class="text-center" style="vertical-align:middle;">
                      <button class="btn btn-sm btn-primary review-detail-btn" data-productid="${items.productId}" data-productname="${items.productName}">
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
								<form id='searchFormReview' action="/adminreview/list" method='get'>
									<select name='type' >
										<option value="" <c:out value="${pageMaker.cri.type == null ? 'selected' : ''}" /> >선택하세요</option>
										<option value="P" <c:out value="${pageMaker.cri.type eq 'P'?'selected':''}"/>>상품명</option>
									</select>
									<input type='text' name='keyword' value='<c:out value="${pageMaker.cri.keyword}"/>' /> 
									<input type='hidden' name='pageNum' value='<c:out value="${pageMaker.cri.pageNum}"/>' /> 
									<input type='hidden' name='amount' value='<c:out value="${pageMaker.cri.amount}"/>' />
	
									
									<button type="submit" class="btn btn-sm btn-primary">
										<i class="fa fa-search"></i> 검색
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
							<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum}'>
							<input type='hidden' name='amount' value='${pageMaker.cri.amount}'>
							<input type='hidden' name='type' value='${pageMaker.cri.type}'>
							<input type='hidden' name='keyword'	value='${pageMaker.cri.keyword}'>
						</form>
			        </div>
			      </sec:authorize>
			
			      
					<!-- 리뷰 모달 (포토리뷰 스타일) -->
					<div class="modal fade" id="reviewModal" tabindex="-1" role="dialog" aria-labelledby="reviewModalLabel" aria-hidden="true" data-currentpage="1">
					  <div class="modal-dialog modal-lg">
					    <div class="modal-content">
					      <div class="modal-header">
					        <button type="button" class="close" data-dismiss="modal" aria-label="닫기">
					          <span aria-hidden="false">&times;</span>
					        </button>
					        <h4 class="modal-title" id="reviewModalLabel">상품 리뷰 목록</h4>
					      </div>
					
					      <div class="modal-body">
					        <p>상품명: <span id="modalProductName"></span></p>
					        <p><a href="" id="modalProductLink" target="_blank">상품페이지 바로가기</a></p>
					
					        <!-- 리뷰 목록 -->
					        <div id="reviewList" class="row">
					          <!-- 동적으로 리뷰 카드 삽입 -->
					        </div>
					
					        <!-- 페이지네이션 -->
					        <div class="text-center">
					          <ul class="pagination paginationReview"></ul>
					        </div>
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
</div>


<!-- jQuery -->
<script src="/resources/bsAdmin2/resources/vendor/jquery/jquery.min.js"></script>
<script src="/resources/bsAdmin2/resources/vendor/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
    
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

	var searchFormReview = $("#searchFormReview");
	$("#searchFormReview button").on("click", function(e){
		if(!searchFormReviewOrder.find("option:selected").val()){
			alert("검색종류를 선택하세요");
			return false;
		}

		if(!searchFormReviewOrder.find("input[name='keyword']").val()){
			alert("키워드를 입력하세요");
			return false;
		}
		searchFormReview.find("input[name='pageNum']").val("1");
		e.preventDefault();
		
		searchFormReview.submit();
		
	});	
    

	  // 상품명 클릭 또는 '보기' 버튼 클릭 시 모달 열기 & 리뷰 로드
	  $('.product-link, .review-detail-btn').on('click', function() {
	    const productName = $(this).data('productname');
	    const productId = $(this).data('productid');
	    console.log("productName:" + productName);
	    console.log("productId:" + productId);
	    // 모달 내부 상품명 표시
	    $('#modalProductName').text(productName);
	    
	    // 상품페이지 링크 URL
	    let productPageUrl = '/sub?id=' + productId;
	    
	    // 모달 내 링크 href 설정 및 텍스트 지정
	    $('#modalProductLink')
	        .attr('href', productPageUrl)
	        .text('상품페이지 바로가기');
	    
	    loadReviews(productId, 1); // 1페이지부터 로드
	    $('#reviewModal').modal('show');
	  });

	  // 리뷰 목록 및 페이징 AJAX 로드 함수
	  function loadReviews(productId, pageNum) {
		  $('#reviewModal').attr('data-currentpage', pageNum);
		  console.log("productId : " + productId); 
	    $.ajax({
	      url: '/adminreview/productreviewlist', // 서버에서 페이징 리뷰 리스트 반환하는 API 주소로 변경
	      method: 'GET',
	      dataType: 'json',
	      data: { productId: productId, pageNum: pageNum },
	      success: function(data) {	    	  
	        // 리뷰 리스트 렌더링
			console.log("랜더링:------>");
			var html = '';
				html += '<table class="table table-bordered table-hover" style="border-collapse: separate; border-spacing: 0 10px;">';
				html += '<thead style="background-color: #f8f9fa;">';
				html += '<tr>';
				html += '<th class="text-center" style="width:120px;">이미지</th>';
				html += '<th class="text-center" style="width:150px;">작성일시</th>';
				html += '<th class="text-center" style="width:120px;">작성자</th>';
				html += '<th class="text-center"> 리뷰 내용</th>';
				html += '<th class="text-center" style="width:80px;"> 조회수</th>';
				html += '<th class="text-center" style="width:80px;">평점</th>';
				html += '<th class="text-center" style="width:80px;">노출</th>';
				html += '<th class="text-center" style="width:150px;">관리</th>';
				html += '</tr>';
				html += '</thead>';
				html += '<tbody>';
			
			data.list.forEach(function(review) {
				html += '<tr style="background-color:#fff; box-shadow: 0 2px 6px rgba(0,0,0,0.05);">';
				html += '<td class="text-center">';
				html += '<img src="/upload/' + review.imageUrl + '" style="width:100px; height:100px; object-fit:cover; border-radius:8px; border:1px solid #ddd;">';
				html += '</td>';
				html += '<td class="text-center" style="vertical-align:middle;">' + formatDate(review.reviewDate) + '</td>';
				html += '<td class="text-center" style="vertical-align:middle;"><strong>' + review.customerId + '</strong></td>';
				html += '<td class="text-left" style="vertical-align:middle; white-space:pre-line;">' + review.reviewContent + '</td>';
				html += '<td class="text-center" style="vertical-align:middle;">' + review.viewCount + '</td>';
				html += '<td class="text-center" style="vertical-align:middle; font-size:16px; color:#ffc107;">★ ' + review.rating + '</td>';
			
				// 노출여부 표시
				if (review.isDeleted == 1) {
				  html += '<td class="text-center" style="vertical-align:middle;"><span class="label label-default">숨김</span></td>';
				} else {
				  html += '<td class="text-center" style="vertical-align:middle;"><span class="label label-success">노출</span></td>';
				}
			
				  html += '<td class="text-center" style="vertical-align:middle;">';
				  if (review.isDeleted == 1) {
				    // 복구 버튼
				    html += '<button class="btn btn-success restore-btn" data-reviewid="' + review.id + '">복구</button> ';
				  } else {
				    // 숨김 버튼
				    html += '<button class="btn btn-warning softdel-btn" data-reviewid="' + review.id + '">숨김</button> ';
				  }
				  // 삭제 버튼은 항상 노출
				  html += '<button class="btn btn-danger harddel-btn" data-reviewid="' + review.id + '">삭제</button>';
				  html += '</td>';
				  html += '</tr>';
				});
			
				html += '</tbody></table>';
				
				$('#reviewList').html(html);
				
				   let htmlPagination = '';
				   
				   if (data.pagination.prev) {
				       htmlPagination += '<li class="paginate_button_review">' +
				           '<a class="page-link review-page-link" ' +
				           'data-page="' + (data.pagination.startPage - 1) + '" ' +
				           'data-productid="' + productId + '" ' +
				           'href="javascript:void(0);">Previous</a>' +
				           '</li>';
				   }
				
				   for (var num = data.pagination.startPage; num <= data.pagination.endPage; num++) {
				       console.log('num:', num, 'productId:', productId);
				       var activeClass = data.pagination.cri.pageNum === num ? 'active' : '';
				       htmlPagination += '<li class="paginate_button_review ' + activeClass + '">' +
				           '<a class="page-link review-page-link" ' +
				           'data-page="' + num + '" ' +
				           'data-productid="' + productId + '" ' +
				           'href="javascript:void(0);">' + num + '</a>' +
				           '</li>';
				   }
				
				   if (data.pagination.next) {
				       htmlPagination += '<li class="paginate_button_review">' +
				           '<a class="page-link review-page-link" ' +
				           'data-page="' + (data.pagination.endPage + 1) + '" ' +
				           'data-productid="' + productId + '" ' +
				           'href="javascript:void(0);">Next</a>' +
				           '</li>';
				   }
				
				   $(".paginationReview").html(htmlPagination);
				   console.log('Generated pagination HTML:', htmlPagination);
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

		$(document).on('click', '.harddel-btn', function() {
			  var reviewId = $(this).data('reviewid');
			  var productId = $('#modalProductLink').attr('href').split('/').pop();
			  var currentPage = parseInt($('#reviewModal').attr('data-currentpage')) || 1;
			  
			  if (!confirm('삭제 후 복구할 수 없습니다. 정말 삭제하시겠습니까?')) return;

			  $.ajax({
			    url: '/adminreview/harddel',
			    method: 'POST',
			    dataType: 'json',
			    data: { id: reviewId },
			    success: function(res) {
			    	alert(res.message);
			      if(res.success) {
			        loadReviews(productId, currentPage);  // 현재 페이지 유지
			      }
			    },
			    error: function() {
			      alert('서버 오류가 발생했습니다.');
			    }
			  });
			});
		
		$(document).on('click', '.softdel-btn', function() {
			  var reviewId = $(this).data('reviewid');
			  var productId = $('#modalProductLink').attr('href').split('/').pop();
			  var currentPage = parseInt($('#reviewModal').attr('data-currentpage')) || 1;
			  
			  if (!confirm('리뷰가 노출되지 않습니다.')) return;

			  $.ajax({
			    url: '/adminreview/softdel',
			    method: 'POST',
			    dataType: 'json',
			    data: { id: reviewId },
			    success: function(res) {
			    	alert(res.message);
			      if(res.success) {
			        loadReviews(productId, currentPage);
			      }
			    },
			    error: function() {
			      alert('서버 오류가 발생했습니다.');
			    }
			  });
			});
		
		$(document).on('click', '.restore-btn', function() {
			  var reviewId = $(this).data('reviewid');
			  var productId = $('#modalProductLink').attr('href').split('/').pop();
			  var currentPage = parseInt($('#reviewModal').attr('data-currentpage')) || 1;
			  
			  if (!confirm('리뷰가 노출됩니다.')) return;

			  $.ajax({
			    url: '/adminreview/restore',
			    method: 'POST',
			    dataType: 'json',
			    data: { id: reviewId },
			    success: function(res) {
			      alert(res.message);
			      if(res.success) {
			        loadReviews(productId, currentPage);
			      }
			    },
			    error: function() {
			      alert('서버 오류가 발생했습니다.');
			    }
			  });
			});
	  
	  function formatDate(timestamp) {
		    var date = new Date(timestamp);
		    var year = date.getFullYear();
		    var month = String(date.getMonth() + 1).padStart(2, '0');
		    var day = String(date.getDate()).padStart(2, '0');
		    var hours = String(date.getHours()).padStart(2, '0');
		    var minutes = String(date.getMinutes()).padStart(2, '0');
		    return year + '-' + month + '-' + day + ' ' + hours + ':' + minutes;
		}

});
</script>

</body>

<%@include file="../includes_admin/footer.jsp"%>
<%@include file="../main/footer.jsp"%>