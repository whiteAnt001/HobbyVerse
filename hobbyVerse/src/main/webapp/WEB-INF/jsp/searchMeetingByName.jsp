<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>카테고리 상세 | HobbyMatch</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        /* 전체 배경 */
        body {
            background: #f4f4f4;
            color: #333;
            min-height: 100vh;
        }

        /* 네비게이션 바 */
        .gradient-bg {
            background: linear-gradient(135deg, #6a11cb, #2575fc);
        }

        /* 헤더 영역 */
        .category-header {
            background: linear-gradient(135deg, #6a11cb, #2575fc);
            color: white;
            padding: 40px 20px;
            text-align: center;
            border-radius: 0 0 20px 20px;
            animation: fadeIn 1s ease-in-out;
        }

        /* 모임 카드 */
        .meeting-card {
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease-in-out;
        }

        .meeting-card:hover {
            transform: scale(1.05);
        }

        .meeting-card img {
            width: 100%;
            height: 200px;
            object-fit: cover;
            border-radius: 10px 10px 0 0;
        }

        /* 필터 & 정렬 바 */
        .filter-bar {
            background: white;
            padding: 10px;
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        /* 애니메이션 효과 */
        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
    </style>
</head>
<body>

    <!-- 네비게이션 바 포함 -->
    <jsp:include page="/WEB-INF/jsp/navbar.jsp"/>

    <!-- 카테고리 헤더 -->
    <div class="category-header">
        <h1>🏀 스포츠 모임</h1>
        <p>다양한 스포츠를 즐기고 함께 운동할 사람들을 찾아보세요!</p>
    </div>

    <!-- 필터 & 정렬 -->
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

    <!-- 모임 목록 -->
    <div class="container mt-4">
        <div class="row">
            <!-- 모임 카드 (반복) -->
            <div class="col-md-4 mb-4">
                <div class="meeting-card">
                    <img src="https://source.unsplash.com/400x300/?basketball" alt="모임 이미지">
                    <div class="p-3">
                        <h5 class="mb-2">🏀 주말 농구 모임</h5>
                        <p>📅 2025-02-10 | 💰 10,000원</p>
                        <a href="/meet" class="btn btn-primary w-100">자세히 보기</a>
                    </div>
                </div>
            </div>

<div align="center">
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
	<c:if test="${currentPage == i}"><font size="5"></c:if>
	<a href="#" onclick="movePage(${ i })">${ i }</a>
	<c:if test="${currentPage == i}"></font></c:if>
</c:forEach>
<c:if test="${endPage < pageCount}">
	<a href="#" onclick="movePage(${endPage + 1 })">[다음]</a>
</c:if>


<script type="text/javascript">
function movePage(page){
	document.itemfm.PAGE_NUM.value = page;
	document.itemfm.action = "../item/search.html";
	document.itemfm.submit();
}
</script>
</div>


        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>