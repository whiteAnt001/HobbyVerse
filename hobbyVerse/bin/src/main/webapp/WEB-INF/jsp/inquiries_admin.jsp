<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>문의사항 관리</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
    <!-- ✅ 관리자 네비게이션 바 포함 (파일명 adminNavber.jsp) -->
    <jsp:include page="/WEB-INF/jsp/adminNavber.jsp"/>

    <div class="container mt-5">
        <h3 class="text-center mb-4">🔥 문의사항 관리</h3>

        <table class="table table-hover">
            <thead class="table-dark">
                <tr>
                    <th>번호</th>
                    <th>제목</th>
                    <th>작성자</th>
                    <th>작성일</th>
                    <th>관리</th>
                </tr>
            </thead>
            <tbody>
				<c:forEach var="inquiry" items="${inquiryList}">
				    <tr>
				        <td>${inquiry.seq}</td>
						<td>${inquiry.title}</td>

				        <td>${inquiry.userEmail}</td>
				        <td>${inquiry.formattedCreatedAt}</td>
				        <td>
							<button type="button" class="btn btn-warning btn-sm" onclick="location.href='/api/admin/inquiries/edit/${inquiry.seq}'">
							    ✏ 수정
							</button>

				            <form action="/api/admin/inquiries/delete/${inquiry.seq}" method="post" style="display:inline;">
				                <button type="submit" class="btn btn-danger btn-sm">🗑 삭제</button>
				            </form>
				        </td>
				    </tr>
				</c:forEach>

            </tbody>
        </table>
    </div>
</body>
</html>
