<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/reset.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/subQna.css">

<div class="qna-section">
	<div class="qnaWrap">
		<h3>Q&amp;A</h3>
		<p style="font-size: 13px; color: #666; margin-bottom: 30px;">상품의 궁금한 점을 해결해 드립니다.</p>

		<div class="subQnaWrap">
			<c:if test="${boardList == '[]'}">
				<div class="qnaBulletin">게시물이 없습니다</div>
			</c:if>
			<c:if test="${boardList != '[]'}">
				<div class="subQnaItem">
					<table>
						<tr>
							<th class="qnaIsAnswerd">답변여부</th>
							<th class="qnaTitle">제목</th>
							<th class="qnaWriter">작성자</th>
							<th class="qnaWriteDay">작성일</th>
						</tr>
						<c:forEach var="item" items="${boardList}">
							<tr>
								<td class="qnaIsAnswerd">
								<c:if test="${item.isAnswered == 0}"><span class="label label-default">답변대기</span></c:if>
								<c:if test="${item.isAnswered == 1}"><span class="label label-success">답변완료</span></c:if>
								</td>
								<td class="qnaTitle" style="text-align: left;"><a href="${pageContext.request.contextPath}/adminboard/get?id=${item.id}">${item.title}</a></td>
								<td class="qnaWriter">${item.customerId}</td>
								<td class="qnaWriteDay"><fmt:formatDate value="${item.writeDate}" pattern="yyyy-MM-dd" /></td>
							</tr>
						</c:forEach>
					</table>
				</div>
			</c:if>
		</div>
		<form action="adminboard/register" method="get">
			<input type="hidden" name="productid" value="${product.id}">
			<input type="submit" class="contactButton" style="cursor: pointer;" value="상품 문의하기">
		</form>
			<a href="${pageContext.request.contextPath}/adminboard/list"><div class="allqnaButton" style="cursor: pointer;">전체 보기</div></a>
	</div>
</div>
