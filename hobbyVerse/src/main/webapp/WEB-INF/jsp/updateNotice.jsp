<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공지사항 수정</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body { background-color: #f0f4f8; font-family: 'Roboto', sans-serif; }
        .container { max-width: 700px; margin-top: 40px; background-color: #ffffff; padding: 30px; border-radius: 10px; box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1); }
        h2 { font-size: 24px; color: #343a40; font-weight: 600; margin-bottom: 20px; }
        .form-label { font-weight: 500; }
        .btn { font-size: 14px; border-radius: 8px; padding: 8px 16px; }
    </style>
</head>
<body>
    <div class="container">
        <h2 class="text-center">공지사항 수정</h2>
        <form id="updateNoticeForm">
            <input type="hidden" id="noticeId" value="${notice.id}">
            
            <div class="mb-3">
                <label for="title" class="form-label">제목</label>
                <input type="text" class="form-control" id="title" value="${notice.title}" required>
            </div>

            <div class="mb-3">
                <label for="content" class="form-label">내용</label>
                <textarea class="form-control" id="content" rows="5" required>${notice.content}</textarea>
            </div>

            <div class="text-center">
                <button type="button" class="btn btn-primary" onclick="updateNotice()">수정 완료</button>
                <a href="/notices" class="btn btn-outline-secondary">취소</a>
            </div>
        </form>
    </div>

    <script>
        function updateNotice() {
            const noticeId = document.getElementById("noticeId").value;
            const title = document.getElementById("title").value;
            const content = document.getElementById("content").value;

            fetch('/notices/update/' + noticeId, {
                method: 'PUT',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ title, content })
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert("공지사항이 수정되었습니다.");
                    window.location.href = "/notices";
                } else {
                    alert("수정 실패: " + data.message);
                }
            })
            .catch(error => {
                console.error('수정 중 오류 발생:', error);
                alert("수정 중 오류 발생: " + error.message);
            });
        }
    </script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
