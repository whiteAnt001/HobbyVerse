<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="UTF-8">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${board.subject}</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-5">
        <h1>${board.subject}</h1>
        
        <p><strong>작성자:</strong> ${board.name}</p>
        <p><strong>작성일:</strong> ${formattedRegDate}</p>
        <hr>

        <!-- ✅ 수정 가능한 폼 -->
        <c:if test="${not empty user and user.name == board.name}">
            <form action="/boards/${board.seq}/update" method="post">
                <div class="mb-3">
                    <label class="form-label"><strong>제목:</strong></label>
                    <input type="text" class="form-control" name="subject" value="${board.subject}" required>
                </div>

                <div class="mb-3">
                    <label class="form-label"><strong>내용:</strong></label>
                    <textarea class="form-control" name="content" rows="5" required>${board.content}</textarea>
                </div>

                <!-- ✅ 버튼 구성 (취소 버튼 제거, 목록 버튼 이동) -->
				<a href="/boards" class="btn btn-secondary">목록으로</a>
                <button type="submit" class="btn btn-primary">수정 완료</button>
                

                <form action="/boards/${board.seq}/delete" method="post" style="display: inline;">
                    <button type="submit" class="btn btn-danger" onclick="return confirm('정말 삭제하시겠습니까?');">삭제</button>
                </form>
            </form>
        </c:if>

        <!-- ✅ 수정 불가능한 경우 내용만 표시 -->
        <c:if test="${empty user or user.name != board.name}">
            <p>${board.content}</p>
            <a href="/boards" class="btn btn-secondary">목록으로</a>
        </c:if>

    </div>
</body>
</html>
