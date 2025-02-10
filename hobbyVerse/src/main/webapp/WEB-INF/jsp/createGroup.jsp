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
</head>
<body>
    <div class="container mt-5">
        <h2 class="mb-4">모임 등록</h2>
        <form:form action="/meetup/register.html" method="post" modelAttribute="meetup" enctype="multipart/form-data">
            <div class="mb-3">
                <label for="title" class="form-label">모임 이름</label>
                <form:input path="title" class="form-control" id="title" name="title" required="true"/>
            </div>

            <div class="mb-3">
                <label for="info" class="form-label">모임 설명</label><br/>
                <form:textarea path="info" class="form-control" id="info" name="info" rows="3" cols="150" required="true"></form:textarea>
            </div>

            <div class="mb-3">
                <label for="c_key" class="form-label">카테고리</label>
                <form:select path="c_key" id="c_key" name="c_key" required="true">
                    <option value="">카테고리를 선택하세요</option>
                    <option value="1">운동</option>
                    <option value="2">여행</option>
                    <option value="3">독서</option>
                    <option value="4">취업</option>
                    <option value="5">기타</option>
                </form:select>
            </div>
			<div class="mb-3">
                <label for="price" class="form-label">참가비</label>
                <form:input path="price" class="form-control" id="price" name="price" required="true"/>
            </div>
            <div class="mb-3">
                <label for="w_date" class="form-label">모임 날짜</label>
                <form:input path="w_date" type="date" class="form-control" id="w_date" name="w_date" required="true"/>
            </div>

            <div class="mb-3">
		        <label for="file" class="form-label">모임 사진 업로드</label>
		        <form:input path="file" type="file" class="form-control" id="file" name="file" accept="image/*" required="true"/>
		        <small class="text-muted">JPEG, PNG 형식의 이미지만 업로드 가능합니다.</small>
		        <form:errors path="file"/>
		    </div>

            <button type="submit" class="btn btn-primary">등록하기</button>
            <a href="/home" class="btn btn-secondary">취소</a>
        </form:form>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
     <script>
        document.querySelector('form').addEventListener('submit', function(event) {
            var fileInput = document.querySelector('#file');
            var file = fileInput.files[0];

            if (file) {
                var fileType = file.type;
                if (fileType !== 'image/jpeg' && fileType !== 'image/png') {
                    event.preventDefault();
                    alert('JPEG 또는 PNG 형식의 파일만 업로드 가능합니다.');
                }
            }
        });
    </script>
</body>
</html>
