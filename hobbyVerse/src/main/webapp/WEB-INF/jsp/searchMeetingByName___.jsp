<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form action="/category/search" method="post">
    <div class="container mt-4">
        <div class="row">
            <div class="col-md-8 mx-auto">
                <div class="filter-bar d-flex justify-content-between align-items-center">
                   	모임 검색<input type="text" name="NAME"/>
                   	<input type="submit" value="검색"/>
                    <select class="form-select w-auto">
                        <option>최신순</option>
                        <option>인기순</option>
                        <option>참가비 낮은순</option>
                    </select>
                </div>
            </div>
        </div>
    </div>
    </form>

	<table>
		<tr><th>모임 아이디</th><th>모임명</th><th>모임 설명</th><th>카테고리</th><th>등록일</th><th>가격</th><th>작성자</th></tr>
		<c:forEach var="key" items="${keyList }">
			<tr><td>${key.m_id }</td><td>${key.title }</td><td>${key.info }</td><td>${key.c_key }</td>
			<td>${key.w_date }</td><td>${key.price }</td><td>${key.w_id }</td></tr>
		</c:forEach>
	</table>
<c:set var="pageCount" value="${pageCount }"/>
<c:set var="currentPage" value="${ currentPage}"/>
<c:set var="startPage" 
	value="${currentPage - (currentPage % 10 == 0 ? 10 : (currentPage % 10)) + 1}"/>
<c:set var="endPage" value="${startPage + 9}"/>
<c:if test="${endPage > pageCount}">
	<c:set var="endPage" value="${pageCount}"/>
</c:if>
<c:if test="${startPage > 10}">
	<a href="#" onclick="movePage(${startPage - 1})">[이전]</a>
</c:if>
<c:forEach begin="${startPage}" end="${endPage}" var="i">
	<c:if test="${currentPage == i}"><font size="6"></c:if>
	<a href="#" onclick="movePage(${ i })">${ i }</a>
	<c:if test="${currentPage == i}"></font></c:if>
</c:forEach>
<c:if test="${endPage < pageCount}">
	<a href="#" onclick="movePage(${endPage + 1 })">[다음]</a>
</c:if>

<form method="post" name="itemfm">
	<input type="hidden" name="NAME" value="${NAME }">
	<input type="hidden" name="PAGE_NUM">
</form>
<script type="text/javascript">
function movePage(page){
	document.itemfm.PAGE_NUM.value = page;
	document.itemfm.action = "../item/search.html";
	document.itemfm.submit();
}
</script>
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>