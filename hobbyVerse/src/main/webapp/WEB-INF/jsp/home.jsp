<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="UTF-8">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>취미/스터디 매칭 플랫폼</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        /* 그라데이션 스타일 추가 */
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
    <!-- 네비게이션 바 -->
    <nav class="navbar navbar-expand-lg navbar-dark gradient-bg">
        <div class="container">
            <a class="navbar-brand" href="/hobbyverse">HobbyVerse</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item"><a class="nav-link" href="/hobbyverse">홈</a></li>
                    <li class="nav-item"><a class="nav-link" href="#">카테고리</a></li>
                    <li class="nav-item"><a class="nav-link" href="/login">로그인</a></li>
                    <li class="nav-item"><a class="nav-link btn gradient-btn" href="/signup">회원가입</a></li>
                </ul>
            </div>
        </div>
    </nav>

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
            <c:forEach var="meeting" items="${popularMeetings}">
                <div class="col-md-4 mb-4">
                    <div class="card">
                        <!-- 모임 이미지 URL 매핑 -->
                        <img src="${meeting.imageUrl}" class="card-img-top" alt="모임 이미지">
                        <div class="card-body">
                            <!-- 모임 제목 매핑 -->
                            <h5 class="card-title">${meeting.title}</h5>
                            <!-- 모임 날짜 매핑 -->
                            <p class="card-text">날짜: ${meeting.date}</p>
                            <!-- 모임 참가비 매핑 -->
                            <p class="card-text">참가비: ${meeting.price}원</p>
                            <!-- 모임 상세 페이지 링크 매핑 -->
                            <a href="/meeting/${meeting.id}" class="btn gradient-btn">자세히 보기</a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>