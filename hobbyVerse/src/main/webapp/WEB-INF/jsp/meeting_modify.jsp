<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
        min-height: 100vh;
    }

    .meeting-header {
        background: linear-gradient(135deg, #6a11cb, #2575fc);
        color: white;
        padding: 40px 20px;
        text-align: center;
        border-radius: 0 0 20px 20px;
    }

    .meeting-detail-card {
        background: white;
        border-radius: 10px;
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        margin-top: 30px;
    }

    .meeting-detail-card .content {
        padding: 30px;
    }
</style>
</head>
<body>
    <jsp:include page="/WEB-INF/jsp/navbar.jsp"/>

    <div class="meeting-header">
        <h1>모임 수정</h1>
    </div>

    <div class="container mt-5">
        <div class="row">
            <div class="col-md-8 mx-auto">
                <div class="meeting-detail-card">
                    <div class="content">
                        <form id="updateMeetingForm" enctype="multipart/form-data">
                            <div class="mb-3">
                                <label for="title" class="form-label">모임 이름</label>
                                <input type="text" class="form-control" id="title" value="${meeting.title}">
                            </div>
                            <div class="mb-3">
                                <label for="description" class="form-label">모임 설명</label>
                                <textarea class="form-control" id="info" rows="4">${meeting.info}</textarea>
                            </div>
                            <div class="mb-3">
                                <label for="date" class="form-label">모임 날짜</label>
                                <input type="date" class="form-control" id="date" value="${meeting.w_date}">
                            </div>
                            <div class="mb-3">
                                <label for="category" class="form-label">카테고리</label>
                                <select class="form-select" id="category">
                                    <option value="1" ${meeting.c_key == '1' ? 'selected' : ''}>운동</option>
                                    <option value="2" ${meeting.c_key == '2' ? 'selected' : ''}>음악</option>
                                    <option value="3" ${meeting.c_key == '3' ? 'selected' : ''}>스터디</option>
                                    <option value="4" ${meeting.c_key == '4' ? 'selected' : ''}>게임</option>
                                    <option value="5" ${meeting.c_key == '5' ? 'selected' : ''}>여행</option>
                                    <option value="6" ${meeting.c_key == '6' ? 'selected' : ''}>기타</option>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label for="price" class="form-label">참가비 (원)</label>
                                <input type="number" class="form-control" id="price" value="${meeting.price}">
                            </div>
                            <div class="mb-3">
                                <label for="imagename" class="form-label">대표 이미지 업로드</label>
                                <input type="file" class="form-control" id="imagename">
                            </div>
                            <button type="submit" class="btn btn-gradient w-100">수정하기</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        document.getElementById("updateMeetingForm").addEventListener("submit", function(e) {
            e.preventDefault();
            
            const meetingId = ${meeting.m_id};
            const title = document.getElementById("title").value;
            const info = document.getElementById("info").value;
            const m_date = document.getElementById("w_date").value; //m_date로 수정될것
            const c_key = document.getElementById("c_key").value;
            const price = document.getElementById("price").value;
            const imagename = document.getElementById("imagename");

            const formData = new FormData();
            formData.append("title", title);
            formData.append("info", info);
            formData.append("w_date", m_date);
            formData.append("c_key", c_key);
            formData.append("price", price);

            if (fileInput.files.length > 0) {
                formData.append("file", fileInput.files[0]);  // 파일 추가
            }

            fetch(`/api/meetings/update/` + meetingId, {
                method: 'PUT',
                headers: {
                    'Authorization': 'Bearer ' + localStorage.getItem('token')
                },
                body: formData
            })
            .then(response => response.json())
            .then(data => {
                alert('모임이 성공적으로 수정되었습니다.');
                window.location.href = '/meetings/' + meetingId;
            })
            .catch(error => {
                console.error('Error:', error);
                alert('모임 수정에 실패했습니다.');
            });
        });
    </script>
</body>
</html>
