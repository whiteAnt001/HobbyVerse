<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>유저 수정</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-5">
        <h2>👥 유저 수정</h2>
        <form id="updateUserForm">
            <input type="hidden" id="userId" value="${user.userId}">
            
            <div class="mb-3">
                <label for="name" class="form-label">이름</label>
                <input type="text" class="form-control" id="name" value="${user.name}">
            </div>
            <div class="mb-3">
                <label for="password" class="form-label">비밀번호 (변경 시 입력)</label>
                <input type="password" class="form-control" id="password">
            </div>
            <div class="mb-3">
                <label for="role" class="form-label">권한</label>
                <select class="form-select" id="role">
                    <option value="USER" ${user.role == 'ROLE_USER' ? 'selected' : ''}>ROLE_USER</option>
                    <option value="ADMIN" ${user.role == 'ROLE_ADMIN' ? 'selected' : ''}>ROLE_ADMIN</option>
                </select>
            </div>
            <div class="d-flex gap-2">
                <button type="submit" class="btn btn-primary">수정하기</button>
				<button type="button" class="btn btn-secondary" onclick="cancelEdit()">취소</button>
            </div>
        </form>
    </div>
    </div>

      <script type="text/javascript">
        document.getElementById("updateUserForm").addEventListener("submit", function(e) {
            e.preventDefault();

            const userId = document.getElementById("userId").value;
            const name = document.getElementById("name").value.trim();  // 이름 공백 제거
            const password = document.getElementById("password").value;
            const role = document.getElementById("role").value;

            // 이름이 빈 값일 경우, 경고 메시지 띄우고 종료
            if (name === "") {
                alert("이름을 입력해주세요.");
                return;
            }

            // 수정 버튼 클릭 시에만 중복 체크
            fetch(`/api/admin/user/nameCheck?name=` + encodeURIComponent(name))
                .then(response => response.json())
                .then(data => {
                    if (data.message === "이미 존재하는 이름입니다.") {
                        alert("중복된 이름입니다.");
                    } else {
                        // 중복되지 않으면 수정 요청
                        const dataToSend = { name, role };
                        if (password) { // 비밀번호 변경 시 추가
                            dataToSend.password = password;
                        }

                        fetch(`/api/admin/user/edit/` + userId, {
                            method: 'PUT',
                            headers: {
                                'Authorization': 'Bearer ' + localStorage.getItem('token'),
                                'Content-Type': 'application/json'
                            },
                            body: JSON.stringify(dataToSend)
                        })
                        .then(response => response.json())
                        .then(data => {
                            alert(data.message);
                            window.location.href = '/api/admin/users';  // 유저 관리 페이지로 이동
                        })
                        .catch(error => {
                            console.error('Error:', error);
                            alert('유저 수정에 실패했습니다.');
                        });
                    }
                })
                .catch(error => console.error("Error:", error));
        });
        
        // 취소 버튼 클릭 시 유저 관리 페이지로 리다이렉트
        function cancelEdit() {
            window.location.href = '/api/admin/users';  // 유저 관리 페이지로 이동
        }
    </script>
</body>
</html>
