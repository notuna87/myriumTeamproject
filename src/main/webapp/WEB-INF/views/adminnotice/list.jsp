<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<jsp:useBean id="now" class="java.util.Date" />

<%@include file="../includes_admin/header.jsp"%>

<script>
    // 뒤로가기 시 새로고침
    window.onpageshow = function(event) {
        if (event.persisted || window.performance.navigation.type === 2) {
            location.reload();
            console.log("[페이지 새로고침] 뒤로가기 또는 캐시 복원 시");
        }
    };
</script>

<style type="text/css">
   table.table td, table.table th {
      vertical-align: middle !important;
      text-align: center;
   }
   table.table {
      font-size: 13px;
   }
</style>

<body>
<%@include file="../main/header.jsp"%>

<div style="width:1240px; margin:0 auto;">
    <div class="row">
        <div class="col-lg-12">
            <sec:authorize access="hasAuthority('ADMIN')">
                <h1 class="page-header">공지사항<span class="badge">관리자</span></h1>
            </sec:authorize>
            <sec:authorize access="!hasAuthority('ADMIN')">
                <h1 class="page-header">공지사항</h1>
            </sec:authorize>
        </div>
    </div>

    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
                <sec:authorize access="hasAuthority('ADMIN')">
                    <div class="panel-heading">
                        공지사항을 작성하려면 작성 버튼을 클릭하세요.
                        <button id='regBtn' type="button" class="btn btn-info">작성</button>
                    </div>
                    <div class="panel-heading">
                        <span class="badge badge-danger ml-1">NEW</span> 최근 3일 이내의 새로운 공지사항
                    </div>
                </sec:authorize>

                <div class="panel-body">
                    <table width="100%" class="table table-striped table-bordered table-hover" id="dataTables-example">
                        <thead>
                            <tr>
                                <th class="text-center">번호</th>
                                <th class="text-center">제목</th>
                                <th class="text-center">작성자</th>
                                <th class="text-center">작성일</th>
                                <th class="text-center">조회</th>
                                <th class="text-center">첨부파일</th>
                                <sec:authorize access="hasAuthority('ADMIN')">
                                    <th class="text-center">상태</th>
                                    <th class="text-center">관리</th>
                                </sec:authorize>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${empty list}">
                                    <tr>
                                        <td colspan="7" class="text-center">등록된 공지사항이 없습니다.</td>
                                    </tr>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach items="${list}" var="notice">
                                        <tr class="odd gradeX">
                                            <td class="text-center">${notice.id}</td>
                                            <td>
                                                <a class="move" href="${notice.id}">${notice.title}</a>
                                                <c:if test="${notice.createdAt.time + (1000*60*60*24*3) > now.time}">
                                                    <span class="badge badge-danger ml-1">NEW</span>
                                                </c:if>
                                            </td>
                                            <td class="text-center">${notice.customerId}</td>
                                            <td class="text-center"><fmt:formatDate pattern="yyyy-MM-dd" value="${notice.createdAt}" /></td>
                                            <td class="text-center">${notice.readCnt}</td>
                                            <td class="text-center">
                                                <c:choose>
                                                    <c:when test="${notice != null and notice.hasFiles > 0}">
                                                        <i class="fa fa-paperclip" title="첨부파일 있음"></i>
                                                    </c:when>
                                                    <c:otherwise>-</c:otherwise>
                                                </c:choose>
                                            </td>
                                            <sec:authorize access="hasAuthority('ADMIN')">
                                                <td class="text-center">
                                                    <c:choose>
                                                        <c:when test="${notice.isDeleted == 1}">
                                                            <span class="label label-default">미노출</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="label label-success">게시중</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td class="text-center">
                                                    <button type="button" class="btn btn-sm btn-primary edit-btn" data-id="${notice.id}">수정</button>
                                                    <c:choose>
                                                        <c:when test="${notice.isDeleted == 0}">
                                                            <button type="button" class="btn btn-sm btn-warning softdel-btn" data-id="${notice.id}">글내림</button>
                                                            <button type="button" class="btn btn-sm btn-danger harddel-btn" data-id="${notice.id}">영구삭제</button>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <button type="button" class="btn btn-sm btn-success restore-btn" data-id="${notice.id}">복구</button>
                                                            <button type="button" class="btn btn-sm btn-danger harddel-btn" data-id="${notice.id}">영구삭제</button>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                            </sec:authorize>
                                        </tr>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>

                    <!-- 검색폼 -->
                    <div class='row'>
                        <div class="col-lg-12">
                            <form id='searchForm' action="/adminnotice/list" method='get'>
                                <select name='type'>
                                    <option value="" <c:out value="${pageMaker.cri.type == null?'selected':''}"/> >선택하세요</option>
                                    <option value="T" <c:out value="${pageMaker.cri.type eq 'T'?'selected':''}"/> >제목</option>
                                    <option value="C" <c:out value="${pageMaker.cri.type eq 'C'?'selected':''}"/> >내용</option>
                                    <option value="W" <c:out value="${pageMaker.cri.type eq 'W'?'selected':''}"/> >작성자</option>
                                    <option value="TC" <c:out value="${pageMaker.cri.type eq 'TC'?'selected':''}"/> >제목 or 내용</option>
                                    <option value="TW" <c:out value="${pageMaker.cri.type eq 'TW'?'selected':''}"/> >제목 or 작성자</option>
                                    <option value="TWC" <c:out value="${pageMaker.cri.type eq 'TWC'?'selected':''}"/> >제목 or 내용 or 작성자</option>
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

                    <!-- 페이지네이션 -->
                    <div class="pull-right">
                        <ul class="pagination">
                            <c:if test="${pageMaker.prev}">
                                <li class="paginate_button"><a class="page-link" href="${pageMaker.startPage-1}">Previous</a></li>
                            </c:if>
                            <c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
                                <li class="paginate_button ${pageMaker.cri.pageNum == num ? 'active': ''}">
                                    <a href="${num}">${num}</a>
                                </li>
                            </c:forEach>
                            <c:if test="${pageMaker.next}">
                                <li class="paginate_button"><a href="${pageMaker.endPage+1}">Next</a></li>
                            </c:if>
                        </ul>
                    </div>

                    <form id='actionForm' action="/adminnotice/list" method='get'>
                        <input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum}'>
                        <input type='hidden' name='amount' value='${pageMaker.cri.amount}'>
                        <input type='hidden' name='type' value='${pageMaker.cri.type}'>
                        <input type='hidden' name='keyword' value='${pageMaker.cri.keyword}'>
                    </form>

                    <!-- 모달 -->
                    <div class="modal" id="myModal">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h4 class="modal-title">알림</h4>
                                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                                </div>
                                <div class="modal-body">처리가 완료되었습니다.</div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
                                </div>
                            </div>
                        </div>
                    </div>

                </div> <!-- panel-body -->
            </div>
        </div>
    </div>
</div>

<script src="/resources/bsAdmin2/resources/vendor/jquery/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
    var result = '${result}';
    history.replaceState({}, null, null); // 뒤로가기 후 모달 제거

    if(result !== '' && !history.state){
        if(parseInt(result) > 0){
            $(".modal-body").html("게시글 " + parseInt(result) + "번이 등록되었습니다.");
            console.log("[모달] 게시글 등록 완료:", result);
        }
        $("#myModal").modal("show");
    }

    $("#regBtn").on("click", function(){
        console.log("[버튼] 공지사항 작성 클릭");
        self.location = "/adminnotice/register";
    });

    var actionForm = $("#actionForm");

    $(".paginate_button a").on("click", function(e){
        e.preventDefault();
        console.log("[페이지 이동] 클릭 href:", $(this).attr("href"));

        actionForm.find("input[name='id']").remove();
        actionForm.find("input[name='pageNum']").val($(this).attr("href"));
        actionForm.submit();
    });

    $(".move").on("click", function(e){
        e.preventDefault();
        console.log("[공지 상세 이동] id:", $(this).attr("href"));

        actionForm.find("input[name='id']").remove();
        actionForm.append("<input type='hidden' name='id' value='" + $(this).attr("href") + "'>");
        actionForm.attr("action","/adminnotice/get");
        actionForm.submit();
    });

    $("#searchForm button").on("click", function(e){
        if(!$("#searchForm select[name='type']").val()){
            alert("검색종류를 선택하세요");
            return false;
        }
        if(!$("#searchForm input[name='keyword']").val()){
            alert("키워드를 입력하세요");
            return false;
        }
        $("#searchForm input[name='pageNum']").val("1");
        console.log("[검색] 타입:", $("#searchForm select[name='type']").val(), "키워드:", $("#searchForm input[name='keyword']").val());
        e.preventDefault();
        $("#searchForm").submit();
    });

    // 관리자 버튼 이벤트
    $(document).on("click", ".edit-btn", function(){
        const id = $(this).data("id");
        console.log("[수정] id:", id);
        window.location.href = "/adminnotice/modify?id=" + id;
    });

    $(document).on("click", ".harddel-btn", function(){
        const id = $(this).data("id");
        console.log("[영구삭제] id:", id);
        if(confirm("삭제 후 복구할 수 없습니다.")){
            $.post("/adminnotice/harddel", { id: id })
                .done(() => location.reload())
                .fail(() => alert("삭제 실패"));
        }
    });

    $(document).on("click", ".softdel-btn", function(){
        const id = $(this).data("id");
        console.log("[글내림] id:", id);
        if(confirm("글이 노출되지 않습니다.")){
            $.post("/adminnotice/softdel", { id: id })
                .done(() => location.reload())
                .fail(() => alert("글내림 실패"));
        }
    });

    $(document).on("click", ".restore-btn", function(){
        const id = $(this).data("id");
        console.log("[복구] id:", id);
        if(confirm("복구하시겠습니까?")){
            $.post("/adminnotice/restore", { id: id })
                .done(() => location.reload())
                .fail(() => alert("복구 실패"));
        }
    });
});
</script>

</body>

<%@include file="../includes_admin/footer.jsp"%>
<%@include file="../main/footer.jsp"%>
