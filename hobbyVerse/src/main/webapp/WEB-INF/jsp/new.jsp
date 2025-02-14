<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="UTF-8">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>새 게시글 작성</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">

    <!-- ✅ 네비게이션 바 글씨 색상 오류 해결 -->
    <style>
        .navbar-nav .nav-link {
            color: white !important;  /* ✅ 글씨를 흰색으로 강제 설정 */
        }
        .gradient-bg {
            background: linear-gradient(135deg, #6a11cb, #2575fc); /* ✅ 기존과 동일한 네비게이션 스타일 */
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
    <!-- ✅ 홈 페이지와 동일한 네비게이션 바 적용 -->
    <jsp:include page="/WEB-INF/jsp/navbar.jsp"/>

    <div class="container mt-5">
        <h2 class="text-center mb-4">새 게시글 작성</h2>
        <form action="/boards/create" method="post">
            <div class="mb-3">
                <label for="subject" class="form-label">제목</label>
                <input type="text" class="form-control" id="subject" name="subject" required>
            </div>
            <div class="mb-3">
                <label for="content" class="form-label">내용</label>
                <textarea class="form-control" id="content" name="content" rows="5" required></textarea>
            </div>
            <div class="mb-3">
                <label for="name" class="form-label">작성자</label>
                <!-- ✅ 로그인한 유저의 이름 자동 입력 -->
                <input type="text" class="form-control" id="name" name="name" value="${user.name}" readonly>
            </div>
            <button type="submit" class="btn gradient-btn">게시글 저장</button>
        </form>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
