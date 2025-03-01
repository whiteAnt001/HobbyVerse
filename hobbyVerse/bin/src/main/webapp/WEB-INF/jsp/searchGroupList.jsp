<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="UTF-8">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>취미/스터디 매칭 플랫폼</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <!-- FontAwesome CDN 추가 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        .gradient-bg { background: linear-gradient(135deg, #6a11cb, #2575fc); }
        .gradient-btn { background: linear-gradient(135deg, #6a11cb, #2575fc); border: none; color: white; }
        .gradient-btn:hover { background: linear-gradient(135deg, #2575fc, #6a11cb); }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/jsp/navbar.jsp"/>

    <div class="container mt-4">
        <div class="row">
            <div class="col-md-8 mx-auto">
                <form action="/meetup/search.html" method="post">
                    <div class="input-group">
                        <input type="text" name="title" class="form-control" placeholder="관심 있는 모임을 검색하세요..." value="${title}">
                        <button class="btn gradient-btn">검색</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <div class="container mt-5">
    <h3 class="text-center mb-4">🔍 검색 결과</h3>
    <c:choose>
        <c:when test="${empty meetList}">
            <p class="text-center text-muted">검색 결과가 존재하지 않습니다.</p>
        </c:when>
        <c:otherwise>
            <div class="row">
                <c:forEach var="meet" items="${meetList}">
                    <div class="col-md-4 mb-4">
                        <div class="card shadow-sm">
                            <div class="card-body">
                                <h5 class="card-title">${meet.title}</h5>
                                <p class="card-text">날짜: ${meet.m_date}</p>
                                <p class="card-text" style="font-size: 13px;">👍${meet.recommend }</p>
                                <a href="/meetup/detail.html?id=${meet.m_id}" class="btn btn-primary">자세히 보기</a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>
</div>
<div align="center">
    <!-- 페이지네이션 계산 -->
    <c:set var="pageCount" value="${pageCount}" />
    <c:set var="currentPage" value="${currentPage}" />
    
    <!-- 페이지 범위 계산: 페이지당 6개씩 표시 -->
    <c:set var="totalPages" value="${(pageCount / 6) + (pageCount % 6 > 0 ? 1 : 0)}" />

    <!-- 페이지네이션 표시 -->
</div>
<div align="center">
 <!-- 페이지네이션 계산 -->
    <c:set var="pageCount" value="${pageCount}" />
    <c:set var="currentPage" value="${currentPage}" />

    <c:set var="startPage" value="${currentPage - (currentPage % 10 == 0 ? 10 : (currentPage % 10)) + 1}" />
    <c:set var="endPage" value="${startPage + 9}" />
	<c:if test="${endPage > pageCount}">
		<c:set var="endPage" value="${pageCount}"/>
	</c:if>
    <!-- 페이지네이션 표시 -->
        <!-- 이전 페이지 링크 -->
        <c:if test="${startPage > 1}">
            <a href="javascript:movePage(${startPage - 1})">[이전]</a>
        </c:if>

        <!-- 페이지 링크 -->
        <c:forEach begin="${startPage}" end="${endPage}" var="i">
            <c:if test="${i <= pageCount}">
                <a href="javascript:movePage(${i})" class="${currentPage == i ? 'active-page' : ''}">
                    ${i}
                </a>
            </c:if>
        </c:forEach>

        <!-- 다음 페이지 링크 -->
        <c:if test="${endPage < pageCount}">
            <a href="javascript:movePage(${endPage + 1})">[다음]</a>
        </c:if>
    <!-- 폼과 JavaScript 추가 -->
    <form method="post" name="meetfrm">
        <input type="hidden" name="title" value="${title}">
        <input type="hidden" name="pageNo">
    </form>

    <script type="text/javascript">
        function movePage(page) {
            document.meetfrm.pageNo.value = page;
            document.meetfrm.action = "../meetup/search.html"; 
            document.meetfrm.submit();
        }
    </script>
 </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
