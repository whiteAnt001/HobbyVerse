<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>문의사항 수정 및 답변</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
    <!-- 관리자 네비게이션 바 포함 -->
    <jsp:include page="/WEB-INF/jsp/adminNavber.jsp"/>

    <div class="container mt-5">
        <h2 class="text-center">문의사항 답변</h2>

        <!-- 문의사항 수정 폼 -->
        <form action="/api/admin/inquiries/update/${inquiry.seq}" method="post">
            <input type="hidden" name="_method" value="PUT">
            
            <div class="mb-3">
                <label for="title" class="form-label">제목</label>
                <input type="text" class="form-control" id="title" name="title" value="${inquiry.title}" required>
            </div>

            <div class="mb-3">
                <label for="content" class="form-label">내용</label>
                <textarea class="form-control" id="content" name="content" rows="5" required>${inquiry.content}</textarea>
            </div>

            <div class="mb-3 row">
                <div class="col-md-6">
                    <label for="userEmail" class="form-label">작성자 이메일</label>
                    <input type="text" class="form-control" id="userEmail" name="userEmail" value="${inquiry.userEmail}" readonly>
                </div>
                <div class="col-md-6">
                    <label for="createdAt" class="form-label">작성일</label>
                    <input type="text" class="form-control" id="createdAt" name="createdAt" value="${inquiry.formattedCreatedAt}" readonly>
                </div>
            </div>

            <div class="text-start">
                <button type="submit" class="btn btn-primary">수정</button>
                <a href="/api/admin/inquiries" class="btn btn-secondary">취소</a>
            </div>
        </form>

        <!-- 운영자 답변 등록 -->
		<form action="/api/admin/inquiries/reply/${inquiry.id}" method="post">
		    <input type="hidden" name="_method" value="PUT">
		    
		    <div class="mb-3">
		        <label for="adminReply" class="form-label">운영자 답변</label>
		        <textarea class="form-control" id="adminReply" name="adminReply" rows="5" style="resize: none;">${inquiry.adminReply}</textarea>
		    </div>

		    <!-- ✅ 버튼을 왼쪽 정렬 -->
		    <div class="text-start">
		        <button type="submit" class="btn btn-success">답변 등록</button>
		    </div>

		</form>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
