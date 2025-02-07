<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
        <form action="/createGroup" method="post" enctype="multipart/form-data">
            <div class="mb-3">
                <label for="groupName" class="form-label">모임 이름</label>
                <input type="text" class="form-control" id="groupName" name="groupName" required>
            </div>

            <div class="mb-3">
                <label for="description" class="form-label">모임 설명</label>
                <textarea class="form-control" id="description" name="description" rows="3" required></textarea>
            </div>

            <div class="mb-3">
                <label for="category" class="form-label">카테고리</label>
                <select class="form-select" id="category" name="category" required>
                    <option value="">카테고리를 선택하세요</option>
                    <option value="운동">운동</option>
                    <option value="독서">독서</option>
                    <option value="여행">여행</option>
                    <option value="게임">게임</option>
                    <option value="기타">기타</option>
                </select>
            </div>

            <div class="mb-3">
                <label for="date" class="form-label">모임 날짜</label>
                <input type="date" class="form-control" id="date" name="date" required>
            </div>

            <div class="mb-3">
                <label for="groupImage" class="form-label">모임 사진 업로드</label>
                <input type="file" class="form-control" id="groupImage" name="groupImage" accept="image/*">
                <small class="text-muted">JPEG, PNG 형식의 이미지만 업로드 가능합니다.</small>
            </div>

            <button type="submit" class="btn btn-primary">등록하기</button>
            <a href="/home" class="btn btn-secondary">취소</a>
        </form>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
