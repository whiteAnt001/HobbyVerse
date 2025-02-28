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
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
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
    
    <style type="text/css">
            /* 네비게이션 바 */
        .gradient-bg {
            background: linear-gradient(135deg, #6a11cb, #2575fc);
        }
        .container-lg {
			max-width: 900px; /* container-lg의 최대 너비를 더 넓게 설정 */
			margin-top: 50px;
		}

        /* 전체 레이아웃 조정 */
        body {
            background-color: #f8f9fa; /* 배경색 변경 */
            font-family: Arial, sans-serif; /* 폰트 변경 */
        }
        
    </style>
</head>
<body>

	    <!-- 네비게이션 바 포함 -->
    <jsp:include page="/WEB-INF/jsp/navbar.jsp"/>
    
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
			<form id="commentForm">
    			<input type="hidden" id="boardId" value="${board.seq}"/>
    			<input type="hidden" id="userName" value="${user.name}"/>
    			<input type="hidden" id="userEmail" value="${user.email}"/>
    			<textarea id="content" class="form-control" rows="3"></textarea>
    			<button type="button" class="btn btn-primary" onclick="submitComment()">댓글 작성</button>
			</form>
		</c:if>
        <hr>

       <!-- 댓글 목록 표시 -->
<div id="commentList">
    <h2>댓글 목록</h2>
    
    <c:forEach var="comment" items="${comments}">
        <!-- 부모 댓글만 먼저 출력 (parentId가 없는 댓글) -->
        <c:if test="${empty comment.parentId}">
            <div class="card mb-3 shadow-sm" id="comment-${comment.id}">
                <div class="card-body">
                    <h5 class="card-title">${comment.userName}</h5>
                    <p id="comment-content-${comment.id}" class="card-text">${comment.content}</p>

                    <!-- 수정 및 삭제 버튼 (작성자만 가능) -->
                    <c:if test="${user.email == comment.userEmail}">
                        <button type="button" class="btn btn-warning btn-sm" onclick="toggleEditForm(${comment.id})">수정</button>
                        <button type="button" class="btn btn-danger btn-sm" onclick="deleteComment(${comment.id})">삭제</button>
                    </c:if>

                    <!-- 답글 버튼 -->
                    <button type="button" class="btn btn-secondary btn-sm" onclick="toggleReplyForm(${comment.id})">답글</button>
                </div>
                <div class="card-footer text-muted">
                    <small>작성일: ${comment.createdAt}</small>
                </div>

                
				<!-- 댓글 수정 폼 (숨김 처리) -->
				<div id="edit-form-${comment.id}" style="display: none;">
    				<textarea id="edit-input-${comment.id}" class="form-control" rows="3">${comment.content}</textarea>
    				<button type="button" class="btn btn-primary btn-sm mt-1" onclick="updateComment(${comment.id})">수정 완료</button>
    				<button type="button" class="btn btn-secondary btn-sm mt-1" onclick="toggleEditForm(${comment.id})">취소</button>
				</div>

                <!-- 답글 입력 폼 (숨김 처리) -->
                <div id="reply-form-${comment.id}" style="display: none; margin-left: 30px;">
                    <textarea id="reply-input-${comment.id}" class="form-control" rows="3"></textarea>
                    <button type="button" class="btn btn-success btn-sm mt-1" onclick="createReplyComment(${comment.id})">작성 완료</button>
                    <button type="button" class="btn btn-secondary btn-sm mt-1" onclick="toggleReplyForm(${comment.id})">취소</button>
                </div>
                

                <!-- 대댓글 리스트 (부모 댓글 아래에 대댓글 표시) -->
                <c:forEach var="reply" items="${comments}">
                    <c:if test="${reply.parentId == comment.id}">
                        <div class="card mb-3 shadow-sm" id="comment-${reply.id}" style="margin-left: 30px;">
                            <div class="card-body">
                                <h5 class="card-title">${reply.userName}</h5>
                                <p id="comment-content-${reply.id}" class="card-text">${reply.content}</p>

                                <!-- 대댓글 삭제 버튼 (작성자만 가능) -->
                                <c:if test="${user.email == reply.userEmail}">
                                    <button type="button" class="btn btn-warning btn-sm" onclick="replyToggleEditForm(${reply.id})">수정</button>
                                    <button type="button" class="btn btn-danger btn-sm" onclick="deleteComment(${reply.id})">삭제</button>
                                </c:if>
                            </div>
                            <div class="card-footer text-muted">
                                <small>작성일: ${reply.createdAt}</small>
                            </div>
                        </div>
                    </c:if>
                    
			<!-- 대댓글 수정 폼 -->
			<div id="reply-edit-form-${reply.id}" style="display: none;">
    			<textarea id="reply-edit-input-${reply.id}" class="form-control" rows="3">${reply.content}</textarea>
    			<button type="button" class="btn btn-primary btn-sm mt-1" onclick="replyUpdateComment(${reply.id})">수정 완료</button>
    			<button type="button" class="btn btn-secondary btn-sm mt-1" onclick="replyToggleEditForm(${reply.id})">취소</button>
			</div>
                </c:forEach>
            </div>
        </c:if>
    </c:forEach>
</div>

    
	<script>
	//댓글 작성하기
    function submitComment() {
        const boardId = document.getElementById("boardId").value;
        const userName = document.getElementById("userName").value;
        const userEmail = document.getElementById("userEmail").value;
        const content = document.getElementById("content").value;

        if (!content.trim()) {
            alert("댓글 내용을 입력해 주세요.");
            return;
        }

        fetch("/comments/create", {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify({
                boardId: boardId,
                userName: userName,
                userEmail: userEmail,
                content: content
            })
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                alert("댓글이 작성되었습니다.");
                location.reload();
            } else {
                alert("댓글 작성 실패: " + data.message);
            }
        })
        .catch(error => {
            console.error("Error:", error);
            alert("댓글 작성 중 오류가 발생했습니다.");
        });
    }
    
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

    	window.createReplyComment = function(commentId) {
    	    const replyContent = document.getElementById('reply-input-' + commentId).value;
    	    // 사용자 정보 가져오기
    	    const userEmailInput = document.getElementById("userEmail");
    	    const userNameInput = document.getElementById("userName");
    	    const boardIdInput = document.getElementById("boardId");
    	    
    	    // 위의 값이 없으면 경고창 표시
    	    if (!userEmailInput || !userNameInput || !boardIdInput) {
    	        console.error("사용자 정보 입력 필드가 없습니다.");
    	        alert("로그인 정보를 찾을 수 없습니다. 다시 로그인 후 시도하세요.");
    	        return;
    	    }
    	    
    	    //값 전달
    	    const userEmail = userEmailInput.value;
    	    const userName = userNameInput.value;
    	    const boardId = boardIdInput.value;

    	    if (!replyContent.trim()) {
    	        alert("대댓글 내용을 입력해 주세요.");
    	        return;
    	    }

    	    fetch("/comments/create", {
    	        method: 'POST',
    	        headers: { 'Content-Type': 'application/json' },
    	        body: JSON.stringify({
    	            content: replyContent,
    	            userEmail: userEmail,
    	            userName: userName,
    	            parentId: commentId,
    	            boardId: boardId
    	        })
    	    })
    	    .then(response => response.json())
    	    .then(data => {
    	        console.log("서버 응답:", data);
    	        if (data.success) {
    	            alert("대댓글이 작성되었습니다.");
    	            location.reload();
    	        } else {
    	            alert("대댓글 작성 실패: " + data.message);
    	        }
    	    })
    	    .catch(error => {
    	        console.error("Error:", error);
    	        alert("대댓글 작성 중 오류가 발생했습니다.");
    	    });
    	};
    	
    	//대댓글 수정
        window.replyToggleEditForm = function (replyId) {
            const form = document.getElementById('reply-edit-form-' + replyId);
            if (form) {
                form.style.display = form.style.display === 'none' ? 'block' : 'none';
            } else {
                console.error('수정 폼을 찾을 수 없습니다: reply-edit-form-' + replyId);
            }
        };

        window.replyUpdateComment = function(replyId) {
            const newContent = document.getElementById('reply-edit-input-' + replyId).value;

            fetch('/comments/updateComment/' + replyId, {
                method: 'PUT',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ content: newContent })  // JSON 형식으로 변환
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    // 대댓글 내용 업데이트
                    const commentContent = document.getElementById('comment-content-' + replyId);
                    if (commentContent) {
                        commentContent.innerText = newContent;
                    }
                    replyToggleEditForm(replyId); // 수정 폼 닫기
                    alert("수정이 완료되었습니다.");
                } else {
                    alert("수정 실패: " + data.message);
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert("수정 요청 중 오류 발생: " + error.message);
            });
        };


        // 댓글 수정 폼 나타내기
        window.toggleEditForm = function (commentId) {
            const form = document.getElementById('edit-form-' + commentId);
            if (form) {
                form.style.display = form.style.display === 'none' ? 'block' : 'none';
            } else {
                console.error('수정 폼을 찾을 수 없습니다: edit-form-' + commentId);
            }
        };

        window.updateComment = function(commentId) {
            const newContent = document.getElementById('edit-input-' + commentId).value;

            fetch('/comments/updateComment/' + commentId, {
                method: 'PUT',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ content: newContent })  // JSON 형식으로 변환
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    // 댓글 내용 업데이트
                    const commentContent = document.getElementById('comment-content-' + commentId);
                    if (commentContent) {
                        commentContent.innerText = newContent;
                    }
                    toggleEditForm(commentId); // 수정 폼 닫기
                    alert("수정이 완료되었습니다.");
                } else {
                    alert("수정 실패: " + data.message);
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
                    alert("댓글이 삭제되었습니다.");
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