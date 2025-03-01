<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="UTF-8">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입 완료</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body {
            background-color: #6a11cb;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            margin: 0;
            text-align: center;
            animation: fadeIn 1s ease-out;
        }

        .card {
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            background: white;
            width: 400px;
            padding: 2rem;
            opacity: 0;
            animation: slideUp 1s forwards 0.5s;
        }

        .btn-gradient {
            background: linear-gradient(135deg, #6a11cb, #2575fc);
            border: none;
            color: white;
            padding: 10px 15px;
            border-radius: 5px;
            width: 100%;
            cursor: pointer;
            font-size: 1.2rem;
        }

        .btn-gradient:hover {
            background: linear-gradient(135deg, #2575fc, #6a11cb);
        }

        @keyframes slideUp {
            from {
                transform: translateY(50px);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
            }
            to {
                opacity: 1;
            }
        }
    </style>
</head>
<body>
    <div class="card">
        <h2>🎉 회원가입 완료!</h2>
        <p>HobbyVerse에 가입해 주셔서 감사합니다.</p>
        <p>이제 로그인하여 새로운 취미 활동을 즐겨보세요!</p>
        <a href="/login" class="btn-gradient">로그인 페이지로 이동</a>
    </div>
</body>
</html>