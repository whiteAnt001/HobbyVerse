<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>  

<!DOCTYPE html>
<html lang="UTF-8">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>취미/스터디 매칭 플랫폼</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        /* 그라데이션 스타일 */
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
    </style>
</head>
<body>
    <!-- 네비게이션 바 포함 -->
    <jsp:include page="/WEB-INF/jsp/navbar.jsp"/>

    <!-- 검색 및 필터 -->
    <div class="container mt-4">
        <div class="row">
            <div class="col-md-8 mx-auto">
                <div class="input-group">
                    <input type="text" class="form-control" placeholder="관심 있는 모임을 검색하세요...">
                    <button class="btn gradient-btn">검색</button>
                </div>
            </div>
        </div>
    </div>

    

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
