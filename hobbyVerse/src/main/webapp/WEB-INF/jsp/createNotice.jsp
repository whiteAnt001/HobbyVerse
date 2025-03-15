<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>공지사항 작성</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        .container {
            max-width: 600px;
            margin-top: 50px;
        }
        body {
            background-color: #f8f9fa;
            font-family: Arial, sans-serif;
        }
    </style>
</head>
<body>
    <!-- 네비게이션 바 포함 -->
    <jsp:include page="/WEB-INF/jsp/navbar.jsp"/>

    <div class="container">
        <h2 class="text-center mb-4">공지사항 작성</h2>
        <input type="hidden" id="email" value="${ user.email }">
            <div class="mb-3">
                <label for="title" class="form-label">제목</label>
                <input type="text" class="form-control" id="title" name="title" required>
            </div>

            <div class="mb-3">
                <label for="content" class="form-label">내용</label>
                <textarea class="form-control" id="content" name="content" rows="5" required></textarea>
            </div>

            <div class="mb-3">
                <label for="name" class="form-label">작성자</label>
                <!-- 로그인된 사용자의 이름을 표시 -->
                <input type="text" class="form-control" id="name" name="name" value="${user.name}" readonly>
            </div>

            <div class="d-flex justify-content-between">
                <a href="/notices" class="btn btn-secondary">목록으로</a>
                <button onclick="createNotice()" class="btn btn-primary">등록</button>
            </div>
    </div>
    <script type="text/javascript">
    	async function createNotice(){
    		const title = document.getElementById("title").value;
    		const content = document.getElementById("content").value;
    		const email = document.getElementById("email").value;
    		
    		const response = await fetch("/notices/create", {
    			method: "POST",
    			headers: {
    				"Content-Type": "application/json"
    			},
    		body: JSON.stringify({ 
    			title,
    			content,
    			email
    			})
    		});
    		
    		const result = await response.json();
    		if(result.success){
    			alert("공지사항이 등록되었습니다.")
    			window.location.href = "/notices"; //공지사항 목록으로 이동
    		} else {
    			alert("공지사항 등록 중 오류발생: " + result.message);
    		}
    	}
    </script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
