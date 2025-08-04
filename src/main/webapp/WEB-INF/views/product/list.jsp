<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
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
			<h1 class="page-header">상품관리(관리자)</h1>
		</div>
	</div>
	<!-- /.row -->
	<div class="row">
		<div class="col-lg-12">
			<div class="panel panel-default">
				<sec:authorize access="hasAuthority('ADMIN')">
					<div class="panel-heading">
						새상품은 상품등록을 클릭하고 등록하세요.
						<button id='regBtn' type="button" class="btn btn-info">작성</button>
					</div>
					<div class="panel-heading">
						<span class="badge badge-danger ml-1">NEW</span> 최근 3일 이내에 등록된 새로운 상품 입니다.
					</div> 
				</sec:authorize>

				<!-- /.panel-heading -->
				<div class="panel-body">
					    <!-- 필터링 섹션 -->
				    <form action="/product/list" method="get" class="form-inline" style="margin-bottom:10px;">
				        <!-- <select name="category" class="form-control">
				            <option value="">카테고리</option>
				            <c:forEach var="cat" items="${categories}">
				                <option value="${cat}" <c:if test="${param.category == cat}">selected</c:if>>${cat}</option>
				            </c:forEach>
				        </select> -->
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
				        <button type="button" class="btn btn-default" onclick="location.href='/product/list'">필터 초기화</button>

				    </form>
				
				    <!-- 상품 테이블 -->
				    <table class="table table-bordered table-hover">
				        <thead>
				            <tr>
				                <th class="text-center">상품번호</th>
				                <th class="text-center">카테고리</th>
				                <th class="text-center">이미지</th>
				                <th class="text-center">상품명</th>
				                <th class="text-center">재고량</th>
				                <th class="text-center">가격</th>
				                <th class="text-center">할인가격</th>
				                <th class="text-center">일반할인</th>
				                <th class="text-center">(일반)할인율</th>
				                <th class="text-center">타임세일</th>
				                <th class="text-center">(타임세일)할인율</th>
				                <th class="text-center">노출</th>
				                <th class="text-center">관리</th>
				            </tr>
				        </thead>
				        <tbody>
				            <c:forEach items="${list}" var="product">
				                <tr>
				                    <td class="text-center">${product.product.id}</td>
									<td class="text-center">
									    <div class="d-flex flex-wrap justify-content-center">
									        <c:forEach var="tag" items="${product.category.categoryTags}">
									            <span class="label label-default category-label">${tag}</span>
									        </c:forEach>
									    </div>
									</td>
					            	<!-- 썸네일 -->
						            <td class="text-center">
						            	<img src="${pageContext.request.contextPath}/upload/${product.thumbnail.img_path_thumb}" style="width: 60px; height: 60px; object-fit: cover; border-radius: 4px;">
						            </td>
									
				                    <td class="text-left"><a class="move" href="${product.product.id}">${product.product.product_name}</a>
   					                    <!-- NEW 라벨: 3일 이내 등록 -->
					                    <c:if test="${notice.createdAt.time + (1000*60*60*24*3) > now.time}">
					                        <span class="badge badge-danger ml-1">NEW</span>
					                    </c:if>
					                </td>
				                    <td class="text-right">${product.product.product_stock}</td>
				                    <td class="text-right"><fmt:formatNumber value="${product.product.product_price}" pattern="#.##"/></td>
				                    <td class="text-right"><fmt:formatNumber value="${product.product.discount_price}" pattern="#.##"/></td>
				                    <td class="text-center">${product.product.is_discount ==1 ? '할인중' : '없음'}</td>
				                    <td class="text-right">${product.product.discount_rate}%</td>
				                    <td class="text-center">${product.product.is_timesales == 1 ? '할인중' : '없음'}</td>
				                    <td class="text-right">${product.product.timesalediscount_rate}%</td>
				                    <td class="text-center">${product.product.is_deleted == 0 ? '전시중' : '비노출'}</td>
				                    <td>
				                        <button class="btn btn-sm btn-primary" onclick="location.href='/product/modify?id=${product.product.id}'">수정</button>
				                        <c:choose>
				                            <c:when test="${product.product.is_deleted == 0}">
				                                <button class="btn btn-sm btn-warning toggle-visibility" data-id="${product.product.id}" data-display="false">비노출</button>
				                            </c:when>
				                            <c:otherwise>
				                                <button class="btn btn-sm btn-success toggle-visibility" data-id="${product.product.id}" data-display="true">전시복구</button>
				                            </c:otherwise>
				                        </c:choose>
				                        <button class="btn btn-sm btn-danger delete-product" data-id="${product.product.id}">삭제</button>
				                    </td>
				                </tr>
				            </c:forEach>
				        </tbody>
				    </table>


					<!-- 검색조건 -->
					<div class='row'>
						<div class="col-lg-12">
							<form id='searchForm' action="/product/list" method='get'>
								<select name='type'>
									<option value="" <c:out value="${pageMaker.cri.type == null?'selected':''}"/>>선택하세요</option>
									<option value="T" <c:out value="${pageMaker.cri.type eq 'T'?'selected':''}"/>>제목</option>
									<option value="C" <c:out value="${pageMaker.cri.type eq 'C'?'selected':''}"/>>내용</option>
									<option value="W" <c:out value="${pageMaker.cri.type eq 'W'?'selected':''}"/>>작성자</option>
									<option value="TC" <c:out value="${pageMaker.cri.type eq 'TC'?'selected':''}"/>>제목
										or 내용</option>
									<option value="TW" <c:out value="${pageMaker.cri.type eq 'TW'?'selected':''}"/>>제목
										or 작성자</option>
									<option value="TWC" <c:out value="${pageMaker.cri.type eq 'TWC'?'selected':''}"/>>제목
										or 내용 or 작성자</option>
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

					<form id='actionForm' action="/product/list" method='get'>
						<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum}'> <input
							type='hidden' name='amount' value='${pageMaker.cri.amount}'> <input type='hidden'
							name='type' value='${pageMaker.cri.type}'> <input type='hidden' name='keyword'
							value='${pageMaker.cri.keyword}'>
					</form>


					<!-- The Modal -->
					<div class="modal" id="myModal">
						<div class="modal-dialog">
							<div class="modal-content">

								<!-- Modal Header -->
								<div class="modal-header">
									<h4 class="modal-title">Modal Heading</h4>
									<button type="button" class="close" data-dismiss="modal">&times;</button>
								</div>

								<!-- Modal body -->
								<div class="modal-body">처리가 완료되었습니다.</div>

								<!-- Modal footer -->
								<div class="modal-footer">
									<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
								</div>

							</div>
						</div>
						<!-- End Modal -->
					</div>
				</div>
			</div>
		</div>
	</div>

<!-- jQuery -->
<script src="/resources/bsAdmin2/resources/vendor/jquery/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
    var result = '${result}'; 	
    
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
				$(".modal-body").html("게시글 " + parseInt(result) + "번이 등록되었습니다.");
			}
			$("#myModal").modal("show");
		}
	}
	
	$("#regBtn").on("click",function(){
		self.location = "/product/register";
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
		actionForm.attr("action","/product/get");
		actionForm.submit();
	});
	
	var searchForm = $("#searchForm");

	$("#searchForm button").on("click", function(e){
		if(!searchForm.find("option:selected").val()){
			alert("검색종류를 선택하세요");
			return false;
		}

		if(!searchForm.find("input[name='keyword']").val()){
			alert("키워드를 입력하세요");
			return false;
		}
		searchForm.find("input[name='pageNum']").val("1");
		e.preventDefault();
		
		searchForm.submit();
		
	});
    
	// 관리자용 버튼 이벤트
	$(document).on("click", ".edit-btn", function () {
	    const id = $(this).data("id");
	    window.location.href = "/product/modify?id=" + id;
	});

	$(document).on("click", ".harddel-btn", function () {
	    const id = $(this).data("id");
	    if (confirm("삭제 후 복구할 수 없습니다. 정말 삭제하시겠습니까?")) {
	        $.ajax({
	            type: "post",
	            url: "/product/harddel",
	            data: { id: id },
	            success: function () {
	                location.reload();
	            },
	            error: function () {
	                alert("삭제 실패");
	            }
	        });
	    }
	});
	
	$(document).on("click", ".softdel-btn", function () {
	    const id = $(this).data("id");
	    if (confirm("글이 노출되지 않습니다. 정말 하시겠습니까?")) {
	        $.ajax({
	            type: "post",
	            url: "/product/softdel",
	            data: { id: id },
	            success: function () {
	                location.reload();
	            },
	            error: function () {
	                alert("글내림 실패");
	            }
	        });
	    }
	});

	$(document).on("click", ".restore-btn", function () {
	    const id = $(this).data("id");
	    if (confirm("복구하시겠습니까?")) {
	        $.ajax({
	            type: "post",
	            url: "/product/restore",
	            data: { id: id },
	            success: function () {
	                location.reload();
	            },
	            error: function () {
	                alert("복구 실패");
	            }
	        });
	    }
	});
    
});
</script>

</body>

<%@include file="../includes_admin/footer.jsp"%>
<%@include file="../main/footer.jsp"%>