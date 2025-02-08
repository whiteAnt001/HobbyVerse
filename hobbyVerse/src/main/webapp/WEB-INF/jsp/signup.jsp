<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입 - HobbyVerse</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body {
            background-color: #6a11cb;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            margin: 0;
            animation: fadeIn 1s ease-out;
        }

        .container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            width: 100%;
            max-width: 1200px;
            padding: 20px;
            opacity: 0;
            animation: slideUp 1s forwards 0.5s; /* 애니메이션 추가 */
        }

        .welcome-text {
            color: white;
            max-width: 550px;
            text-align: left;
        }

        .welcome-text h1 {
            font-size: 3rem;
            font-weight: bold;
            margin-bottom: 1rem;
        }

        .welcome-text p {
            font-size: 1.2rem;
            line-height: 1.6;
        }

        .card {
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            background: white;
            width: 400px;
            opacity: 0;
            animation: slideUp 1s forwards 0.5s; /* 애니메이션 추가 */
        }

        .card-body {
            padding: 2rem;
        }

        .btn-gradient {
            background: linear-gradient(135deg, #6a11cb, #2575fc);
            border: none;
            color: white;
            padding: 10px 20px;
            border-radius: 5px;
            width: 100%;
            cursor: pointer;
        }

        .btn-gradient:hover {
            background: linear-gradient(135deg, #2575fc, #6a11cb);
        }

        .form-control {
            border-radius: 5px;
            margin-bottom: 1rem;
        }

        .footer-link {
            text-align: center;
            margin-top: 1rem;
        }

        @media (max-width: 768px) {
            .container {
                flex-direction: column;
                align-items: center;
            }

            .welcome-text {
                text-align: center;
                margin-bottom: 2rem;
            }

            .card {
                width: 100%;
            }
        }

        /* 애니메이션 정의 */
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
    <div class="container">
        <div class="welcome-text">
            <h1>취미를 함께 나누어요!</h1>
            <p>지금 회원가입하고 다양한 취미 활동을 함께 할 친구들을 만나보세요!</p>
        </div>

        <div class="card">
            <div class="card-body">
                <h3 class="text-center mb-4">회원가입</h3>
                <form action="/register" method="post">
                	<div class="form-group">
                		<label for="signup-name">이름</label>
                		<input type="text" name="name" class="form-control" placeholder="이름을 입력하세요" required>
            		</div>
                    <div class="form-group">
                        <label for="signup-email">이메일</label>
                        <input type="email" name="email" class="form-control" id="signup-email" placeholder="이메일을 입력하세요" required>
                    </div>
                    <div class="form-group">
                        <label for="signup-password">비밀번호</label>
                        <input type="password"  name="password" class="form-control" id="signup-password" placeholder="비밀번호를 입력하세요" required>
                    </div>
                    <div class="form-group">
                        <label for="signup-password-confirm">비밀번호 확인</label>
                        <input type="password"  name="passwordConfirm" class="form-control" id="signup-password-confirm" placeholder="비밀번호를 다시 입력하세요" required>
                    </div>
                    <button type="submit" class="btn-gradient">회원가입</button>
                </form>
                <div class="footer-link">
                    <p>이미 계정이 있으신가요? <a href="/login" class="text-decoration-none">로그인</a></p>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
