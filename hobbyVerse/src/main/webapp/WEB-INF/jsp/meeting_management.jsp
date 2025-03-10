<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>모임 관리</title>
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
        <h2 class="text-center">📅 모임 관리</h2>
        
        <form action="/api/admin/searchMeet" method="post">
        	<div class="container mt-4">
			<div class="row">
				<div class="col-md-8 mx-auto">
					<div
						class="filter-bar d-flex justify-content-between align-items-center">
						검색 <input type="text" name="TITLE"/>
							<input type="submit" value="검색"/>
					</div>
				</div>
			</div>
			</div>
        </form>
        
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
                        <td>
                            <a href="/api/admin/meeting/edit/form/${meeting.m_id }" class="btn btn-warning btn-sm">✏ 수정</a>
                            <a class="btn btn-danger btn-sm" onclick="deleteMeeting(${meeting.m_id})">🗑 삭제</a>
                        </td>
                        <td>
                        	<a href="/api/admin/showUserList?m_id=${meeting.m_id }" style="text-decoration: none;">가입자 보기</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
    <c:set var="startPage" value="${currentPage - (currentPage - 1) % 10}" />
    <c:set var="endPage" value="${startPage + 9}" />
    <c:set var="endPage" value="${endPage > pageCount ? pageCount : endPage}" />
    
    <div align="center">
        <c:if test="${startPage > 1}">
            <a href="/api/admin/meetings?PAGE_NUM=${startPage - 1}">[이전]</a>
        </c:if>
        <c:forEach begin="${startPage}" end="${endPage}" var="i">
            <a href="/api/admin/meetings?PAGE_NUM=${i}" class="${currentPage == i ? 'active-page' : ''}">
                ${i}
            </a>
        </c:forEach>
        <c:if test="${endPage < pageCount}">
            <a href="/api/admin/meetings?PAGE_NUM=${endPage + 1}">[다음]</a>
        </c:if>
    </div>
    <br/>
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

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
