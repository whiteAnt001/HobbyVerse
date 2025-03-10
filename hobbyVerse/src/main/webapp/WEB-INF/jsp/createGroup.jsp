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
        .form-label {font-size: 14px;}
        
        .form-labeldate{font-size: 13px;}

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
        <form:form action="/meetup/register.html" method="post" modelAttribute="meetup" enctype="multipart/form-data" onsubmit="return validatePrice()">
            <div class="mb-3">
                <label for="title" class="form-label">모임 이름</label>
                <form:input path="title" class="form-control" id="title" name="title" required="true"/>
            </div>

            <div class="mb-3">
                <label for="w_id" class="form-label">작성자 <strong>${loginUser.name }</strong></label>
            </div>

            <div class="mb-3">
                <label for="info" class="form-label">모임 설명</label><br/>
                <form:textarea path="info" class="form-control" id="info" name="info" rows="3" required="true"></form:textarea>
            </div>
			<div class="mb-3">
				<!-- 주소 검색 기능 추가 부분 -->
				<div class="mb-3">
					<label for="address" class="form-label">모임 위치</label><br /> <input
						type="text" id="address" placeholder="장소를 입력하세요"
						style="width: 300px;">
					<button type="button" id="search-btn">장소 검색</button>

					<!-- 지도 표시 영역 -->
					<div id="map"
						style="width: 500px; height: 400px; margin-top: 10px;"></div>

					<!-- 위도, 경도, 주소를 저장하는 숨겨진 입력 필드 -->
					<input type="hidden" id="latitude" name="latitude"> <input
						type="hidden" id="longitude" name="longitude"> <input
						type="hidden" id="hidden-address" name="address">
					<!-- 숨겨진 주소 필드 -->
				</div>

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
                <label for="m_date" class="form-label">모임 일정</label>
                <form:input path="m_date" type="date" class="form-control" id="m_date" name="m_date" required="true"/>
            </div>

            <div class="mb-3">
                <label for="file" class="form-label">모임 사진 업로드</label>
                <form:input path="file" type="file" class="form-control" id="file" name="file" accept="image/*" required="true"/>
                <small class="text-muted">JPEG, PNG 형식의 이미지만 업로드 가능합니다.</small>
            </div>

            <div class="mb-2">
                <label for="w_dateString" class="form-label">현재 시간: <span id="clock"></span></label>
                <input type="hidden" name="w_dateString" id="w_dateString" />
            </div>

            <div align="center">
                <button type="submit" class="btn btn-primary">등록하기</button>
                <a href="/home" class="btn btn-secondary">취소</a>
            </div>
        </form:form>
    </div>
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
    <script type="text/javascript">
	    function workingClock(){
	        var today = new Date();
	        var year = today.getFullYear();
	        var month = today.getMonth() + 1;
	        if(month < 10) month = "0" + month;
	        var date = today.getDate();
	        if(date < 10) date = "0" + date;
	        var hour = today.getHours();
	        if(hour < 10) hour = "0" + hour;
	        var min = today.getMinutes();
	        if(min < 10) min = "0" + min;
	        var sec = today.getSeconds();
	        if(sec < 10) sec = "0" + sec;
	        
	        var formattedDate = year + "-" + month + "-" + date + " " + hour + ":" + min + ":" + sec;
	        document.getElementById("clock").innerHTML = formattedDate;
			document.getElementById("w_dateString").value = formattedDate;
	    }
	    window.onload = function() {
	        workingClock();
	        setInterval(workingClock, 1000);
	    };
	
	    // 가격 입력값 검증
	    function validatePrice() {
	        var price = document.getElementById("price").value;
	        if (isNaN(price) || price < 0) {
	            alert("참가비는 숫자로 입력하세요.");
	            return false; // 폼 제출 막기
	        }
	        return true; // 폼 제출 허용
	    }
    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	<script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=5552d703b7f4511bcd45a4d521dda281&libraries=services"></script>
	<script type="text/javascript">
    // 카카오 지도 API 로드 후 실행될 함수
    function initMap() {
        var container = document.getElementById('map');
        var options = {
            center: new kakao.maps.LatLng(37.5665, 126.9780), // 기본 서울 위치
            level: 3 // 지도 레벨 설정
        };

        var map = new kakao.maps.Map(container, options);
        var marker = new kakao.maps.Marker({
            map: map
        });

        // 장소 검색 버튼 클릭 시 처리
        document.getElementById('search-btn').addEventListener('click', function() {
            var placeName = document.getElementById('address').value;
            if (!placeName) {
                alert('장소를 입력해주세요.');
                return;
            }

            var ps = new kakao.maps.services.Places(); // 장소 검색 서비스 객체 생성

            // 장소 검색
            ps.keywordSearch(placeName, function(results, status) {
                if (status === kakao.maps.services.Status.OK) {
                    // 검색된 첫 번째 장소에 대한 정보를 가져옵니다.
                    var place = results[0];
                    var latLng = new kakao.maps.LatLng(place.y, place.x); // 검색된 장소의 좌표

                    // 지도 이동
                    map.setCenter(latLng);

                    // 마커 위치 설정
                    marker.setPosition(latLng);

                    // 위도, 경도를 폼에 자동으로 입력
                    document.getElementById('latitude').value = place.y;
                    document.getElementById('longitude').value = place.x;

                    // 주소를 숨겨진 필드에 저장
                    document.getElementById('hidden-address').value = place.address_name;

                } else {
                    alert('장소를 찾을 수 없습니다. 다시 시도해 주세요.');
                }
            });
        });
    }

    // 페이지 로드 후 지도 초기화
    window.onload = initMap;
</script>
</body>
</html>