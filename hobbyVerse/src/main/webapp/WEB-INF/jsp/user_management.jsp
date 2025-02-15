<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>회원 관리</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        .gradient-bg {
            background: linear-gradient(135deg, #6a11cb, #2575fc);
        }
        .table-hover tbody tr:hover {
            background-color: #f1f1f1;
        }
    </style>
</head>
<body>
    <!-- 관리자 네비게이션 바 포함 -->
    <jsp:include page="/WEB-INF/jsp/adminNavber.jsp"/>

    <div class="container mt-5">
        <h2 class="text-center">👥 회원 관리</h2>
        <table class="table table-hover mt-4">
            <thead class="table-dark">
                <tr>
                	<th>아이디</th>
                    <th>이름</th>
                    <th>이메일</th>
                    <th>가입일</th>
                    <th>권한</th>
                    <th>관리</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="user" items="${users}">
                    <tr>
                    	<td>${user.userId }</td>
                        <td>${user.name}</td>
                        <td>${user.email}</td>
                        <td>${user.regDateString}</td>
                        <td>${user.role}</td>
                        <td>
                            <a href="/api/admin/user/edit/form/${user.userId}" class="btn btn-warning btn-sm">✏ 수정</a>
                            <!-- 삭제 버튼 수정 -->
                           <a class="btn btn-danger btn-sm" title="삭제" onclick="deleteUser(${user.userId})">🗑 삭제</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
<script type="text/javascript">
    function deleteUser(userId) {
        if (confirm('정말로 이 사용자를 삭제하시겠습니까?')) {
            const url = `/api/admin/users/delete/` + userId;  // url에 userId 넣기
            console.log("Request URL:", url);  // 생성된 URL을 출력해서 확인

            fetch(url, {
                method: 'DELETE',
                headers: {
                    'Authorization': 'Bearer ' + localStorage.getItem('token'),
                    'Content-Type': 'application/json'
                }
            })
            .then(response => {
                console.log("Response status:", response.status);  // 상태 코드 로그
                if (response.ok) {
                    return response.json();
                } else {
                    throw new Error('Failed to delete user. Status code: ' + response.status);
                }
            })
            .then(data => {
                console.log("Response:", data);
                if (data.message === '유저를 성공적으로 삭제했습니다.') {
                    alert('유저를 성공적으로 삭제했습니다.');
                    window.location.href = '/api/admin/users';  // 회원 관리 페이지로 리디렉션
                } else {
                    alert('Error: ' + data.message);
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('Failed to delete user: ' + error.message);
            });
        }
    }
</script>


    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
