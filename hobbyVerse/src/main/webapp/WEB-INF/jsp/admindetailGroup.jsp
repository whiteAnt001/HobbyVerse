<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>모임 상세 | HobbyMatch</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<style>
body {
	background: #f4f4f4;
	color: #333;
	min-height: 100vh;
}

.gradient-bg {
	background: linear-gradient(135deg, #6a11cb, #2575fc);
}

.meeting-header {
	background: linear-gradient(135deg, #6a11cb, #2575fc);
	color: white;
	padding: 20px 10px;
	text-align: center;
	border-radius: 0 0 15px 15px;
}

.meeting-header h1 {
	font-size: 1.5rem;
}

.meeting-header h4 {
	font-size: 1rem;
}

.meeting-detail-card {
	background: white;
	border-radius: 8px;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
	margin-top: 20px;
}

.meeting-detail-card img {
	width: 100%;
	height: 300px;
	object-fit: cover;
	border-radius: 8px 8px 0 0;
}

.meeting-detail-card .content {
	padding: 20px;
}

.meeting-detail-card h3 {
	font-size: 1.4rem;
}

.meeting-detail-card p {
	font-size: 0.9rem;
	color: #555;
}

.participants-list {
	background: #fff;
	padding: 10px;
	margin-top: 15px;
	border-radius: 8px;
	box-shadow: 0 1px 5px rgba(0, 0, 0, 0.1);
}

.participants-list h5 {
	font-size: 1rem;
	margin-bottom: 8px;
}

.participant {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 8px;
}

.participant img {
	width: 30px;
	height: 30px;
	border-radius: 50%;
	margin-right: 8px;
}

.btn-gradient {
	background: linear-gradient(135deg, #6a11cb, #2575fc);
	color: white;
	padding: 8px 12px;
	font-size: 0.9rem;
}

.btn-sm {
	padding: 5px 8px;
	font-size: 0.8rem;
}
</style>
</head>
<body>

	<jsp:include page="/WEB-INF/jsp/navbar.jsp" />

	<div class="meeting-header">
		<h1>${meetup.title }</h1>
	</div>

	<div class="container mt-4">
		<div class="row">
			<div class="col-md-8 mx-auto">
				<div class="meeting-detail-card">
					<img
						src="${pageContext.request.contextPath}/upload/${meetup.imagename }"
						alt="">
					<div class="content">
						<h5>카테고리</h5>
						<p>
						<c:choose>
							<c:when test="${meetup.c_key == '1' }">
								<font size="3">운동</font>
							</c:when>
							<c:when test="${meetup.c_key == '2' }">
								<font size="3">음악</font>
							</c:when>
							<c:when test="${meetup.c_key == '3' }">
								<font size="3">스터디</font>
							</c:when>
							<c:when test="${meetup.c_key == '4' }">
								<font size="3">게임</font>
							</c:when>
							<c:when test="${meetup.c_key == '5' }">
								<font size="3">여행</font>
							</c:when>
							<c:otherwise>
								<font size="3">기타</font>
							</c:otherwise>
						</c:choose>
						</p>
						<!-- <p>${meetup.category_name}</p> -->
						<h5>작성자</h5>
						<p>${meetup.w_id }</p>
						<h5>모임 설명</h5>
						<p>${meetup.info }</p>
						<h5>모임 일정</h5>
						<p>📅 ${meetup.m_date }</p>
						<h5>참가비</h5>
						<p>💰 ${meetup.price }원</p>
						<h5>조회수</h5>
						<p>👁️ ${views}</p>
						<!-- 조회수 표시 추가 -->


					</div>
				</div>

				<div class="participants-list">
					<c:forEach var="wId" items="${wId }">
						<div class="participant">
							<div class="d-flex align-items-center">
								<div align="center">
									<table>
										<tr><th>방장: </th></tr>
										<tr><td>${wId }</td></tr>
									</table>
								</div>
							</div>
						</div>
					</c:forEach>
					</br>
	
					<h5>참가자 목록</h5>
					<c:forEach var="apply" items="${meetingApplies }">
						<div class="participant">
							<div class="d-flex align-items-center">
								<img src="https://randomuser.me/api/portraits/men/1.jpg"
									alt="참가자 1">
								<div align="center">
									<table>
										<tr>
											<th>신청자:</th>
											<td>${apply.id}</td>
										</tr>
										<tr>
											<th>닉네임:</th>
											<td>${apply.name }</td>
										</tr>
										<tr>
											<th>신청 날짜:</th>
											<td>${apply.apply_date}</td>
										</tr>
									</table>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
			</div>
			<div class="d-flex justify-content-center">
				<a href="/home" class="btn btn-sm btn-outline-secondary me-3">이전으로</a>

					<form action="/meetup/modify.html" class="d-flex">
						<input type="hidden" name="m_id" value="${meetup.m_id}"> <input
							type="submit" value="수정" name="BTN"
							class="btn btn-sm btn-outline-secondary me-2">
						<!-- 수정 버튼 간격 설정 -->
					</form>
					<form action="/meetup/modify.html" onsubmit="return check()">
						<input type="hidden" name="m_id" value="${meetup.m_id}"> <input
							type="submit" value="삭제" name="BTN"
							class="btn btn-sm btn-outline-secondary">
					</form>
				<script type="text/javascript">
					function check(frm) {
						if (!confirm("정말로 삭제하시겠습니까?"))
							return false;
					}
				</script>
			</div>
		</div>
	</div>
	</div>
	<br />
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	</div>
</body>
</html>
