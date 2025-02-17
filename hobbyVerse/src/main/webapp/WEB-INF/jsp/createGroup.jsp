<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>    

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>모임 등록</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    
    <!-- CSS 스타일 -->
    <style type="text/css">
        /* 전체 크기 줄이기 */
        .container {
            max-width: 800px; /* 원하는 최대 너비 설정 */
            margin: 0 auto; /* 중앙 정렬 */
            padding: 20px; /* 여백 조정 */
        }

        /* 폼 요소 크기 줄이기 */
        .form-label {
            font-size: 14px; /* 폼 라벨 크기 */
        }

        .form-control {
            font-size: 14px; /* 입력 필드 크기 */
        }

        button, .btn-secondary {
            font-size: 14px; /* 버튼 크기 */
            padding: 8px 16px; /* 버튼 여백 */
        }
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
        <h2 class="mb-4">모임 등록</h2>
        <form:form action="/meetup/register.html" method="post" modelAttribute="meetup" enctype="multipart/form-data">
            <div class="mb-3">
                <label for="title" class="form-label">모임 이름</label>
                <form:input path="title" class="form-control" id="title" name="title" required="true"/>
            </div>
			<div class="mb-3">
			    <label for="w_id" class="form-label">작성자 <strong>${loginUser.name }</strong></label>
			</div>

            <div class="mb-3">
                <label for="info" class="form-label">모임 설명</label><br/>
                <form:textarea path="info" class="form-control" id="info" name="info" rows="3" cols="150" required="true"></form:textarea>
            </div>

            <div class="mb-3">
                <label for="c_key" class="form-label">카테고리</label>
                <form:select path="c_key" id="c_key" name="c_key" required="true">
				    <c:forEach var="category" items="${categoryList}">
				        <option value="${category.c_key}">${category.name}</option>
				    </c:forEach>
				</form:select>
            </div>
			<div class="mb-3">
                <label for="price" class="form-label">참가비</label>
                <form:input path="price" class="form-control" id="price" name="price" type="text" required="true"/>
            	<small class="text-muted">참가비는 0 이상 숫자로 입력하세요.</small>
            </div>
            <div class="mb-3">
                <label for="w_date" class="form-label">모임 일정</label>
                <form:input path="w_date" type="date" class="form-control" id="w_date" name="w_date" required="true"/>
            </div>

            <div class="mb-3">
		        <label for="file" class="form-label">모임 사진 업로드</label>
		        <form:input path="file" type="file" class="form-control" id="file" name="file" accept="image/*" required="true"/>
		        <small class="text-muted">JPEG, PNG 형식의 이미지만 업로드 가능합니다.</small>
		        <form:errors path="file"/>
		    </div>
		<div align="center">
			<button type="submit" class="btn btn-primary">등록하기</button>
            <a href="/index" class="btn btn-secondary">취소</a>
		</div>
        </form:form>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
     <script>
        document.querySelector('form').addEventListener('submit', function(event) {
            // 파일 유효성 검사
            var fileInput = document.querySelector('#file');
            var file = fileInput.files[0];
            if (file) {
                var fileType = file.type;
                if (fileType !== 'image/jpeg' && fileType !== 'image/png') {
                    event.preventDefault();
                    alert('JPEG 또는 PNG 형식의 파일만 업로드 가능합니다.');
                    return;
                }
            }
    </script>
</body>
</html>
