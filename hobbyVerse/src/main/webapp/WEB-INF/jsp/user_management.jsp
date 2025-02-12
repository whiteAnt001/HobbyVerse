<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>회원 관리</title>
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
        <h2 class="text-center">👥 회원 관리</h2>
        <table class="table table-hover mt-4">
            <thead class="table-dark">
                <tr>
                    <th>이름</th>
                    <th>이메일</th>
                    <th>가입일</th>
                    <th>권한</th>
                    <th>관리</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="user" items="${users}">
                    <tr>
                        <td>${user.name}</td>
                        <td>${user.email}</td>
                       	<td>${user.regDateString}</td>
                        <td>${user.role}</td>
                        <td>
                            <a href="/admin/user/edit/${user.email}" class="btn btn-warning btn-sm">✏ 수정</a>
                            <a href="/admin/user/delete/${user.email}" class="btn btn-danger btn-sm" onclick="return confirm('삭제할까요?')">🗑 삭제</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
