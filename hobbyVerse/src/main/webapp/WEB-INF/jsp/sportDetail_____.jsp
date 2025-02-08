<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>모임 상세 | HobbyMatch</title>
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
        .meeting-header {
            background: linear-gradient(135deg, #6a11cb, #2575fc);
            color: white;
            padding: 40px 20px;
            text-align: center;
            border-radius: 0 0 20px 20px;
        }

        /* 모임 상세 카드 */
        .meeting-detail-card {
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            margin-top: 30px;
        }

        .meeting-detail-card img {
            width: 100%;
            height: 400px;
            object-fit: cover;
            border-radius: 10px 10px 0 0;
        }

        .meeting-detail-card .content {
            padding: 30px;
        }

        .meeting-detail-card h3 {
            font-size: 1.8rem;
            font-weight: bold;
        }

        .meeting-detail-card p {
            font-size: 1rem;
            color: #555;
        }

        .participants-list {
            background: #fff;
            padding: 15px;
            margin-top: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        .participants-list h5 {
            font-size: 1.2rem;
            margin-bottom: 10px;
        }

        .participant {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 10px;
        }

        .participant img {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            margin-right: 10px;
        }

        /* 버튼 스타일 */
        .btn-gradient {
            background: linear-gradient(135deg, #6a11cb, #2575fc);
            color: white;
        }
    </style>
</head>
<body>

    <!-- 네비게이션 바 -->
    <nav class="navbar navbar-expand-lg navbar-dark gradient-bg">
        <div class="container">
            <a class="navbar-brand" href="index.html">HobbyMatch</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item"><a class="nav-link" href="/hobbyverse">홈</a></li>
                    <li class="nav-item"><a class="nav-link" href="/category">카테고리</a></li>
                    <li class="nav-item"><a class="nav-link" href="#">로그인</a></li>
                    <li class="nav-item"><a class="nav-link btn gradient-btn" href="#">회원가입</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- 모임 상세 헤더 -->
    <div class="meeting-header">
        <h1>🏀 주말 농구 모임</h1>
        <p>2025년 2월 10일에 열리는 농구 모임에 참여해보세요!</p>
    </div>

    <!-- 모임 상세 내용 -->
    <div class="container mt-5">
        <div class="row">
            <div class="col-md-8 mx-auto">
                <!-- 모임 상세 카드 -->
                <div class="meeting-detail-card">
                    <img src="https://source.unsplash.com/800x600/?basketball" alt="모임 이미지">
                    <div class="content">
                        <h3>모임 설명</h3>
                        <p>이 모임은 주말마다 농구를 좋아하는 사람들과 함께 농구를 즐기기 위한 모임입니다. 초보자부터 고수까지 모두 환영합니다. 이번 주에는 팀을 나누어 농구 경기를 진행할 예정입니다.</p>

                        <h3>모임 일정</h3>
                        <p>📅 2025-02-10 (토) 오후 2시<br>📍 서울시 강남구 농구장</p>

                        <h3>참가비</h3>
                        <p>💰 10,000원 (모임 진행비 포함)</p>

                        <button class="btn btn-gradient w-100">참가 신청</button>
                    </div>
                </div>

                <!-- 참가자 목록 -->
                <div class="participants-list">
                    <h5>참가자 목록 (3명)</h5>
                    <div class="participant">
                        <div class="d-flex align-items-center">
                            <img src="https://randomuser.me/api/portraits/men/1.jpg" alt="참가자 1">
                            <p>홍길동</p>
                        </div>
                        <button class="btn btn-sm btn-outline-secondary">삭제</button>
                    </div>
                    <div class="participant">
                        <div class="d-flex align-items-center">
                            <img src="https://randomuser.me/api/portraits/women/1.jpg" alt="참가자 2">
                            <p>김미영</p>
                        </div>
                        <button class="btn btn-sm btn-outline-secondary">삭제</button>
                    </div>
                    <div class="participant">
                        <div class="d-flex align-items-center">
                            <img src="https://randomuser.me/api/portraits/men/2.jpg" alt="참가자 3">
                            <p>이재호</p>
                        </div>
                        <button class="btn btn-sm btn-outline-secondary">삭제</button>
                    </div>
                </div>

            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>