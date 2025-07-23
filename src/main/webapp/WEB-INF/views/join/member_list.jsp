<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head><title>회원 목록</title></head>
<body>
<h2>회원 목록</h2>
<table border="1">
    <thead>
        <tr>
            <th>ID</th><th>이름</th><th>이메일</th><th>성별</th><th>상세보기</th>
        </tr>
    </thead>
    <tbody>
    <c:forEach var="member" items="${members}">
        <tr>
            <td>${member.id}</td>
            <td>${member.customerName}</td>
            <td>${member.email}</td>
            <td>${member.gender}</td>
            <td><a href="read?id=${member.id}">보기</a></td>
        </tr>
    </c:forEach>
    </tbody>
</table>
</body>
</html>
