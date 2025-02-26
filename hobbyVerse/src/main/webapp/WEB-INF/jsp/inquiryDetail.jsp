<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>문의사항 상세</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        .container {
            max-width: 800px;
            margin-top: 50px;
        }
        .card {
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        .btn-back {
            margin-top: 20px;
        }
    </style>
</head>
<body>

    <div class="container">
        <h2 class="text-center mb-4">문의사항 상세</h2>
        
        <div class="card">
            <div class="card-header">
                <h4>${inquiry.title}</h4>
            </div>
            <div class="card-body">
                <p><strong>번호:</strong> ${inquiry.seq}</p>
                <p><strong>작성자 이메일:</strong> ${inquiry.userEmail}</p>  <!-- ✅ 이메일 그대로 표시 -->
                <p><strong>작성일:</strong> ${formattedCreatedAt}</p>  <!-- ✅ 보기 좋게 변환 -->
                <hr>
                <p><strong>내용:</strong></p>
                <p>${inquiry.content}</p>
            </div>
        </div>

        <a href="/inquiries" class="btn btn-secondary btn-back">목록으로 돌아가기</a>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
