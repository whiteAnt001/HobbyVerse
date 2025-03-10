<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>모임 상세 | HobbyMatch</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body { background: #f4f4f4; color: #333; min-height: 100vh; }
        .gradient-bg { background: linear-gradient(135deg, #6a11cb, #2575fc); }
        .meeting-header { background: linear-gradient(135deg, #6a11cb, #2575fc); color: white; padding: 20px 10px; text-align: center; border-radius: 0 0 15px 15px; }
        .meeting-detail-card { background: white; border-radius: 8px; box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1); margin-top: 20px; }
        .meeting-detail-card img { width: 100%; height: 300px; object-fit: cover; border-radius: 8px 8px 0 0; }
        .meeting-detail-card .content { padding: 20px; }
        .meeting-detail-card h3 { font-size: 1.4rem; }
        .meeting-detail-card p { font-size: 0.9rem; color: #555; }
        .participants-list { background: #fff; padding: 10px; margin-top: 15px; border-radius: 8px; box-shadow: 0 1px 5px rgba(0, 0, 0, 0.1); }
        .participants-list h5 { font-size: 1rem; margin-bottom: 8px; }
        .participant { display: flex; justify-content: space-between; align-items: center; margin-bottom: 8px; }
        .participant img { width: 30px; height: 30px; border-radius: 50%; margin-right: 8px; }
        .btn-gradient { background: linear-gradient(135deg, #6a11cb, #2575fc); color: white; padding: 8px 12px; font-size: 0.9rem; }
        .btn-sm { padding: 5px 8px; font-size: 0.8rem; }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/jsp/adminNavber.jsp"/>
    <div class="container mt-4">
        <h3 class="text-center">🚨 신고된 모임 상세보기</h3>
        <div class="row">
            <div class="col-md-8 mx-auto">
                <div class="meeting-detail-card">
                    <div class="content">
                    <form:form action="" modelAttribute="report" enctype="multipart/form-data">
                        <h5>모임제목</h5><br/>
						<p>title</p>						
						<h5>신고자</h5>
						<p>email</p>
						<h5>신고날짜</h5>
						<p>📅report_date</p>
						<h5>신고 횟수</h5>
						<p>report_count</p>
						<h5>신고사유</h5>
						<p>reason</p>
					</form:form>
                    </div>
                </div>
            </div>
        </div>
        <br/>
        <div class="d-flex justify-content-center">
            <a href="/api/admin/reports" class="btn btn-sm btn-outline-secondary me-3">이전으로</a>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
