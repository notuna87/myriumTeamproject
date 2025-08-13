<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<jsp:useBean id="now" class="java.util.Date" />

<%@include file="../includes_admin/header.jsp"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/board_chat.css" />

<body>
<%@include file="../main/header.jsp"%>

<div style="width:1240px; margin:0 auto;">
    <div class="row">
        <div class="col-lg-12">
            <sec:authorize access="hasAuthority('ADMIN')">
                <h1 class="page-header">공지사항 보기<span class="badge">관리자</span></h1>
            </sec:authorize>
            <sec:authorize access="!hasAuthority('ADMIN')">
                <h1 class="page-header">공지사항 보기</h1>
            </sec:authorize>
        </div>
    </div>

    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <c:if test="${notice.createdAt.time + (1000*60*60*24*3) > now.time}">
                        <div>
                            <span class="badge badge-danger ml-1">NEW</span>
                            <span> 새로운 공지사항 입니다.</span>                            
                        </div>
                    </c:if>
                </div>

                <div class="panel-body">
                    <div class="form-group">
                        <label>No.</label> 
                        <input class="form-control" name='id' value="${notice.id}" readonly/>
                    </div>
                    <div class="form-group">
                        <label>제목</label>
                        <input class="form-control" name='title' value="${notice.title}" readonly/>
                    </div>
                    <div class="form-group">
                        <label>내용</label>
                        <textarea class="form-control" rows="10" name='content' readonly>${notice.content}</textarea>
                    </div>

                    <c:if test="${not empty attachFiles}">
                        <div class="form-group">
                            <label>첨부파일 다운로드</label>
                            <ul class="list-group">
                                <c:forEach items="${attachFiles}" var="file">
                                    <li class="list-group-item">
                                        <a href="/download?uuid=${file.uuid}&path=${fn:replace(file.uploadPath, '\\', '/')}&filename=${file.fileName}">
                                            ${file.fileName}
                                        </a>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                    </c:if>

                    <div class="form-group">
                        <label>작성자</label>
                        <input class="form-control" name='customerId' value="${notice.customerId}" readonly/>
                    </div>

                    <sec:authentication property="principal" var="pinfo" />
                    <sec:authorize access="isAuthenticated()">
                        <c:if test="${pinfo.username eq notice.customerId}">
                            <button type="button" class="btn btn-warning softdel-btn" data-id="${notice.id}" data-customer-id="${notice.customerId}">글내림</button>
                        </c:if>
                    </sec:authorize>

                    <sec:authorize access="hasAuthority('ADMIN')">
                        <button data-oper='modify' class="btn btn-default">수정</button>
                    </sec:authorize>

                    <button data-oper='list' class="btn btn-default btn-info" onclick="location.href='/adminnotice/list'">목록</button>

                    <form id='operForm' action="/adminnotice/modify" method='get'>
                        <input type='hidden' id="id" name='id' value='${notice.id}'>
                        <input type='hidden' name='pageNum' value='${cri.pageNum}'>
                        <input type='hidden' name='amount' value='${cri.amount}'>
                        <input type='hidden' name='type' value='${cri.type}'>
                        <input type='hidden' name='keyword' value='${cri.keyword}'>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="/resources/bsAdmin2/resources/vendor/jquery/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
    var operForm = $("#operForm");

    // 수정 버튼
    $("button[data-oper='modify']").on("click", function() {
        console.log("[공지 수정] noticeId:", $("#id").val());
        operForm.attr("action", "/adminnotice/modify").submit();
    });

    // 목록 버튼
    $("button[data-oper='list']").on("click", function() {
        console.log("[목록 이동]");
        operForm.find("#id").remove();
        operForm.attr("action", "/adminnotice/list").submit();
    });

    // 글내림 버튼
    $(document).on("click", ".softdel-btn", function() {
        const id = $(this).data("id");
        const customerId = $(this).data("customer-id");
        console.log("[글내림 시도] id:", id, "작성자:", customerId);

        if (confirm("글이 노출되지 않습니다.)) {
            $.ajax({
                type: "post",
                url: "/adminnotice/softdel",
                data: { id: id, customerId: customerId },
                success: function() {
                    console.log("[글내림 성공] id:", id);
                    window.location.href = "/adminnotice/list";
                },
                error: function() {
                    console.error("[글내림 실패] id:", id);
                    alert("글내림 실패");
                }
            });
        }
    });
});
</script>
</body>

<%@include file="../includes_admin/footer.jsp"%>
<%@include file="../main/footer.jsp"%>
