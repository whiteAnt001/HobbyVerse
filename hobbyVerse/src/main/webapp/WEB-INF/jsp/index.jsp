<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>  

<!DOCTYPE html>
<html lang="UTF-8">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>취미/스터디 매칭 플랫폼</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        /* 그라데이션 스타일 */
        .gradient-bg {
            background: linear-gradient(135deg, #6a11cb, #2575fc);
        }
        .gradient-btn {
            background: linear-gradient(135deg, #6a11cb, #2575fc);
            border: none;
            color: white;
        }
        .gradient-btn:hover {
            background: linear-gradient(135deg, #2575fc, #6a11cb);
        }
    </style>
</head>
<body>
    <!-- 네비게이션 바 포함 -->
    <jsp:include page="/WEB-INF/jsp/navbar.jsp"/>

    <!-- 검색 및 필터 -->
    <div class="container mt-4">
        <div class="row">
            <div class="col-md-8 mx-auto">
                <div class="input-group">
                    <input type="text" class="form-control" placeholder="관심 있는 모임을 검색하세요...">
                    <button class="btn gradient-btn">검색</button>
                </div>
            </div>
        </div>
    </div>

    <!-- 인기 모임 목록 -->
    <div class="container mt-5">
        <h3 class="text-center mb-4">🔥 인기 모임</h3>
        <div class="row">
            <!-- EL 표현식과 매핑 부분 -->
            <c:forEach var="meet" items="${meetList}">
			    <form method="post" action="/meetup/index.html" class="col-md-4 mb-4">
			        <div class="card shadow-sm">
			            <c:if test="${meet.imagename}">
						    <img src="<c:url value='${pageContext.request.contextPath}/upload/${meet.imagename}'/>" class="card-img-top" alt="모임 이미지">
						</c:if>

			            <div class="card-body">
			                <h5 class="card-title">${meet.title}</h5>
			                <p class="card-text">날짜: ${meet.w_date}</p>
			                <!-- 일반 버튼으로 수정 -->
			                <a href="/meetup/detail.html?id=${meet.m_id }" class="btn btn-primary">자세히 보기</a>
			            </div>
			        </div>
			    </form>
			</c:forEach>
        </div>
	</div>
	<c:set var="startPage" value="${currentPage - (currentPage - 1) % 10}" />
	<c:set var="endPage" value="${startPage + 9}" />
	<c:set var="endPage" value="${endPage > pageCount ? pageCount : endPage}" />
	
	<div align="center">
	    <c:if test="${startPage > 1}">
	        <a href="../meetup/index.html?PAGE_NUM=${startPage - 1}">[이전]</a>
	    </c:if>
	    <c:forEach begin="${startPage}" end="${endPage}" var="i">
	        <a href="../meetup/index.html?PAGE_NUM=${i}" class="${currentPage == i ? 'active-page' : ''}">
	            ${i}
	        </a>
	    </c:forEach>
	    <c:if test="${endPage < pageCount}">
	        <a href="../meetup/index.html?PAGE_NUM=${endPage + 1}">[다음]</a>
	    </c:if>
	</div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
