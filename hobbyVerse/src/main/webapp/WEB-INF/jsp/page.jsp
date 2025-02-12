<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div align="center">
	<c:set var="pageCount" value="${pageCount}" />
	<c:set var="currentPage" value="${currentPage}" />
	<c:set var="startPage"
		value="${currentPage - (currentPage % 10 == 0 ? 10 : (currentPage % 10)) + 1}" />
	<c:set var="endPage" value="${startPage + 9}" />
	<c:if test="${endPage > pageCount}">
		<c:set var="endPage" value="${pageCount}" />
	</c:if>

	<c:if test="${startPage > 10}">
		<a href="/category/moveSport?pageNo=${startPage - 1}">[이전]</a>
	</c:if>

	<c:forEach begin="${startPage }" end="${endPage}" var="i">
		<c:if test="${currentPage == i}">
			<font size="6">
		</c:if>
		<a href="/category/moveSport?pageNo=${i}">${i}</a>
		<c:if test="${currentPage == i}">
			</font>
		</c:if>
	</c:forEach>

	<c:if test="${endPage < pageCount}">
		<a href="/category/moveSport?pageNo=${endPage + 1}">[다음]</a>
	</c:if>
	</div>
</body>
</html>