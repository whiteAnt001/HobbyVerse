<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="UTF-8">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>새 게시글 작성</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">

    <!-- ✅ 네비게이션 바 글씨 색상 오류 해결 -->
    <style>
        .navbar-nav .nav-link {
            color: white !important;  /* ✅ 글씨를 흰색으로 강제 설정 */
        }
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

    <!-- ✅ 네비게이션 바 포함 -->
    <jsp:include page="/WEB-INF/jsp/navbar.jsp"/>

    <div class="container mt-5">
        <h2 class="text-center mb-4">새 게시글 작성</h2>

        <!-- ✅ 이미지 업로드를 위한 enctype="multipart/form-data" 추가 -->
		<form action="/boards/create" method="post" enctype="multipart/form-data">
		    <div class="mb-3">
		        <label for="subject" class="form-label">제목</label>
		        <input type="text" class="form-control" id="subject" name="subject" required>
		    </div>
		    <div class="mb-3">
		        <label for="content" class="form-label">내용</label>
		        <textarea class="form-control" id="content" name="content" rows="5" required></textarea>
		    </div>
		    <div class="mb-3">
		        <label for="file" class="form-label">이미지 업로드</label>
		        <input type="file" class="form-control" id="file" name="file" accept="image/*">
		    </div>
		    <button type="submit" class="btn btn-primary">게시글 저장</button>
		</form>



    </div>

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

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>