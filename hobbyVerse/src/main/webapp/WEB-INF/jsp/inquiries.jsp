<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>문의사항</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <!-- CSS 파일 링크 -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
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

        /* 답변이 등록된 문의사항을 더 어두운 회색 배경으로 변경 */
        .answered-inquiry {
            background-color: #d6d6d6 !important; /* 기존보다 더 어둡게 조정 */
            opacity: 1; /* 글자 선명하게 */
        }
	   	a {text-decoration: none;}
	   	a:hover {text-decoration: underline;} 
    </style>
</head>
<body>
    <!-- 네비게이션 바 포함 -->
    <jsp:include page="/WEB-INF/jsp/navbar.jsp"/>

    <div class="container mt-5">
        <h3 class="text-center mb-4">문의사항</h3>

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
                <c:if test="${empty formattedInquiries}">
                    <tr>
                        <td colspan="4" class="text-center">문의사항이 없습니다.</td>
                    </tr>
                </c:if>

                <c:forEach var="inquiry" items="${formattedInquiries}">
                    <tr class="${not empty inquiry.adminReply ? 'answered-inquiry' : ''}">
                        <td>${inquiry.seq}</td>
                        <td>
                            <a href="/inquiries/${inquiry.id}">${inquiry.title}</a>
                            <!--  답변이 있으면 '답변 완료' 배지 추가 -->
                            <c:if test="${not empty inquiry.adminReply}">
                                <span class="badge bg-success">답변 완료</span>
                            </c:if>
                        </td>
                        <td>${inquiry.maskedEmail}</td>
                        <td>${inquiry.formattedCreatedAt}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <div class="text-end">
            <c:if test="${not empty user}">
                <a href="/inquiries/write" class="btn gradient-btn">글쓰기</a>
            </c:if>
        </div>
    </div>
    	<!-- 푸터 -->
	<jsp:include page="/WEB-INF/jsp/footer.jsp" />
</body>
</html>
