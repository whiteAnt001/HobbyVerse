<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="UTF-8">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>취미/스터디 매칭 플랫폼</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<!-- FontAwesome CDN 추가 -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<style>
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

.image {
	width: 100%;
	height: 100%;
	object-fit: cover; /* 이미지가 부모 영역에 맞게 커버되도록 */
	border-radius: 10px;
}

.arrow-btn {
	width: 50px;
	height: 50px;
	border-radius: 50%;
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 24px;
	background-color: white;
	border: 1px solid #ccc;
	cursor: pointer;
}

.arrow-btn:hover {
	background-color: #f8f9fa;
}

 /* 카드 - 흰색 배경, 연한 테두리와 깔끔한 그림자 */
        .card {
            width: 280px;
            border-radius: 10px;
            background-color: #ffffff;
            box-shadow: 0px 2px 8px rgba(0, 0, 0, 0.1);
            border: 1px solid #ddd;
            margin-bottom: 15px;
        }
        .card-body {
            padding: 0.8rem;
        }
        .card-title {
            font-size: 1rem;
            font-weight: bold;
            color: #333;
        }
        .card-text {
            font-size: 0.75rem;
            color: #555;
        }
        /* 카드 내 이미지 */
        .image {
            width: 100%;
            height: 100%;
            object-fit: cover;
            border-radius: 10px 10px 0 0;
        }

.d-flex {
	flex-wrap: nowrap;
	overflow-x: auto;
}

.container {
	max-width: 100%;
	padding: 0 15px;
}
</style>
</head>
<body>
	<jsp:include page="/WEB-INF/jsp/navbar.jsp" />

	<div class="container mt-5">
		<h3 class="text-center mb-4">🔍 검색 결과</h3>
		<div class="d-flex align-items-center justify-content-between">
					<!-- 왼쪽 버튼 -->
			<button class="arrow-btn me-3"
				<c:if test="${currentPage <= 1}">disabled style="opacity: 0.5;"</c:if>
				onclick="../meetup/search.html?pageNo=${currentPage - 1}&title=${title}">
				<i class="fas fa-chevron-left"></i>
			</button>

			<div class="d-flex flex-nowrap overflow-auto" style="gap: 20px;">
                    <c:forEach var="meet" items="${meetList}">
                        <div class="card shadow-sm">
                            <img src="${pageContext.request.contextPath}/upload/${meet.imagename}" alt="" class="image">
                            <div class="card-body text-center">
                                <h5 class="card-title">${meet.title}</h5>
                                <p class="card-text">일정: ${meet.m_date}</p>
                                <p class="card-text">위치: ${meet.address}</p>
                                <div class="d-flex justify-content-between">
                                    <p class="card-text">❤️ ${meet.recommend}</p>
                                    <p class="card-text">
                                        <i class="fas fa-eye"></i> ${meet.views}
                                    </p>
                                </div>
                                <a href="/meetup/detail.html?id=${meet.m_id}" class="btn btn-primary btn-sm">자세히 보기</a>
                            </div>
                        </div>
                    </c:forEach>
                </div>

			<!-- 오른쪽 버튼 -->
			<button class="arrow-btn ms-3"
				<c:if test="${currentPage >= pageCount}">disabled style="opacity: 0.5;"</c:if>
				onclick="location.href='../meetup/search.html?pageNo=${currentPage + 1}&title=${title}'">
				<i class="fas fa-chevron-right"></i>
			</button>
		</div>
	</div>
	
	
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
