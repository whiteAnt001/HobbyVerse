<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="UTF-8">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>취미/스터디 매칭 플랫폼</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

<style>
    /* 기본 스타일 */
    body {
        font-family: Arial, sans-serif;
    }

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
        object-fit: cover;
        border-radius: 10px;
    }

    .arrow-btn {
        width: 40px;
        height: 40px;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 20px;
        background-color: white;
        border: 1px solid #ccc;
        cursor: pointer;
    }

    .arrow-btn:hover {
        background-color: #f8f9fa;
    }

    .card {
        width: 180px;
        border-radius: 10px;
        overflow: hidden;
    }

    .card-body {
        padding: 0.8rem;
    }

    .card-title {
        font-size: 1rem;
        font-weight: bold;
    }

    .card-text {
        font-size: 0.75rem;
    }

    .d-flex {
        flex-wrap: wrap;
        gap: 10px;
    }

    .container {
        max-width: 100%;
        padding: 0 15px;
    }

    /* 섹션 스타일 */
    .section {
        margin-bottom: 40px;
    }

    .section-header {
        font-size: 1.5rem;
        font-weight: bold;
        margin-bottom: 20px;
    }

    .ad-banner {
        background-color: #f4f4f4;
        padding: 15px;
        text-align: center;
        margin-bottom: 30px;
    }
    /* 섹션 구분선 스타일 */
	.section-divider {
    	margin: 30px auto;
    	border: none;
    	border-top: 3px solid #ddd;
    	width: 80%;
	}
	/* 섹션 테두리와 그림자 효과 */
	.border {
    	border: 2px solid #ddd; /* 테두리 색상 */
    	border-radius: 10px; /* 모서리 둥글게 */
    	background-color: white; /* 배경색 */
	}

	.shadow-sm {
    	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); /* 살짝 그림자 효과 */
	}

	.p-4 {
    	padding: 20px; /* 내용과 테두리 사이 여백 */
	}

</style>
</head>
<body>

    <!-- 헤더 -->
    <jsp:include page="/WEB-INF/jsp/navbar.jsp" />

   <section class="ad-banner">
    <div class="ad-slider">
        <!-- 광고 내용 -->
        <div class="ad" id="ad1">광고 1: 특별 이벤트 1</div>
        <div class="ad" id="ad2">광고 2: 특별 이벤트 2</div>
        <div class="ad" id="ad3">광고 3: 특별 이벤트 3</div>
        <div class="ad" id="ad4">광고 4: 특별 이벤트 4</div>
    </div>
</section>

    <!-- 인기 있는 이벤트 섹션 -->
    <section class="section">
        <h3 class="section-header text-center">지금 가장 인기있는 모임 TOP8</h3>
        <div class="d-flex align-items-center justify-content-between">
            <!-- 왼쪽 버튼 -->
            <button class="arrow-btn ms-4"
                <c:if test="${currentPage <= 1}">disabled style="opacity: 0.5;"</c:if>
                onclick="location.href='../home?PAGE_NUM=${currentPage - 1}'">
                <i class="fas fa-chevron-left"></i>
            </button>

            <div class="d-flex flex-nowrap overflow-auto" style="gap: 20px;">
                <c:forEach var="meet" items="${meetList}">
                    <div class="card shadow-sm">
                        <img src="${pageContext.request.contextPath}/upload/${meet.imagename}" alt="" class="image">
                        <div class="card-body text-center">
                            <h5 class="card-title">${meet.title}</h5>
                            <p class="card-text">진행일: ${meet.m_date}</p>
                            <p class="card-text">위치: ${meet.address }</p>
                     <div class="d-flex justify-content-between">
                        <p class="card-text">❤️ ${meet.recommend}</p>
                        <p class="card-text"><i class="fas fa-eye"></i> ${meet.views}</p>
                     </div>
                     <a href="/meetup/detail.html?id=${meet.m_id}" class="btn btn-primary btn-sm">자세히 보기</a>
                        </div>
                    </div>
                </c:forEach>
            </div>

            <!-- 오른쪽 버튼 -->
           <button class="arrow-btn"
               <c:if test="${currentPage == 2}">disabled style="opacity: 0.5;"</c:if>
               onclick="location.href='../home?PAGE_NUM=2'">
               <i class="fas fa-chevron-right"></i>
           </button>
        </div>
    </section>


<!-- 최신 모임 & 인기 게시글 -->
<section class="section">
    <h3 class="section-header text-center">최신 모임 & 인기 게시글</h3>
    
    <div class="row">
        <!-- 최신 모임 -->
        <div class="col-md-6">
            <div class="p-4 border rounded shadow-sm bg-white">
                <h3 class="section-header text-center">따끈따끈한 최신 모임</h3>
                <div class="container mt-4">
                    <div class="row">
                        <c:forEach var="newMeet" items="${latestMeetList}">
                            <div class="col-md-12 mb-4">
                                <div class="meeting-card d-flex align-items-center p-3 bg-light shadow-sm rounded">
                                    <!-- 텍스트 내용 -->
                                    <div class="flex-grow-1">
                                        <h5 class="card-title">${newMeet.title}</h5>
                                        <p class="card-text">모임 일정: ${newMeet.m_date}</p>
                                        <p class="card-text">위치: ${newMeet.address}</p>
                                        <a href="/meetup/detailCategory.html?id=${newMeet.m_id}" class="btn btn-primary btn-sm">자세히보기</a>
                                    </div>

                                    <!-- 이미지 -->
                                    <div style="width: 150px; height: 150px; margin-left: 15px;">
                                        <img src="${pageContext.request.contextPath}/upload/${newMeet.imagename}" class="image rounded" />
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>

        <!-- 인기 게시판 -->
        <div class="col-md-6">
            <div class="p-4 border rounded shadow-sm bg-white">
                <h3 class="section-header text-center">인기 게시글</h3>
                <div class="container mt-4">
                    <div class="list-group">
                        <c:forEach var="post" items="${boardList}">
                            <div class="list-group-item d-flex justify-content-between align-items-center p-3 border-bottom">
                                <div>
                                    <strong><a href="/boards/${post.seq}" class="text-dark text-decoration-none">${post.subject}</a></strong>
                                    <small class="text-muted d-block">${post.regDate}</small>
                                </div>
                                <div class="text-end">
                                    <span class="text-muted ms-2"><i class="fas fa-eye"></i> ${post.readCount}</span>
                                    <span class="badge bg-primary">❤️${post.likes }</span>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

    <jsp:include page="/WEB-INF/jsp/footer.jsp" />
</body>
</html>
