<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>    

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>모임 신고</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    
    <!-- CSS 스타일 -->
    <style type="text/css">
        .container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
        }
        .form-label {
            font-size: 14px;
        }
        .form-control {
            font-size: 14px;
        }
        button, .btn-secondary {
            font-size: 14px;
            padding: 8px 16px;
        }
        .gradient-bg {
            background: linear-gradient(135deg, #6a11cb, #2575fc);
        }
        .container-lg {
            max-width: 900px;
            margin-top: 50px;
        }
        body {
            background-color: #f8f9fa;
            font-family: Arial, sans-serif;
        }
    </style>
</head>

<body>
    <jsp:include page="/WEB-INF/jsp/navbar.jsp"/>
    
    <div class="container mt-5">
    <h2 class="mb-4">모임 신고</h2>
    <form:form action="/meetup/reportDo.html" method="post" modelAttribute="report" enctype="multipart/form-data">
        <div class="mb-3">
            <label for="title" class="form-label">모임 이름 <strong>${meetup.title}</strong></label>
        </div>
        <div class="mb-3">
            <label for="email" class="form-label">작성자 <strong>${report.email}</strong></label>
        </div>
        <div class="mb-3">
            <label for="info" class="form-label">신고 사유</label><br/>
            <form:textarea path="reason" class="form-control" id="reason" name="reason" rows="5" cols="150" required="true"></form:textarea>
        </div>

        <div align="center">
            <button type="submit" class="btn btn-primary">신고하기</button>
            <a href="/meetup/detail.html?id=${meetup.m_id}" class="btn btn-secondary">취소</a>
        </div>
    </form:form>
</div>

    <script type="text/javascript">
        function check(frm) {
            if (!confirm("정말로 신고하시겠습니까?")) {
                return false;
            }
            return true;
        }
    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>