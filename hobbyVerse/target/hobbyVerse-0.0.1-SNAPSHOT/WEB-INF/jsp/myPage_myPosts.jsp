<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>내가 쓴 게시글</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        /* 전체 배경 */
        body {
            background: #f4f4f4;
            color: #333;
            min-height: 100vh;
            font-family: 'Arial', sans-serif;
        }

        /* 컨테이너 크기 */
        .container {
            max-width: 900px;
            margin-top: 50px;
        }

        /* 타이틀 */
        h2 {
            font-size: 2rem;
            color: #2575fc;
            text-align: center;
            font-weight: bold;
            margin-bottom: 30px;
        }

        /* 게시글 카드 스타일 */
        .post-card {
            background-color: #ffffff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            display: flex;
            padding: 20px;
            margin-bottom: 20px;
            transition: transform 0.3s ease;
        }

        .post-card:hover {
            transform: translateY(-5px);
        }

        .post-card .flex-grow-1 {
            flex-grow: 1;
        }

        .post-card .card-title {
            font-size: 1.25rem;
            font-weight: bold;
            color: #333;
        }

        .post-card .card-text {
            font-size: 1rem;
            color: #777;
        }

        .post-card .btn {
            background-color: #2575fc;
            color: white;
            border: none;
            border-radius: 5px;
        }

        .post-card .btn:hover {
            background-color: #6a11cb;
        }

        /* 게시글 없을 경우 메시지 */
        .alert {
            font-size: 1.1rem;
            font-weight: bold;
            color: #fff;
            background-color: #f44336;
            text-align: center;
            padding: 10px;
        }
    </style>
</head>
<body>

    <!-- 네비게이션 바 -->
    <jsp:include page="/WEB-INF/jsp/navbar.jsp" />

    <!-- 내가 쓴 게시글 리스트 -->
    <div class="container">
        <h2>내가 쓴 게시글</h2>

        <!-- 내가 쓴 게시글이 없을 경우 처리 -->
        <c:if test="${empty myPosts}">
            <div class="alert" role="alert">작성한 게시글이 없습니다.</div>
        </c:if>

        <!-- 내가 쓴 게시글 목록 -->
        <div class="row">
            <c:forEach var="post" items="${myPosts}">
                <div class="col-md-12 mb-4">
                    <a href="/boards/${post.seq}" style="text-decoration: none;">
                        <div class="post-card">
                            <!-- 텍스트 내용 -->
                            <div class="flex-grow-1">
                                <h5 class="card-title">${post.subject}</h5>
                                <p class="card-text">작성일: ${post.regDateString}</p>
                            </div>
                        </div>
                    </a>
                </div>
            </c:forEach>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
