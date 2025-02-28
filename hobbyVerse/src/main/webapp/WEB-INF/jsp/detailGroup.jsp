<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>모임 상세 | HobbyMatch</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body {background: #f4f4f4; color: #333; min-height: 100vh;}
        .gradient-bg {background: linear-gradient(135deg, #6a11cb, #2575fc);}
        .meeting-header {background: linear-gradient(135deg, #6a11cb, #2575fc); color: white; 
        			padding: 20px 10px; text-align: center; border-radius: 0 0 15px 15px;}
        .meeting-header h1 {font-size: 1.5rem;}
        .meeting-header h4 {font-size: 1rem;}
        .meeting-detail-card {background: white; border-radius: 8px; box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1); margin-top: 20px;}
        .meeting-detail-card img {width: 100%; height: 300px; object-fit: cover; border-radius: 8px 8px 0 0;}
        .meeting-detail-card .content {padding: 20px;}
 	    .meeting-detail-card h3 {font-size: 1.4rem;}
        .meeting-detail-card p {font-size: 0.9rem; color: #555;}
        .participants-list { background: #fff; padding: 10px; margin-top: 15px;
            border-radius: 8px; box-shadow: 0 1px 5px rgba(0, 0, 0, 0.1);}
        .participants-list h5 {font-size: 1rem; margin-bottom: 8px;}
        .participant {display: flex; justify-content: space-between; align-items: center; margin-bottom: 8px;}
        .participant img {width: 30px; height: 30px; border-radius: 50%; margin-right: 8px;}
        .btn-gradient { background: linear-gradient(135deg, #6a11cb, #2575fc); color: white; padding: 8px 12px; font-size: 0.9rem;}
        .btn-sm {padding: 5px 8px; font-size: 0.8rem;}

    </style>
</head>
<body>

    <jsp:include page="/WEB-INF/jsp/navbar.jsp"/>

    <div class="meeting-header">
        <h1>${meetup.title }</h1>
        <h5>${meetup.w_id }</h5>
    </div>

    <div class="container mt-4">
        <div class="row">
            <div class="col-md-8 mx-auto">
                <div class="meeting-detail-card">
                    <img src="${pageContext.request.contextPath}/upload/${meetup.imagename }" alt="">
                    <div class="content">
                    	<h5>카테고리</h5>
						<p>${meetup.category_name}</p>
                        <h5>모임 설명</h5>
                        <p>${meetup.info }</p>
                        <h5>모임 일정</h5>
                        <p>📅 ${meetup.m_date }</p>
                        <h5>참가비</h5>
                        <p>💰 ${meetup.price }원</p>
                        <h5>조회수</h5>
                  		<p>👁️ ${meetup.views}</p> <!-- 조회수 표시 추가 -->
                        
						<div align="center" class="d-flex gap-2 align-items-stretch">
						    <!-- 참가신청 버튼 (길게) -->
						    <form style="flex-grow: 1;">
						        <input type="submit" value="참가신청" name="ENTER" class="btn btn-gradient w-100 h-100" onsubmit="return check()">
						    </form>
						    
						    <!-- 추천(좋아요) 버튼 (작게) -->
						    <form action="/meetup/recommend.html" class="d-flex align-items-stretch">
						        <input type="hidden" name="m_id" value="${meetup.m_id}">
						        <button type="submit" class="btn btn-outline-primary btn-sm h-100">👍추천</button>
						    </form>
						</div>
	          		</div>
                </div>
                <script type="text/javascript">
                	function check() {
                		if(! confirm("정말로 신청하시겠습니까?")) return false;
                	}
                </script>

                <div class="participants-list">
                    <h5>참가자 목록 (3명)</h5>
                    <div class="participant">
                        <div class="d-flex align-items-center">
                            <img src="https://randomuser.me/api/portraits/men/1.jpg" alt="참가자 1">
                            <p>홍길동</p>
                        </div>
                        <button class="btn btn-sm btn-outline-secondary">삭제</button>
                    </div>
          	 	</div>
          	  <br/>
          	<div class="d-flex justify-content-center">
		    <a href="/home" class="btn btn-sm btn-outline-secondary me-3">이전으로</a>
		
		    <c:if test="${loginUser != null && loginUser.email == meetup.w_id || user.role == 'ROLE_ADMIN'}">
		        <form action="/meetup/modify.html" class="d-flex">
		            <input type="hidden" name="m_id" value="${meetup.m_id}">
		            <input type="submit" value="수정" name="BTN" class="btn btn-sm btn-outline-secondary me-2"> <!-- 수정 버튼 간격 설정 -->
		        </form>
		        <form action="/meetup/modify.html" onsubmit="return check()">
					<input type="hidden" name="m_id" value="${meetup.m_id}">
				    <input type="submit" value="삭제" name="BTN" class="btn btn-sm btn-outline-secondary">
			    </form>
		    </c:if>
		    <script type="text/javascript">
		        function check(frm){
		        	if( ! confirm("정말로 삭제하시겠습니까?")) return false;
		        }
		        </script>
		    </div>
		</div>
    </div>
</div><br/>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
