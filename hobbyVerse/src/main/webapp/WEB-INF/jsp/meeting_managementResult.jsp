<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>모임 관리</title>
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
		<h2 class="text-center">📅 모임 관리</h2>


		<div class="container mt-4">
			<div class="row">
				<div class="col-md-8 mx-auto">
					<form action="/api/admin/searchMeet" method="post"
						class="input-group">
						<input type="text" class="form-control" name="TITLE"
							value="${TITLE }" placeholder="모임 이름을 입력하세요..." />
						<button type="submit" class="btn gradient-btn">검색</button>
					</form>
				</div>
			</div>
		</div>


		<table class="table table-hover mt-4">
			<thead class="table-dark">
				<tr>
					<th>ID</th>
					<th>모임 이름</th>
					<th>주최자</th>
					<th>날짜</th>
					<th>관리</th>
					<th>유저 관리</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="meeting" items="${meetList}">
					<tr>
						<td>${meeting.m_id}</td>
						<td>${meeting.title}</td>
						<td>${meeting.w_id}</td>
						<td>${meeting.m_date}</td>
						<td><a href="/api/admin/meeting/edit/form/${meeting.m_id }"
							class="btn btn-warning btn-sm">✏ 수정</a> <a
							class="btn btn-danger btn-sm"
							onclick="deleteMeeting(${meeting.m_id})">🗑 삭제</a></td>
						<td><a href="/api/admin/showUserList?m_id=${meeting.m_id }"
							style="text-decoration: none;">가입자 보기</a></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<div align="center">
		<c:set var="pageCount" value="${pageCount}" />
		<c:set var="currentPage" value="${currentPage}" />

		<c:set var="startPage"
			value="${currentPage - (currentPage % 10 == 0 ? 10 : (currentPage % 10)) + 1}" />
		<c:set var="endPage" value="${startPage + 9}" />
		<c:if test="${endPage > pageCount}">
			<c:set var="endPage" value="${pageCount}" />
		</c:if>

		<c:if test="${startPage > 1}">
			<a href="/api/admin/searchMeet?pageNo=${startPage - 1}">[이전]</a>
		</c:if>

		<c:forEach begin="${startPage }" end="${endPage}" var="i">
			<c:if test="${currentPage == i}">
				<font size="6">
			</c:if>
			<a href="/api/admin/searchMeet?pageNo=${i}&TITLE=${TITLE}">${i}</a>
			<c:if test="${currentPage == i}">
				</font>
			</c:if>
		</c:forEach>

		<c:if test="${endPage < pageCount}">
			<a href="/api/admin/searchMeet?pageNo=${endPage + 1}">[다음]</a>
		</c:if>
	</div>
	<br />
	<script type="text/javascript">
    function deleteMeeting(meetingId) {
        // 사용자에게 삭제 확인 메시지 표시
        if (confirm('정말로 이 모임을 삭제하시겠습니까?')) {
            // 확인 버튼을 클릭하면 DELETE 요청 실행
            const url = `/api/admin/meeting/delete/` + meetingId;  // URL에 meetingId 넣기

            fetch(url, {
                method: 'DELETE',  // DELETE 메서드로 요청
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
                if (data.message === '모임을 성공적으로 삭제했습니다.') {
                    alert('모임을 성공적으로 삭제했습니다.');
                    window.location.href = '/api/admin/meetings';  // 모임 관리 페이지로 리디렉션
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
