<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>  

<!DOCTYPE html>
<html lang="UTF-8">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>게시판 - HobbyVerse</title>
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
    <!-- ✅ 네비게이션 바 -->
    <jsp:include page="/WEB-INF/jsp/navbar.jsp"/>

    <!-- ✅ 검색 및 필터 -->
    <div class="container mt-4">
        <div class="row">
            <div class="col-md-8 mx-auto">
                <form action="/boards" method="get" class="input-group">
                    <input type="text" class="form-control" name="keyword" placeholder="게시글을 검색하세요..." value="${keyword}">
                    <button type="submit" class="btn gradient-btn">검색</button>
                </form>
            </div>
        </div>
    </div>

    <!-- ✅ 게시판 리스트 -->
    <div class="container mt-5">
        <h3 class="text-center mb-4">🔥 게시판</h3>
        <table class="table table-hover">
            <thead class="table-dark">
                <tr>
                    <th>번호</th>
                    <th>제목</th>
                    <th>작성자</th>
                    <th>작성일</th>
                    <th>조회수</th>
                    <th>추천</th>
                </tr>
            </thead>
            <tbody>
                <c:if test="${empty formattedBoards}">
                    <tr>
                        <td colspan="6" class="text-center">게시글이 없습니다.</td>
                    </tr>
                </c:if>

                <c:forEach var="board" items="${formattedBoards}">
                    <tr>
                        <td>${board.seq}</td>
                        <td><a href="/boards/${board.seq}">${board.subject}</a></td>
                        <td>${board.name}</td>
                        <td>${board.formattedRegDate}</td>
                        <td>${board.readCount}</td>
                        <td>${board.likes}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <!-- ✅ 페이징 기능 -->
        <div class="text-center mt-4">
            <c:if test="${boardPage.totalPages > 1}">
                <nav>
                    <ul class="pagination justify-content-center">
                        <!-- 이전 페이지 버튼 -->
                        <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                            <a class="page-link" href="/boards?page=${currentPage - 1}&size=${pageSize}&keyword=${keyword}">이전</a>
                        </li>

                        <!-- 페이지 번호 표시 -->
                        <c:forEach var="i" begin="${currentPage - 2 > 0 ? currentPage - 2 : 1}" 
                                   end="${currentPage + 2 < totalPages ? currentPage + 2 : totalPages}">
                            <li class="page-item ${i == currentPage ? 'active' : ''}">
                                <a class="page-link" href="/boards?page=${i}&size=${pageSize}&keyword=${keyword}">${i}</a>
                            </li>
                        </c:forEach>

                        <!-- 다음 페이지 버튼 -->
                        <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                            <a class="page-link" href="/boards?page=${currentPage + 1}&size=${pageSize}&keyword=${keyword}">다음</a>
                        </li>
                    </ul>
                </nav>
            </c:if>
        </div>

        <!-- ✅ 글쓰기 버튼 -->
        <div class="text-end">
            <a href="/boards/new" class="btn gradient-btn">글쓰기</a>
        </div>
    </div>

    <!-- ✅ Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
