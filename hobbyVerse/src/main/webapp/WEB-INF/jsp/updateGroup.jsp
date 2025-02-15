<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>모임 수정 | HobbyMatch</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<style>
    body {
        background: #f4f4f4;
        color: #333;
        min-height: 80vh;
    }
    .meeting-header {
        background: linear-gradient(135deg, #6a11cb, #2575fc);
        color: white;
        padding: 20px 20px;
        text-align: center;
        border-radius: 0 0 20px 20px;
    }
    .meeting-detail-card {
        background: white;
        border-radius: 10px;
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        margin-bottom: 30px;
    }
    .meeting-detail-card .content {
        padding: 30px;
        margin-top: 20px;
    }
</style>
</head>
<body>

    <div class="meeting-header">
        <jsp:include page="/WEB-INF/jsp/navbar.jsp"/>
        <h1>모임 수정</h1>
    </div>

    <div class="container mt-5">
        <div class="row">
            <div class="col-md-8 mx-auto">
                <div class="meeting-detail-card">
                    <div class="content">
                         <form:form id="updateGroup" method="post" action="/meetup/update.html" modelAttribute="meetup" enctype="multipart/form-data">
						    <input type="hidden" name="m_id" value="${meetup.m_id}">
						    
						    <div class="mb-3">
						        <label for="title" class="form-label">모임 이름</label>
						        <input type="text" class="form-control" id="title" name="title" value="${meetup.title}" required>
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
                                <label for="info" class="form-label">모임 설명</label>
                                <textarea class="form-control" id="info" name="info" rows="4" required>${meetup.info}</textarea>
                            </div>
                            <div class="mb-3">
                                <label for="w_date" class="form-label">모임 날짜</label>
                                <input type="date" class="form-control" id="w_date" name="w_date" value="${meetup.w_date}" required>
                            </div>
                            <div class="mb-3">
                                <label for="price" class="form-label">참가비</label>
                                <input type="number" class="form-control" id="price" name="price" value="${meetup.price}" required>
                            </div>
                            <div class="mb-3">
                                <label for="file" class="form-label">모임 사진</label>
                               <input type="file" class="form-control" id="file" name="file" required>
                                <small class="text-muted">JPEG, PNG 형식의 이미지만 업로드 가능합니다.</small>
                            </div>
                            <div align="center">
                                <button type="submit" class="btn btn-primary">수정하기</button>
                                <a href="/index" class="btn btn-secondary">취소</a>
                            </div>
                        </form:form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
