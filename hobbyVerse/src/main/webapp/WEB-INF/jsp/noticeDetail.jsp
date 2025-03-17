<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공지사항 상세</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body {background-color: #f0f4f8; font-family: 'Roboto', sans-serif;}
        .container {max-width: 900px; margin-top: 40px; background-color: #ffffff;
                    padding: 40px; border-radius: 10px; box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);}
        h2 {font-size: 28px; color: #343a40; font-weight: 600; margin-bottom: 20px;}
        .card {border: none;}
        .card-header {
            font-size: 20px; font-weight: bold; 
            background-color: #007bff; /* 단색 배경 (Bootstrap Primary Blue) */
            color: white; text-align: center;
        }
        .card-body {position: relative;}
        .table {width: 100%; border-collapse: collapse;}
        .table th, .table td {padding: 12px; border-bottom: 1px solid #dee2e6;}
        .table th {background-color: #f8f9fa; text-align: left;}
        .view-count {position: absolute; bottom: 10px; right: 15px; font-size: 14px; color: #6c757d;}
        .button-container {display: flex; justify-content: center; gap: 15px; margin-top: 20px;}
        .btn {font-size: 14px; border-radius: 8px; padding: 8px 16px;}
        .btn-outline-secondary {border: 2px solid #6c757d; color: #6c757d; font-weight: 500;}
        .btn-outline-secondary:hover {background-color: #f8f9fa; border-color: #5a6268;}
        .btn-warning, .btn-danger {color: white;}
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/jsp/navbar.jsp"/>
    
    <div class="container">
        <h2 class="text-center">공지사항 상세</h2>
        <input type="hidden" id="noticeId" value="${notice.id}">

        <div class="card">
            <div class="card-header">
                ${notice.title}
            </div>
            <div class="card-body">
                <table class="table">
                    <tr>
                        <th>작성자</th>
                        <td>${notice.user.name}</td>
                    </tr>
                    <tr>
                        <th>작성일</th>
                        <td>${notice.regDateString}</td>
                    </tr>
                    <tr>
                        <th>내용</th>
                        <td>${notice.content}</td>
                    </tr>
                </table>
                <span class="view-count"><strong>조회수:</strong> ${noticeView.view}</span>
            </div>
        </div>

        <div class="button-container">
            <a href="/notices" class="btn btn-outline-secondary">목록으로 돌아가기</a>
            <sec:authorize access="hasRole('ADMIN')">
                <button type="button" class="btn btn-warning" onclick="location.href='/notices/updateForm/${notice.id}'">수정</button>
                <button type="button" class="btn btn-danger" onclick="deleteNotice()">삭제</button>
            </sec:authorize>
        </div>
    </div>

    <script type="text/javascript">
        const noticeId = document.getElementById("noticeId").value;
        
        function deleteNotice() {
            if (!confirm("정말 삭제하시겠습니까?")) return;

            fetch('/notices/delete/' + noticeId, {
                method: 'DELETE',
                headers: { 'Content-Type': 'application/json' }
            })
            .then(response => {
                if (response.ok) {
                    alert("공지사항이 삭제되었습니다.");
                    window.location.href = "/notices";
                } else {
                    response.text().then(text => alert("삭제 실패: " + text));
                }
            })
            .catch(error => {
                console.error('삭제 중 오류 발생:', error);
                alert("삭제 중 오류 발생: " + error.message);
            });
        }
    </script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
