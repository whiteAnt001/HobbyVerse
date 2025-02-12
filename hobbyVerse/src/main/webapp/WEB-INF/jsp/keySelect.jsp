<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>카테고리 | HobbyMatch</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        /* 페이지 배경 */
        body {
            background: linear-gradient(135deg, #6a11cb, #2575fc);
            color: white;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        /* 네비게이션 바 */
        .gradient-bg {
            background: linear-gradient(135deg, #6a11cb, #2575fc);
        }

        /* 카테고리 제목 스타일 */
        .category-title {
            text-align: center;
            margin-top: 30px;
            font-size: 2rem;
            font-weight: bold;
            animation: fadeIn 1s ease-in-out;
        }

        /* 카테고리 카드 */
        .category-card {
            background: white;
            color: black;
            border-radius: 10px;
            padding: 20px;
            text-align: center;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
            transition: transform 0.3s ease-in-out, box-shadow 0.3s ease-in-out;
        }

        .category-card:hover {
            transform: scale(1.05);
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.3);
        }

        .category-card img {
            width: 80px;
            height: 80px;
            margin-bottom: 15px;
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

        /* 반응형 디자인 */
        @media (max-width: 768px) {
            .category-title {
                font-size: 1.8rem;
            }
        }
    </style>
</head>
<body>

    <!-- 네비게이션 바 포함 -->
    <jsp:include page="/WEB-INF/jsp/navbar.jsp"/>

    <!-- 카테고리 목록 -->
    <div class="container mt-5">
        <h2 class="category-title">🎨 다양한 취미 & 스터디 카테고리</h2>
        <div class="row mt-4">

            <!-- 카테고리 예시 -->
            <div class="col-md-4 mb-4">
 				<a href="/category/moveSport" style="text-decoration: none;">
                <div class="category-card"> 
                    <img src="https://cdn-icons-png.flaticon.com/512/1946/1946429.png" alt="스포츠">
                    <h5>🏀 스포츠</h5>
                    <p>농구, 축구, 테니스 등 다양한 운동 모임을 찾아보세요.</p>
                </div>
                </a>
            </div>

            <div class="col-md-4 mb-4">
            	<a href="/category/moveMusic" style="text-decoration: none;">
                <div class="category-card">
                    <img src="https://cdn-icons-png.flaticon.com/512/3081/3081897.png" alt="음악">
                    <h5>🎵 음악</h5>
                    <p>밴드, 노래, 악기 연습 등 음악을 즐길 수 있는 모임!</p>
                </div>
                </a>
            </div>

            <div class="col-md-4 mb-4">
                <div class="category-card">
                <a href="/category/moveStudy" style="text-decoration: none;">
                    <img src="https://cdn-icons-png.flaticon.com/512/1055/1055646.png" alt="스터디">
                    <h5>📚 스터디</h5>
                    <p>어학, 코딩, 자격증 등 함께 공부하는 모임을 찾아보세요.</p>
                </div>
            	</a>
            </div>

            <div class="col-md-4 mb-4">
            <a href="/category/moveGame" style="text-decoration: none;">
                <div class="category-card">
                    <img src="https://cdn-icons-png.flaticon.com/512/1170/1170678.png" alt="게임">
                    <h5>🎮 게임</h5>
                    <p>보드게임, 온라인 게임 등 취향 맞는 친구들과 즐기세요.</p>
                </div>
            	</a>
            </div>

            <div class="col-md-4 mb-4">
            <a href="/category/moveTravel" style="text-decoration: none;">
                <div class="category-card">
                    <img src="https://cdn-icons-png.flaticon.com/512/619/619153.png" alt="여행">
                    <h5>✈️ 여행</h5>
                    <p>국내 & 해외 여행을 함께 계획하고 떠나요!</p>
                </div>
            	</a>
            </div>
            
            <div class="col-md-4 mb-4">
            <a href="/category/moveEtc" style="text-decoration: none;">
                <div class="category-card">
                    <img src="https://cdn-icons-png.flaticon.com/512/2333/2333014.png" alt="요리">
                    <h5>🍳 기타</h5>
                    <p>새로운 모임들이 있어요</p>
                </div>
            	</a>
            </div>

        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>