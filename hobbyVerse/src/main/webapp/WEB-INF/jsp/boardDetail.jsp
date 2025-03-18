<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page session="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

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
      .gradient-bg {background: linear-gradient(135deg, #6a11cb, #2575fc);} /* 배경에 그라데이션 효과 적용 */

	.container {
	    max-width: 800px;
	    margin: 0 auto;
	    padding: 20px;
	}

/* 전체 레이아웃 및 배경 스타일 */
body {
    background-color: #f8f9fa;
    font-family: Arial, sans-serif;
}

/* 댓글 작성 버튼의 여백 */
#writebutton {
    margin-top: 5px;
}

/* 댓글 목록 컨테이너 스타일 */
#commentList {
    max-width: 700px;  /* 댓글 목록의 최대 너비를 700px로 줄임 */
    margin: 0 auto;
    font-family: Arial, sans-serif;
}

/* 각 댓글 스타일 */
.comment {
    background-color: #f9f9f9;
    border: 1px solid #ddd;
    border-radius: 10px;
    margin-bottom: 10px;
    padding: 8px 10px;  /* 패딩을 약간 줄여서 댓글 사이즈 축소 */
    position: relative;
}

/* 댓글 헤더 부분 (작성자, 날짜 등) 스타일 */
.comment-header {
    display: flex;
    justify-content: space-between;
    font-size: 13px;  /* 폰트 크기 약간 줄임 */
    color: #555;
}

/* 댓글 작성자 이름 스타일 */
.comment-user {
    font-weight: bold;
}

/* 댓글 작성일 스타일 */
.comment-date {
    font-size: 11px;  /* 날짜 폰트 크기 줄임 */
    color: #999;
}

/* 댓글 내 버튼들 스타일 */
.comment .btn {
    font-size: 11px;  /* 버튼 폰트 크기 줄임 */
    padding: 3px 6px;  /* 버튼 내 여백 축소 */
    margin-right: 5px;
}

/* 대댓글 목록 스타일 */
.reply-list {
    margin-left: 20px;  /* 왼쪽 여백을 약간 줄임 */
    margin-top: 8px;  /* 상단 여백을 약간 줄임 */
    max-height: 250px;  /* 대댓글 목록 최대 높이를 250px로 줄임 */
    overflow-y: auto;
    padding-right: 8px;
    padding-bottom: 8px;
}

/* 댓글 내용과 버튼을 구분하여 배치하는 스타일 */
.comment-content-container {
    display: flex;
    justify-content: space-between;
    align-items: center;
}

/* 댓글 내용 스타일 */
.comment-content {
    margin-right: 8px;  /* 버튼과 내용 사이 여백을 줄임 */
    flex-grow: 1;
}

/* 게시글 이미지 크기 제한 */
.board-image {
    max-width: 200px;  /* 이미지 최대 너비를 200px로 줄임 */
    height: auto;
    display: block;
    margin: 8px auto;  /* 이미지 여백을 약간 줄임 */
    border-radius: 8px;  /* 모서리 둥글게 설정 */
    box-shadow: 2px 2px 8px rgba(0, 0, 0, 0.1);  /* 그림자 효과 조정 */
}

/* 댓글 내 액션 버튼들을 오른쪽 정렬 */
.comment-actions {
    text-align: right;
}

/* 댓글 내 액션 버튼 스타일 */
.comment-actions button {
    margin-left: 4px;  /* 버튼 사이 여백을 줄임 */
}

/* 대댓글 작성 스타일 */
.reply {
    background-color: #f1f1f1;
    border: 1px solid #ccc;
    padding: 10px;
    border-radius: 8px;
    margin-top: 8px;  /* 대댓글 위 여백을 줄임 */
}

/* 텍스트 영역 스타일 */
textarea {
    width: 100%;
    font-size: 13px;  /* 폰트 크기 약간 줄임 */
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
                <p><strong>작성자:</strong> ${board.name} #${board.user.userId }</p>
                <p><strong>작성일:</strong> ${formattedRegDate}</p>
            </div>
            <div>
                <p><strong>조회수:</strong> ${board.readCount}</p>
                <p><strong>추천수:</strong> <span id="likeCount">${board.likes}</span></p>
            </div>
        </div>
        <hr>

        <!-- ✅ 게시글 수정 / 삭제 (로그인한 사용자의 이메일이 게시글 이메일과 같을 때만 가능 / 관리자 권한을 가진 사람도 가능) -->
		<!-- ✅ 게시글 내용 -->
		        <c:if test="${not empty user and user.email == board.email}">
		        	<sec:authorize access="hasRole('ADMIN')">
		            <form action="/boards/${board.seq}/update" method="post" enctype="multipart/form-data">
		                <div class="mb-3">
		                    <label class="form-label"><strong>제목:</strong></label>
		                    <input type="text" class="form-control" name="subject" value="${board.subject}" required>
		                </div>
				<!-- ✅ 게시글 이미지 표시 -->
				<c:if test="${not empty board.imagePath}">
					<div class="text-center mt-3">
						<img src="${board.imagePath}" class="board-image"
							style="width: 100%; max-width: 800px; height: auto;">
					</div>
				</c:if>
		                <div class="mb-3">
		                    <label class="form-label"></label>
		                    <textarea class="form-control" name="content" rows="5" required>${board.content}</textarea>
		                </div>
						<div class="mb-3">
							<input type="file" class="form-control" id="file" name="file" accept="image/*"/>
						</div>

						<div class="d-flex align-items-center gap-2">
		                    <button type="submit" class="btn btn-primary">수정 완료</button>
		                    <a href="/boards" class="btn btn-secondary">목록으로</a>
		                </div>
		            </form>

		            <form action="/boards/${board.seq}/delete" method="post" class="mt-2"
		                  onsubmit="return confirm('정말 삭제하시겠습니까?');">
		                <button type="submit" class="btn btn-danger">삭제</button>
		            </form>
		            </sec:authorize>
		        </c:if>
		        <c:if test="${empty user || user.email != board.email}">
		            <p>${board.content}</p>
		            		                				<!-- ✅ 게시글 이미지 표시 -->
				<c:if test="${not empty board.imagePath}">
					<div class="text-center mt-3">
						<img src="${board.imagePath}" class="board-image"
							style="width: 100%; max-width: 800px; height: auto;">
					</div>
				</c:if>
		            <a href="/boards" class="btn btn-secondary">목록으로</a>
		        </c:if>


        <hr>

		<!-- ✅ 이미지 스타일 추가 -->
		<style>
		    .board-image {
		        max-width: 250px; /* ✅ 최대 너비 */
		        height: auto;     /* ✅ 비율 유지 */
		        display: block;   
		        margin: 10px auto; /* ✅ 중앙 정렬 */
		        border-radius: 10px; /* ✅ 둥근 모서리 */
		        box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.1); /* ✅ 그림자 효과 */
		    }
		</style>
        <!-- ✅ 추천 버튼 -->
        <sec:authorize access="isAuthenticated()">
            <button id="recommendButton" class="btn btn-success"
                    onclick="recommendPost(${board.seq})"
                    <c:if test="${not empty recommendedToday and recommendedToday}">disabled</c:if> >
                추천 👍
            </button>
        </sec:authorize>

        <!-- ✅ 추천 결과 메시지 -->
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-warning mt-3">${errorMessage}</div>
        </c:if>

        <hr>
        <!-- 댓글 달기 -->
         <form id="commentForm">
             <input type="hidden" id="boardId" value="${board.seq}"/>
             <input type="hidden" id="userName" value="${user.name}"/>
             <input type="hidden" id="userEmail" value="${user.email}"/>
             <input type="hidden" id="userId" value="${user.userId}"/>
             <textarea id="content" class="form-control" rows="3"></textarea>     
        <sec:authorize access="isAuthenticated()">
             <button type="button" id="writebutton" class="btn btn-primary" onclick="submitComment()">댓글 작성</button>
      	</sec:authorize>
         </form>
        <hr>
   </div>
       <!-- 댓글 목록 표시 -->
   <div id="commentList">
      <h4>댓글 목록</h4>

      <c:forEach var="comment" items="${comments}">
         <c:if test="${empty comment.parentId}">
            <div class="comment" id="comment-${comment.id}">
               <div class="comment-header">
                  <span class="comment-user">${comment.userName} #${comment.user.userId }</span> <span
                     class="comment-date">작성일: ${comment.createdAtString}</span>
               </div>
               <p class="comment-content">${comment.content}</p>

               <!-- 수정 및 삭제 버튼 (작성자만 가능) -->
               <c:if test="${user.email == comment.userEmail || user.role == 'ROLE_ADMIN'}">
                  <button type="button" class="btn btn-warning btn-sm"
                     onclick="toggleEditForm(${comment.id})">수정</button>
                  <button type="button" class="btn btn-danger btn-sm"
                     onclick="deleteComment(${comment.id})">삭제</button>
               </c:if>

               <!-- 답글 버튼 -->
               <button type="button" class="btn btn-secondary btn-sm"
                  onclick="toggleReplyForm(${comment.id})">답글</button>

               <!-- 댓글 수정 폼 (숨김 처리) -->
               <div id="edit-form-${comment.id}" style="display: none;">
                  <textarea id="edit-input-${comment.id}" class="form-control"
                     rows="3">${comment.content}</textarea>
                  <button type="button" class="btn btn-primary btn-sm mt-1"
                     onclick="updateComment(${comment.id})">수정 완료</button>
                  <button type="button" class="btn btn-secondary btn-sm mt-1"
                     onclick="toggleEditForm(${comment.id})">취소</button>
               </div>

               <!-- 답글 입력 폼 (숨김 처리) -->
               <div id="reply-form-${comment.id}"
                  style="display: none; margin-left: 30px;">
                  <textarea id="reply-input-${comment.id}" class="form-control"
                     rows="3"></textarea>
                  <button type="button" class="btn btn-success btn-sm mt-1"
                     onclick="createReplyComment(${comment.id})">작성 완료</button>
                  <button type="button" class="btn btn-secondary btn-sm mt-1"
                     onclick="toggleReplyForm(${comment.id})">취소</button>
               </div>

               <!-- 대댓글 리스트 -->
               <div class="reply-list">
                  <c:forEach var="reply" items="${comments}">
                     <c:if test="${reply.parentId == comment.id}">
                        <div class="comment reply" id="comment-${reply.id}">
                           <div class="comment-header">
                              <span class="comment-user">${reply.userName} #${reply.user.userId }</span> <span
                                 class="comment-date">작성일: ${reply.createdAtString}</span>
                           </div>
                           <div class="comment-content-container">
                              <p class="comment-content">${reply.content}</p>
                              <!-- 대댓글 수정 및 삭제 버튼 (내용 오른쪽에 위치) -->
                              <c:if test="${user.email == comment.userEmail || user.role == 'ROLE_ADMIN'}">
                                 <div class="comment-actions">
                                    <button type="button" class="btn btn-warning btn-sm"
                                       onclick="replyToggleEditForm(${reply.id})">수정</button>
                                    <button type="button" class="btn btn-danger btn-sm"
                                       onclick="deleteComment(${reply.id})">삭제</button>
                                 </div>
                              </c:if>
                           </div>
                        </div>

                        <!-- 대댓글 수정 폼 -->
                        <div id="reply-edit-form-${reply.id}" style="display: none;">
                           <textarea id="reply-edit-input-${reply.id}"
                              class="form-control" rows="3">${reply.content}</textarea>
                           <button type="button" class="btn btn-primary btn-sm mt-1"
                              onclick="replyUpdateComment(${reply.id})">수정 완료</button>
                           <button type="button" class="btn btn-secondary btn-sm mt-1"
                              onclick="replyToggleEditForm(${reply.id})">취소</button>
                        </div>
                     </c:if>
                  </c:forEach>
               </div>
            </div>
         </c:if>
      </c:forEach>
      <div align="center">
      <c:if test="${empty user or (user.email != board.email and user.role != 'ROLE_ADMIN')}">
		    <a href="/boards" class="btn btn-secondary">목록으로</a>
	</c:if>
      </div>
   </div>
   
   <br />
   		                       <!-- ✅ JavaScript: 이미지 미리보기 기능 -->
    <script>
        function previewImage(event) {
            const input = event.target;
            const previewContainer = document.getElementById("imagePreviewContainer");
            const previewImage = document.getElementById("imagePreview");

            if (input.files && input.files[0]) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    previewImage.src = e.target.result;
                    previewContainer.style.display = "block";
                };
                reader.readAsDataURL(input.files[0]);
            } else {
                previewContainer.style.display = "none";
            }
        }
    </script>
   <script>
   //댓글 작성하기
    function submitComment() {
        const boardId = document.getElementById("boardId").value;
        const userId = document.getElementById("userId").value;
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
                userId: userId,
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
                alert("댓글이 작성되었습니다.");
                location.reload();
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
           const userIdInput = document.getElementById("userId");
           
           // 위의 값이 없으면 경고창 표시
           if (!userEmailInput || !userNameInput || !boardIdInput) {
               console.error("사용자 정보 입력 필드가 없습니다.");
               alert("로그인 후 시도하세요.");
               return;
           }
           
           //값 전달
           const userEmail = userEmailInput.value;
           const userName = userNameInput.value;
           const boardId = boardIdInput.value;
           const userId = userIdInput.value;

           if (!replyContent.trim()) {
               alert("대댓글 내용을 입력해 주세요.");
               return;
           }

           fetch("/comments/create", {
               method: 'POST',
               headers: { 'Content-Type': 'application/json' },
               body: JSON.stringify({
                   content: replyContent,
                   userId: userId,
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
                   alert("대댓글이 작성되었습니다.");
                   location.reload();
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
                    location.reload();
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
                body: JSON.stringify({ content: newContent })
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    // 댓글 내용 업데이트
                    const commentContent = document.getElementById('comment-content-' + commentId);
                    if (commentContent) {
                        commentContent.innerText = newContent;
                    }
                    alert("수정이 완료되었습니다.");
                    location.reload();
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