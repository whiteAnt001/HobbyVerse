<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>회원 관리</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<style>
/* 전체 배경 */
body {
	background: white;
	color: #333;
	min-height: 100vh;
}

/* 네비게이션 바 */
.gradient-bg {
	background: linear-gradient(135deg, #6a11cb, #2575fc);
}

/* 헤더 영역 */
.category-header {
	background: linear-gradient(135deg, #6a11cb, #2575fc);
	color: white;
	padding: 40px 20px;
	text-align: center;
	border-radius: 0 0 20px 20px;
	animation: fadeIn 1s ease-in-out;
}

.meeting-card {
	background: white;
	border-radius: 10px;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
	transition: transform 0.3s ease-in-out;
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 10px;
	height: 200px; /* 고정된 높이 */
}

.meeting-card:hover {
	transform: scale(1.05);
}

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

/* 이미지 스타일 */
.meeting-card img {
	object-fit: contain; /* 이미지가 부모 div에 맞게 크기 조정, 잘리지 않음 */
	width: 100%; /* 부모 div 너비에 맞게 확장 */
	height: 100%; /* 부모 div 높이에 맞게 확장 */
	border-radius: 10px; /* 카드의 모서리에 맞게 이미지 둥글게 처리 */
}

.filter-bar {
	background: white;
	padding: 10px;
	border-radius: 10px;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
}

.image {
	margin-left: -10px;
}

/* 애니메이션 효과 */
keyframes fadeIn {from { opacity:0;
	transform: translateY(-20px);
}

to {
	opacity: 1;
	transform: translateY(0);
}
}
</style>
</head>
<body>
	<!-- 관리자 네비게이션 바 포함 -->
	<jsp:include page="/WEB-INF/jsp/adminNavber.jsp" />

	<div class="container mt-5">
		<h2 class="text-center">👥 회원 관리</h2>


		<div class="container mt-4">
			<div class="row">
				<div class="col-md-8 mx-auto">
					<form action="/api/admin/searchUser" method="post"
						class="input-group">
						<input type="text" class="form-control" name="SEARCH"
							value="${SEARCH }" placeholder="이메일/ 이름을 입력하세요..." />
						<button type="submit" class="btn gradient-btn">검색</button>
					</form>
				</div>
			</div>
		</div>



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
				<c:forEach var="user" items="${userList}">
					<tr>
						<td>${user.userId }</td>
						<td>${user.name}</td>
						<td>${user.email}</td>
						<td>${user.regDateString}</td>
						<td>${user.role}</td>
						<td><a href="/api/admin/user/edit/form/${user.userId}"
							class="btn btn-warning btn-sm">✏ 수정</a> <!-- 삭제 버튼 수정 --> <a
							class="btn btn-danger btn-sm" title="삭제"
							onclick="deleteUser(${user.userId})">🗑 삭제</a></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<!-- 페이지처리 -->
	<c:set var="startPage" value="${currentPage - (currentPage - 1) % 10}" />
	<c:set var="endPage" value="${startPage + 9}" />
	<c:set var="endPage"
		value="${endPage > pageCount ? pageCount : endPage}" />
	<div align="center">
		<c:if test="${startPage > 1}">
			<a href="/api/admin/searchUser?pageNo=${startPage - 1}">[이전]</a>
		</c:if>
		<c:forEach begin="${startPage}" end="${endPage}" var="i">
			<a href="/api/admin/searchUser?pageNo=${i}&SEARCH=${SEARCH}"
				class="${currentPage == i ? 'active-page' : ''}"> ${i} </a>
		</c:forEach>
		<c:if test="${endPage < pageCount}">
			<a href="/api/admin/searchUser?pageNo=${endPage + 1}">[다음]</a>
		</c:if>
	</div>

	<script type="text/javascript">
    function deleteUser(userId) {
        if (confirm('정말로 이 사용자를 삭제하시겠습니까?')) {
            const url = `/api/admin/users/delete/` + userId;  // url에 userId 넣기
            fetch(url, {
                method: 'DELETE',
                headers: {
                    'Authorization': 'Bearer ' + localStorage.getItem('token'),
                    'Content-Type': 'application/json'
                }
            })
            .then(response => {
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


	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
