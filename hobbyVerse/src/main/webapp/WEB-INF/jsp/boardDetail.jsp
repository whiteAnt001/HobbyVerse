<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page session="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="UTF-8">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${board.subject}</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <script>
        function recommendPost(seq) {
            fetch('/boards/' + seq + '/recommend', { method: 'POST' })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        document.getElementById("likeCount").innerText = data.likes; // 추천 수 업데이트
                        document.getElementById("recommendButton").disabled = true; // 버튼 비활성화
                        alert("추천되었습니다!");
                    } else {
                        alert(data.message); // 하루 1회 제한 메시지
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert("추천 중 오류가 발생했습니다.");
                });
        }
    </script>
</head>
<body>
    <div class="container mt-5">
        <h1>${board.subject}</h1>

        <!-- ✅ 작성자 / 작성일 / 조회수 / 추천수 -->
        <div class="d-flex justify-content-between">
            <div>
                <p><strong>작성자:</strong> ${board.name}</p>
                <p><strong>작성일:</strong> ${formattedRegDate}</p>
            </div>
            <div>
                <p><strong>조회수:</strong> ${board.readCount}</p>
                <p><strong>추천수:</strong> <span id="likeCount">${board.likes}</span></p>
            </div>
        </div>
        <hr>

        <!-- ✅ 수정 가능한 폼 -->
        <c:if test="${not empty user and user.name == board.name}">
            <form action="/boards/${board.seq}/update" method="post">
                <div class="mb-3">
                    <label class="form-label"><strong>제목:</strong></label>
                    <input type="text" class="form-control" name="subject" value="${board.subject}" required>
                </div>

                <div class="mb-3">
                    <label class="form-label"><strong>내용:</strong></label>
                    <textarea class="form-control" name="content" rows="5" required>${board.content}</textarea>
                </div>

                <!-- ✅ 수정 버튼과 목록으로 버튼 -->
                <div class="d-flex align-items-center gap-2">
                    <a href="/boards" class="btn btn-secondary">목록으로</a>
                    <button type="submit" class="btn btn-primary">수정 완료</button>
                </div>
            </form>

            <!-- ✅ 삭제 버튼을 수정 폼 밖으로 이동 -->
            <form action="/boards/${board.seq}/delete" method="post" class="mt-2"
                  onsubmit="return confirm('정말 삭제하시겠습니까?');">
                <button type="submit" class="btn btn-danger">삭제</button>
            </form>
        </c:if>

        <!-- ✅ 수정 불가능한 경우 내용만 표시 -->
        <c:if test="${empty user or user.name != board.name}">
            <p>${board.content}</p>
            <a href="/boards" class="btn btn-secondary">목록으로</a>
        </c:if>

        <hr>

        <!-- ✅ 추천 버튼 -->
        <c:if test="${not empty user}">
            <button id="recommendButton" class="btn btn-success"
                    onclick="recommendPost(${board.seq})"
                    <c:if test="${not empty recommendedToday and recommendedToday}">disabled</c:if>>
                추천 👍
            </button>
        </c:if>

        <!-- ✅ 추천 결과 메시지 -->
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-warning mt-3">${errorMessage}</div>
        </c:if>
    </div>
</body>
</html>
