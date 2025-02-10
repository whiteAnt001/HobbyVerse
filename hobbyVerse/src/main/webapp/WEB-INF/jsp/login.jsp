<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="UTF-8">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인 - HobbyVerse</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
       body {
           background-color: #6a11cb;
           min-height: 100vh;
           display: flex;
           justify-content: center;
           align-items: center;
           margin: 0;
           animation: fadeIn 1s ease-out;
       }
       .container {
           display: flex;
           justify-content: space-between;
           align-items: center;
           width: 100%;
           max-width: 1200px;
           padding: 20px;
           opacity: 0;
           animation: slideUp 1s forwards 0.5s;
       }
       .welcome-text {
           color: white;
           max-width: 550px;
           text-align: left;
       }
       .welcome-text h1 {
           font-size: 3rem;
           font-weight: bold;
           margin-bottom: 1rem;
       }
       .welcome-text p {
           font-size: 1.2rem;
           line-height: 1.6;
       }
       .card {
           border-radius: 10px;
           box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
           background: white;
           width: 400px;
           opacity: 0;
           animation: slideUp 1s forwards 0.5s;
       }
       .card-body {
           padding: 2rem;
       }
       .btn-gradient {
           background: linear-gradient(135deg, #6a11cb, #2575fc);
           border: none;
           color: white;
           padding: 10px 20px;
           border-radius: 5px;
           width: 100%;
           cursor: pointer;
       }
       .btn-gradient:hover {
           background: linear-gradient(135deg, #2575fc, #6a11cb);
       }
       .form-control {
           border-radius: 5px;
           margin-bottom: 1rem;
       }
       .text-danger {
           font-size: 0.9rem;
           color: red;
       }
       .footer-link {
           text-align: center;
           margin-top: 1rem;
       }
       @keyframes slideUp {
           from { transform: translateY(50px); opacity: 0; }
           to { transform: translateY(0); opacity: 1; }
       }
       @keyframes fadeIn {
           from { opacity: 0; }
           to { opacity: 1; }
       }
    </style>
</head>
<body>
    <div class="container">
        <div class="welcome-text">
            <h1>모임이 쉽고 즐거워지다!</h1>
            <p>HobbyVerse와 함께 새로운 취미를 발견하고, 같은 관심사를 가진 사람들과 소통하세요. 지금 바로 시작해보세요!</p>
        </div>
        <div class="card">
            <div class="card-body">
                <h3 class="card-title text-center">로그인</h3>
                <form:form modelAttribute="user" action="/loginDo">
                    <div class="mb-3">
                        <label for="email" class="form-label">아이디</label>
                        <form:input path="email" class="form-control" placeholder="아이디를 입력하세요"/>
                        <form:errors path="email" cssClass="text-danger"/>
                    </div>
                    <div class="mb-3">
                        <label for="password" class="form-label">비밀번호</label>
                        <form:password path="password" class="form-control" placeholder="비밀번호를 입력하세요"/>
                        <form:errors path="password" cssClass="text-danger"/>
                    </div>
                    <button type="submit" class="btn-gradient">로그인</button>
                </form:form>
                <div class="footer-link">
                    <p>아직 회원이 아니신가요? <a href="/signup">회원 가입</a></p>
                </div>
                <div class="text-center mt-3">
                    <span>소셜 계정으로 로그인</span>
                </div>
                <div align="center" class="social-login-btn mt-2">
                <a href="<c:url value='/oauth2/authorization/google'/>">
                    <img src="/img/google1.png" alt="Google">
                </a>
                </div>
                <div class="social-login-btn mt-2">
                    <img src="https://upload.wikimedia.org/wikipedia/commons/6/69/Facebook_Logo_2023.png" alt="Facebook">
                    <span>페이스북으로 로그인</span>
                </div>
            </div>
        </div>
    </div>
    <c:if test="${FAIL == 'YES'}">
    	<script type="text/javascript">
    		alert("계정 또는 비밀번호가 일치하지 않습니다.");
    	</script>
    </c:if>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
