<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>공지사항 상세</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        .gradient-bg {background: linear-gradient(135deg, #6a11cb, #2575fc);} /* 배경에 그라데이션 효과 적용 */
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/jsp/navbar.jsp"/>

    <div class="container mt-5">
        <h2 class="text-center">공지사항 상세</h2>

        <div class="card">
            <div class="card-header">
                <strong>${notice.title}</strong>
            </div>
            <div class="card-body">
                <p><strong>작성자:</strong> ${notice.user.name}</p>
                <p><strong>작성일:</strong> ${notice.regDateString}</p>
                <p><strong>내용:</strong></p>
                <p>${notice.content}</p>
            </div>
        </div>

        <div class="mt-3">
            <a href="/notices" class="btn btn-secondary">목록으로 돌아가기</a>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
