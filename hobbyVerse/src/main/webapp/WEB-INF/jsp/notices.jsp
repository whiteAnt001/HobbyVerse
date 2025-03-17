<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>공지사항</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
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

        a { 
            text-decoration: none; 
        }
        a:hover { 
            text-decoration: underline; 
        }
        
        .notice-item {
            background: #f8f9fa;
            margin-bottom: 10px;
            padding: 15px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .notice-title {
            font-size: 1.2rem;
            font-weight: bold;
        }

        .notice-meta {
            font-size: 0.9rem;
            color: #6c757d;
        }

        .notice-link {
            text-decoration: none;
            color: #007bff;
        }

        .notice-link:hover {
            text-decoration: underline;
        }

    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/jsp/navbar.jsp"/>

    <div class="container mt-5">
        <h3 class="text-center mb-4">공지사항</h3>
        <table class="table table-hover">
            <thead class="table-dark">
                <tr>
                    <th>번호</th>
                    <th>제목</th>
                    <th>작성자</th>
                    <th>작성일</th>
                </tr>
            </thead>
            <tbody>
                <c:if test="${empty notice}">
                    <tr>
                        <td colspan="4" class="text-center">공지사항이 없습니다.</td>
                    </tr>
                </c:if>
                <c:forEach var="notice" items="${notice}">
                    <tr>
                        <td>${notice.id}</td>
                        <td>
                            <a href="/notices/${notice.id}" class="notice-link">${notice.title}</a>
                        </td>
                        <td>${notice.user.name}</td>
                        <td>${notice.regDateString}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <div class="text-end mt-4">
            <sec:authorize access="hasRole('ADMIN')">
                <a href="/notices/createForm" class="btn gradient-btn">공지사항 작성</a>
            </sec:authorize>
        </div>
    </div>
</body>
</html>
