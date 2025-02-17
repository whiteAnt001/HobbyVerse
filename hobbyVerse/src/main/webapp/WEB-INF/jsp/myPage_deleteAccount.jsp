<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원 탈퇴</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
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

</style>
</head>
<body>
    <jsp:include page="/WEB-INF/jsp/navbar.jsp" />

    <div class="container mt-5" align="center">
        <h2 class="text-center mb-4">회원 탈퇴</h2>
        <p><font color="red">회원 탈퇴를 진행하면 모든 데이터가 삭제됩니다. 정말로 탈퇴하시겠습니까?</font></p>
        <button type="button" class="btn btn-danger" onclick="deleteAccount()">회원 탈퇴</button>
    </div>

    <script>
        function deleteAccount() {
            if (confirm("정말 회원을 탈퇴하시겠습니까?")) {
                fetch('/api/myPage/deleteAccount', {
                    method: 'DELETE',
                    credentials: 'include'
                })
                .then(response => response.json())
                .then(data => {
                    if (data.message === '유저를 성공적으로 삭제했습니다.') {
                        alert('회원 탈퇴가 완료되었습니다.');
                        window.location.href = '/home';
                    } else {
                        alert('탈퇴 실패: ' + data.message);
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('탈퇴 중 오류가 발생했습니다.');
                });
            }
        }
    </script>
</body>
</html>
