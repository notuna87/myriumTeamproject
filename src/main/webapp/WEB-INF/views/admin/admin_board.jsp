<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>   
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<%@include file="../main/header.jsp" %> 
<%@include file="../includes_admin/header.jsp" %> 

<body>
	<div class="row">
		<div class="col-lg-12">
			<div class="panel panel-default">
			<div id="contents" class="board-list-container">
			  <sec:authorize access="hasAuthority('ADMIN')">
			    <button id="regBtn" class="btn btn-success mb-3">공지사항 등록</button>
			  </sec:authorize>
			
			  <table class="table table-hover">
			    <thead>
			      <tr>
			        <th class="text-center">No.</th>
			        <th>제목</th>
			        <th class="text-center">작성일</th>
			        <th class="text-center">조회수</th>
			        <th class="text-center">파일</th>
			        <sec:authorize access="hasAuthority('ADMIN')">
			          <th class="text-center">관리</th>
			        </sec:authorize>
			      </tr>
			    </thead>
			    <tbody>
			      <c:choose>
			        <c:when test="${empty list}">
			          <tr><td colspan="6" class="text-center">등록된 공지사항이 없습니다.</td></tr>
			        </c:when>
			        <c:otherwise>
			          <c:forEach items="${list}" var="item">
			
			            <tr>
			              <td class="text-center">${item.id}</td>
			              <td>
			                <a href="/notice/get?id=${item.id}">
			                  ${item.title}
			                  <c:if test="${not empty item.id}"><span class="badge badge-danger ml-1">NEW</span></c:if>
			                </a>
			              </td>
			              <td class="text-center"><fmt:formatDate pattern="yyyy-MM-dd" value="${item.createdAt}"/></td>
			              <td class="text-center">${item.id}</td>
			              <td class="text-center">
			                <c:if test="${not empty item.id}">
			                  <i class="fa fa-paperclip"></i>
			                </c:if>
			              </td>
			              <sec:authorize access="hasAuthority('ADMIN')">
			                <td class="text-center">
			                  <button class="btn btn-sm btn-primary edit-btn" data-id="${item.id}">수정</button>
			                  <button class="btn btn-sm btn-danger del-btn" data-id="${item.id}">삭제</button>
			                </td>
			              </sec:authorize>
			            </tr>
			          </c:forEach>
			        </c:otherwise>
			      </c:choose>
			    </tbody>
			  </table>
			
			  <div class="pagination-wrapper">
			    <!-- pageMaker 이용한 페이지 네비게이션 -->
			    <ul class="pagination justify-content-center">
			      <c:if test="${pageMaker.prev}">
			        <li class="page-item"><a class="page-link" href="?page=${pageMaker.startPage-1}">&laquo;</a></li>
			      </c:if>
			      <c:forEach var="n" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
			        <li class="page-item ${pageMaker.cri.pageNum == n ? 'active':''}">
			          <a class="page-link" href="?page=${n}">${n}</a>
			        </li>
			      </c:forEach>
			      <c:if test="${pageMaker.next}">
			        <li class="page-item"><a class="page-link" href="?page=${pageMaker.endPage+1}">&raquo;</a></li>
			      </c:if>
			    </ul>
			  </div>
			</div>
	  	</div>
	</div>
	</div>
</body>

<%@include file="../includes_admin/footer.jsp" %>       
<%@include file="../main/footer.jsp" %>



