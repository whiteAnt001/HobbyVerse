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

        <!-- ✅ 작성일 표시 -->
        <p><strong>작성일:</strong> ${formattedRegDate}</p>

        <!-- ✅ 조회수 제거 -->
        <%-- <p><strong>조회수:</strong> ${board.readCount}</p> --%>

        <hr>
        <p>${board.content}</p>
        <a href="/boards" class="btn btn-primary">목록으로</a>
    </div>
</body>
</html>
