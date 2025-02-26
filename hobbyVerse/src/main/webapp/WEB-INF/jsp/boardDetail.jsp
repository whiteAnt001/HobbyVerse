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

        <!-- ✅ 게시글 수정 / 삭제 (로그인한 사용자의 이메일이 게시글 이메일과 같을 때만 가능 / 관리자 권한을 가진 사람도 가능) -->
        <c:if test="${not empty user and user.email == board.email || user.role == 'ROLE_ADMIN'}">
            <form action="/boards/${board.seq}/update" method="post">
                <div class="mb-3">
                    <label class="form-label"><strong>제목:</strong></label>
                    <input type="text" class="form-control" name="subject" value="${board.subject}" required>
                </div>

                    <div class="mb-3">
                        <label class="form-label"><strong>내용:</strong></label>
                        <textarea class="form-control" name="content" rows="5" required>${board.content}</textarea>
                    </div>

                    <!-- 🔹 수정 버튼과 목록으로 버튼 -->
                    <div class="d-flex align-items-center gap-2">
                        <a href="/boards" class="btn btn-secondary">목록으로</a>
                        <button type="submit" class="btn btn-primary">수정 완료</button>
                    </div>
                </form>

            <!-- ✅ 삭제 버튼 -->
            <form action="/boards/${board.seq}/delete" method="post" class="mt-2"
                  onsubmit="return confirm('정말 삭제하시겠습니까?');">
                <button type="submit" class="btn btn-danger">삭제</button>
            </form>
        </c:if>

        <!-- ✅ 수정/삭제 권한이 없는 경우 -->
        <c:if test="${empty user or user.email != board.email}">
            <p>${board.content}</p>
            <a href="/boards" class="btn btn-secondary">목록으로</a>
        </c:if>

        <hr>

        <!-- ✅ 추천 버튼 -->
        <c:if test="${not empty user}">
            <button id="recommendButton" class="btn btn-success"
                    onclick="recommendPost(${board.seq})"
                    <c:if test="${not empty recommendedToday and recommendedToday}">disabled</c:if> >
                추천 👍
            </button>
        </c:if>

        <!-- ✅ 추천 결과 메시지 -->
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-warning mt-3">${errorMessage}</div>
        </c:if>

        <hr>
        <!-- 댓글 달기 -->
        <c:if test="${not empty user}">
        <form action="/comments/create" method="post">
            <input type="hidden" name="boardId" value="${board.seq}"/>
            <input type="hidden" name="userName" value="${user.name}"/>
            <input type="hidden" name="userEmail" value="${user.email}"/>
            <input type="hidden" name="parentId" value="${parentCommentId}"/>
                <Strong>${user.name}</Strong>
            <div class="mb-3" id="create-comment-${comment.id}">
                <textarea name="content" id="comment-input-${comment.id}" class="form-control" placeholder="댓글을 작성해주세요." rows="3"></textarea>
            </div>
            <button type="submit" class="btn btn-primary">댓글 작성</button>
        </form>
		</c:if>
        <hr>

        <!-- 댓글 목록 표시 -->
        <div id="commentList">
            <h2>댓글목록</h2>
            <c:forEach var="comment" items="${comments}">
                <div class="card mb-3 shadow-sm" id="comment-${comment.id}">
                    <div class="card-body">
                       	<h5 class="card-title">${comment.userName}</h5>
                       	<p id="comment-content-${comment.id}" class="card-text">${comment.content}</p>
                       	<!-- 댓글 수정폼 (숨김처리) -->
                		<div id="edit-form-${comment.id}" style="display: none;">
                    		<textarea id="edit-input-${comment.id}" class="form-control" rows="3">${comment.content}</textarea>
                    		<button type="button" class="btn btn-success btn-sm mt-1" onclick="updateComment(${comment.id})">수정 완료</button>
                    		<button type="button" class="btn btn-secondary btn-sm mt-1" onclick="toggleEditForm(${comment.id})">취소</button>
                		</div>
                       <!-- 삭제 및 수정버튼은 댓글 작성자와 현재 로그인한 사용자가 동일하면 표시 -->
                       <c:if test="${user.email == comment.userEmail}">
                       <button type="button" class="btn btn-warning btn-sm" onclick="toggleEditForm(${comment.id})">수정</button>
                       <button type="button" class="btn btn-warning btn-sm" onclick="deleteComment(${comment.id})">삭제</button>
                       </c:if>
                       <button type="button" class="btn btn-warning btn-sm" onclick="toggleReplyForm(${comment.id})">답글</button>
                    </div>
                    <div class="card-footer text-muted">
                        <small>작성일: ${comment.createdAt}</small>
                    </div>
                    <!-- 답글 입력폼 ( 숨김처리) -->
                    <div id="reply-form-${ comment.id }" style="display: none;">
                    	<textarea id="reply-input-${comment.id}" class="form-control" rows="3">${comment.content}</textarea>
                    	<button type="button" class="btn btn-success btn-sm mt-1" onclick="createReplyComment(${comment.id})">작성 완료</button>
                    	<button type="button" class="btn btn-secondary btn-sm mt-1" onclick="toggleReplyForm(${comment.id})">취소</button>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
    
	<script>
    document.addEventListener("DOMContentLoaded", function () {
    	// 대닷글 작성 폼 나타내기
    	window.toggleReplyForm = function(commentId){
    		const form = document.getElementById('reply-form-' + commentId);
    		if(form){
    			form.style.display = form.style.display === 'none' ? 'block' : 'none';
    		}else {
    		console.error('대댓글 폼을 찾을 수 없습니다: reply-form-' + commentId);
    		}
    	};

    	// 대댓글 작성
    	window.createReplyComment = function(commentId) {
    		const replyContent = document.getElementById('reply-input-' + commentId).value;
    		const userEmail = document.querySelector('input[name=userEmail]').value;
    		console.log(userEmail);  // userEmail 값이 제대로 출력되는지 확인
    		
    		fetch("/comments/create/" + commentId, {
    			method: 'POST',
    			headers: { 'Content-Type': 'application/json'},
    			body: JSON.stringify({ content: replyContent, userEmail: userEmail })
    		})
    		.then(response => response.json())
    		.then(data => {
    			if(data.id){
    				const commentList = document.getElementById('comment-' + commentId);
    				const replyCard = document.createElement('div');
    				replyCard.classList.add('card', 'mb-3', 'shadow-sm');
                    replyCard.style.marginLeft = '30px';
                    replyCard.innerHTML = `
                        <div class="card-body">
                    		
                            <h5 class="card-title">${data.userName}</h5>
                            <p class="card-text">${data.content}</p>
                        </div>
                        <div class="card-footer text-muted">
                            <small>작성일: ${data.createdAt}</small>
                        </div>
                    `;
                    commentList.appendChild(replyCard);

                    // 대댓글 폼 숨기기
                    toggleReplyForm(commentId);
                } else {
                    alert("대댓글 작성 실패" + data.message);
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert("대댓글 작성 중 오류가 발생했습니다.");
            });
        }

        // 댓글 수정 폼 나타내기
        window.toggleEditForm = function (commentId) {
            const form = document.getElementById('edit-form-' + commentId);
            if (form) {
                form.style.display = form.style.display === 'none' ? 'block' : 'none';
            } else {
                console.error('수정 폼을 찾을 수 없습니다: edit-form-' + commentId);
            }
        };

        // 댓글 수정
        window.updateComment = function (commentId) {
            const newContent = document.getElementById('edit-input-' + commentId).value;

            fetch('/comments/updateComment/' + commentId, {
                method: 'PUT',
                headers: { 'Content-Type': 'application/json' },
                body: newContent
            })
            .then(response => {
                if (response.ok) {
                    // UI 업데이트
                    const commentContent = document.getElementById('comment-content-' + commentId);
                    if(commentContent){
                    	commentContent.innerText = newContent;
                    }
                    toggleEditForm(commentId);
                    alert("수정이 완료되었습니다.");
                } else {
                    response.text().then(text => alert("수정 실패: " + text));
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert("수정 요청 중 오류 발생: " + error.message);
            });
        };

        // 댓글 삭제
        window.deleteComment = function (commentId) {
            if (!confirm("정말 삭제하시겠습니까?")) return;

            fetch('/comments/delete/' + commentId, {
                method: 'DELETE',
                headers: { 'Content-Type': 'application/json' }
            })
            .then(response => {
                if (response.ok) {
                    document.getElementById('comment-' + commentId).remove();
                    alert("삭제 완료");
                } else {
                    response.text().then(text => alert("삭제 실패: " + text));
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert("삭제 중 오류 발생: " + error.message);
            });
        };
    });
	</script>

</body>
</html>
