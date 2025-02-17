<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="UTF-8">
<head>
    <title>비밀번호 변경</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <style>
/* 전체 배경 */
body {
	background: #f4f4f4;
	color: #333;
	min-height: 100vh;
}

/* 마이페이지 크기 키우기 */
.container-lg {
	max-width: 900px; /* container-lg의 최대 너비를 더 넓게 설정 */
	margin-top: 50px;
}

/* 카드 마진 */
.card {
	margin-bottom: 20px;
}

/* 네비게이션 바 */
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

        .password-wrapper {
            position: relative;
        }

        .form-control {
            padding-right: 35px; /* 아이콘 공간 확보 */
        }

        .eye-icon {
            position: absolute;
            right: 10px;
            top: 75%;
            transform: translateY(-50%);
            cursor: pointer;
        }
    </style>
</head>
<body>

    <jsp:include page="/WEB-INF/jsp/navbar.jsp" />

    <div class="container mt-5">
        <h2>비밀번호 변경</h2>
        <form id="changePasswordForm">
            <div class="mb-3 password-wrapper">
                <label for="currentPassword" class="form-label">현재 비밀번호</label>
                <input type="password" class="form-control" id="currentPassword" name="currentPassword" required>
                <i class="fa-solid fa-eye eye-icon" onclick="togglePasswordVisibility('currentPassword', this)"></i>
            </div>
            <div class="mb-3 password-wrapper">
                <label for="newPassword" class="form-label">새 비밀번호</label>
                <input type="password" class="form-control" id="newPassword" name="newPassword" required>
                <i class="fa-solid fa-eye eye-icon" onclick="togglePasswordVisibility('newPassword', this)"></i>
            </div>
            <div class="mb-3 password-wrapper">
                <label for="confirmPassword" class="form-label">새 비밀번호 확인</label>
                <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
                <i class="fa-solid fa-eye eye-icon" onclick="togglePasswordVisibility('confirmPassword', this)"></i>
            </div>
            <button type="submit" class="btn gradient-btn">비밀번호 변경</button>
        </form>
    </div>

    <script>
        function togglePasswordVisibility(inputId, icon) {
            const input = document.getElementById(inputId);
            if (input.type === "password") {
                input.type = "text";
                icon.classList.remove("fa-eye");
                icon.classList.add("fa-eye-slash");
            } else {
                input.type = "password";
                icon.classList.remove("fa-eye-slash");
                icon.classList.add("fa-eye");
            }
        }

        // 비밀번호 변경 요청 처리
        document.getElementById("changePasswordForm").addEventListener("submit", function(event) {
            event.preventDefault();  // 폼의 기본 제출 동작을 막음

            const formData = new FormData(this);  // 폼 데이터를 FormData 객체로 추출

            fetch("/api/myPage/changePassword", {
                method: "POST",
                body: formData
            })
            .then(response => response.json())
            .then(data => {
                if (data.message) {
                    alert(data.message);  // 응답 메시지를 alert로 띄움
                    window.location.href = '/myPage';
                }
            })
            .catch(error => {
                console.error("Error:", error);
                alert("비밀번호 변경 중 오류가 발생했습니다.");
            });
        });
    </script>

</body>
</html>
