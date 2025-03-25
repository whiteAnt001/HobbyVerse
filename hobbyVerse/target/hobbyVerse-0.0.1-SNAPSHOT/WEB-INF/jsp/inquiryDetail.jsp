<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>문의사항 상세</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        .comment-box {
            background-color: #f8f9fa;
            border-radius: 5px;
            padding: 15px;
            margin-top: 10px;
        }
        .comment-header {
            font-weight: bold;
            margin-bottom: 5px;
        }
        .comment-body {
            font-size: 14px;
        }
            /* 네비게이션 바 */
		.gradient-bg {background: linear-gradient(135deg, #6a11cb, #2575fc);} /* 배경에 그라데이션 효과 적용 */
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/jsp/navbar.jsp"/>

    <div class="container mt-5">
        <h2 class="text-center">문의사항 상세</h2>

        <div class="card">
            <div class="card-header">
                <strong>${inquiry.title}</strong>
            </div>
            <div class="card-body">
                <p><strong>번호:</strong> ${inquiry.seq}</p>
                <p><strong>작성자 이메일:</strong> ${inquiry.userEmail}</p>
                <p><strong>작성일:</strong> ${inquiry.formattedCreatedAt}</p>
                <p><strong>내용:</strong></p>
                <p>${inquiry.content}</p>
            </div>
        </div>

        <!-- 운영자 답변을 댓글처럼 표시 -->
        <c:if test="${not empty inquiry.adminReply}">
            <div class="comment-box">
                <div class="comment-header">운영자 답변</div>
                <div class="comment-body">${inquiry.adminReply}</div>
            </div>
        </c:if>

        <div class="mt-3">
            <a href="/inquiries" class="btn btn-secondary">목록으로 돌아가기</a>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
