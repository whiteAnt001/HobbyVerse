<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="UTF-8">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>관리자 페이지 - 유저 관리</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
<style>
    .gradient-bg {
        background: linear-gradient(135deg, #6a11cb, #2575fc);
    }
    .gradient-btn {
        background: linear-gradient(135deg, #6a11cb, #2575fc);
        border: none;
        color: white;
    }
    .gradient-btn:hover {
        background: linear-gradient(135deg, #2575fc, #6a11cb);
    }
    .table th, .table td {
        vertical-align: middle;
    }
    .action-btns .btn {
        margin-right: 10px;
    }
</style>
</head>
<body>
    <!-- 네비게이션 바 포함 -->
    <jsp:include page="/WEB-INF/jsp/navbar.jsp" />

    <!-- 관리자 페이지 콘텐츠 -->
    <div class="container mt-5">
        <h2 class="text-center mb-4">유저 관리</h2>

        <!-- 유저 리스트 -->
        <div class="card mb-4">
            <div class="card-header">
                <h5 class="card-title">유저 리스트</h5>
            </div>
            <div class="card-body">
                <table class="table table-striped table-bordered">
                    <thead>
                        <tr>
                            <th>번호</th>
                            <th>이름</th>
                            <th>이메일</th>
                            <th>가입일</th>
                            <th>상세 보기</th>
                            <th>관리</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="user" items="${userList}">
                            <tr>
                                <td>${user.id}</td>
                                <td>${user.name}</td>
                                <td>${user.email}</td>
                                <td>${user.createdAt}</td>
                                <td>
                                    <a href="/admin/userDetail/${user.id}" class="btn btn-info btn-sm">상세 보기</a>
                                </td>
                                <td class="action-btns">
                                    <a href="/admin/deleteUser/${user.id}" class="btn btn-danger btn-sm">삭제</a>
                                    <a href="/admin/assignRole/${user.id}" class="btn btn-warning btn-sm">권한 부여</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>