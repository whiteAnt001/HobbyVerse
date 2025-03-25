<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>문의사항 작성</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        .container {
            max-width: 600px;
            margin-top: 50px;
        }
        /* 네비게이션 바 */
        .gradient-bg {
            background: linear-gradient(135deg, #6a11cb, #2575fc);
        }
        .container-lg {
			max-width: 900px; /* container-lg의 최대 너비를 더 넓게 설정 */
			margin-top: 50px;
		}

        /* 전체 레이아웃 조정 */
        body {
            background-color: #f8f9fa; /* 배경색 변경 */
            font-family: Arial, sans-serif; /* 폰트 변경 */
        } 
    </style>
</head>
<body>
    <!-- 네비게이션 바 포함 -->
    <jsp:include page="/WEB-INF/jsp/navbar.jsp"/>

    <div class="container">
        <h2 class="text-center mb-4">문의사항 작성</h2>

        <form action="/inquiries/create" method="post">
            <div class="mb-3">
                <label for="title" class="form-label">제목</label>
                <input type="text" class="form-control" id="title" name="title" required>
            </div>

            <div class="mb-3">
                <label for="content" class="form-label">내용</label>
                <textarea class="form-control" id="content" name="content" rows="5" required></textarea>
            </div>

            <div class="mb-3">
                <label for="userEmail" class="form-label">작성자 이메일</label>
                <input type="email" class="form-control" id="userEmail" name="userEmail" value="${user.email}" readonly>
            </div>

            <div class="d-flex justify-content-between">
                <a href="/inquiries" class="btn btn-secondary">목록으로</a>
                <button type="submit" class="gradient-btn">등록</button>
            </div>
        </form>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
