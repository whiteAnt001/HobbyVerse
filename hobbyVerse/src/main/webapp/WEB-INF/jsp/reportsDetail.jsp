<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>    

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>신고모임 상세</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style type="text/css">
       body {background-color: #f0f4f8; font-family: 'Roboto', sans-serif;} 
       .container {max-width: 900px; margin-top: 40px; background-color: #ffffff; 
       			padding: 40px; border-radius: 10px; box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);} 
       h2 {font-size: 28px; color: #343a40; font-weight: 600; margin-bottom: 20px;} 
       .form-label {font-size: 16px; color: #495057;} 
       .form-control {font-size: 14px; border-radius: 8px; box-shadow: inset 0 2px 4px rgba(0, 0, 0, 0.1);} 
       .form-control:focus {border-color: #007bff; box-shadow: 0 0 0 0.25rem rgba(38, 143, 255, 0.25);} 
       .btn {font-size: 14px; border-radius: 8px; padding: 8px 16px;} 
       .btn-secondary, .btn-warning, .btn-danger {padding: 10px 20px;} 
       .btn-outline-secondary {border: 2px solid #6c757d; color: #6c757d; font-weight: 500;} 
       .btn-outline-secondary:hover {background-color: #f8f9fa; border-color: #5a6268;} 
       .btn-warning {background-color: #ffc107; color: #fff; border: none;} 
       .btn-danger {background-color: #dc3545; color: #fff; border: none;} 
       .gradient-bg {background: linear-gradient(135deg, #6a11cb, #2575fc);} 
       .form-group {margin-bottom: 20px;} 
       .container .mb-3 {margin-bottom: 20px;} 
       .container .form-control[readonly] {background-color: #f7f7f7;} 
       .center-buttons {display: flex; justify-content: center; gap: 15px;} 
       .form-control, .btn {transition: all 0.3s ease;} 
       .form-control:hover, .btn:hover {transform: none;} 
       .form-control-plaintext {font-size: 14px;}
    </style>
</head>

<body>

    <jsp:include page="/WEB-INF/jsp/navbar.jsp"/>
    
    <div class="container">
        <h2 class="mb-4">🚨 신고 내역 보기</h2>
        
        <!-- 모임 이름 표시 -->
        <c:forEach var="meet" items="${meetList}">
            <c:if test="${meet.m_id == report.m_id}">
                <div class="mb-3">
                    <label for="title" class="form-label">모임 이름</label>
                    <p class="form-control-plaintext"><strong>${meet.title}</strong></p>
                </div>
            </c:if>
        </c:forEach>

        <form action="/api/admin/reportsDetail?report_id=${report.report_id}" method="POST" enctype="multipart/form-data">
            <div class="mb-3">
                <label for="email" class="form-label">신고자</label>
                <p class="form-control-plaintext"><strong>${report.email}</strong></p>
            </div>

            <div class="mb-3">
                <label for="reason" class="form-label">신고 사유</label>
                <textarea id="reason" name="reason" class="form-control" rows="3" readonly="true">${report.reason}</textarea>
            </div>

            <div class="mb-3">
                <label for="report_date" class="form-label">신고 날짜</label>
                <input type="text" id="report_date" name="report_date" class="form-control" readonly="true" value="${report.report_date}"/>
            </div>

            <div class="center-buttons">
                <a href="/api/admin/reports" class="btn btn-outline-secondary">이전</a>
                <a class="btn btn-danger" onclick="reportsDelete(${report.report_id})">삭제</a>
            </div>
        </form>
    </div>
    
    <script type="text/javascript">
    function reportsDelete(report_id) {
        // 사용자에게 삭제 확인 메시지 표시
        if (confirm('정말로 이 모임을 삭제하시겠습니까?')) {
            // 확인 버튼을 클릭하면 DELETE 요청 실행
            const url = `/api/admin/reportsDelete/${report_id}`;

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
                    window.location.href = '/api/admin/reports'; 
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