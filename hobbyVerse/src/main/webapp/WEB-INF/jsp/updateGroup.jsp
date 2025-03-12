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
            padding: 20px;
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
                        <form:form method="post" action="/meetup/update.html" onsubmit="return check(this)"
                        modelAttribute="meetup" enctype="multipart/form-data">
                            <input type="hidden" name="m_id" value="${meetup.m_id}"/>
                            
                           <div class="mb-3">
                                <label for="title" class="form-label">주최자</label>
                                <input type="text" class="form-control" readonly="readonly" id="w_id" name="w_id" value="${meetup.w_id}" required/>
                            </div>
                            <div class="mb-3">
                                <label for="title" class="form-label">모임 이름</label>
                                <input type="text" class="form-control" id="title" name="title" value="${meetup.title}" required/>
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
                                <label for="m_date" class="form-label">모임 날짜</label>
                                <input type="date" class="form-control" id="m_date" name="m_date" value="${meetup.m_date}" required/>
                            </div>
                            
                            <div class="mb-3">
                                <label for="price" class="form-label">참가비</label>
                                <input type="number" class="form-control" id="price" name="price" value="${meetup.price}" required/>
                            </div>
                            
                            <div class="mb-3">
                                <label for="file" class="form-label">모임 사진</label>
                                <input type="file" class="form-control" id="file" name="file">
                                <small class="text-muted">JPEG, PNG 형식의 이미지만 업로드 가능합니다. (파일을 선택하지 않으면 기존 이미지 유지)</small>
                            </div>

							<div class="mb-3">
								<!-- 주소 검색 기능 추가 부분 -->
								<div class="mb-3">
									<label for="address" class="form-label">모임 위치</label><br /> 
									<input type="text" id="address" placeholder="장소를 입력하세요" style="width: 300px;">
									<button type="button" id="search-btn">장소 검색</button><br/>
									<small class="text-muted">건물이름, 장소로만 검색 가능합니다.(장소를 입력하지 않으면 기존 장소 유지)</small>

									<!-- 지도 표시 영역 -->
									<div id="map"
										style="width: 500px; height: 400px; margin-top: 10px;"></div>

									<!-- 위도, 경도, 주소를 저장하는 숨겨진 입력 필드 -->
									<input type="hidden" id="latitude" name="latitude" value="${ meetup.latitude }"> 
									<input type="hidden" id="longitude" name="longitude" value="${ meetup.longitude }">
									<input type="hidden" id="hidden-address" name="address" value="${ meetup.address }">
									<!-- 숨겨진 주소 필드 -->
								</div>
							<div align="center">
                                <button type="submit" class="btn btn-primary">수정하기</button>
                                <a href="/meetup/detail.html?id=${meetup.m_id}" class="btn btn-secondary">취소</a>
                            </div>
						</form:form>
                        <script type="text/javascript">
                        function check(frm){
                        	if (! confirm("정말로 수정하시겠습니까?")) return false;	
                        }
                        </script>
                        <script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=5552d703b7f4511bcd45a4d521dda281&libraries=services"></script>

<script type="text/javascript">
    function initMap() {
        var container = document.getElementById('map');
        
        // 기존 위도와 경도가 있다면 해당 값으로 설정, 없으면 기본값(서울) 설정
        var lat = document.getElementById('latitude').value || 37.5665;
        var lng = document.getElementById('longitude').value || 126.9780;
        
        var options = {
            center: new kakao.maps.LatLng(lat, lng), // 초기 중심 위치 설정
            level: 3 // 지도 확대 레벨
        };

        var map = new kakao.maps.Map(container, options);
        var marker = new kakao.maps.Marker({
            position: new kakao.maps.LatLng(lat, lng),
            map: map
        });

        var geocoder = new kakao.maps.services.Geocoder(); // 주소 변환 객체 생성

        // 지도 클릭 이벤트 추가
        kakao.maps.event.addListener(map, 'click', function(mouseEvent) {
            var latlng = mouseEvent.latLng; // 클릭한 위치의 위도, 경도
            
            // 마커를 클릭한 위치로 이동
            marker.setPosition(latlng);

            // 위도, 경도를 입력 필드에 설정
            document.getElementById('latitude').value = latlng.getLat();
            document.getElementById('longitude').value = latlng.getLng();

            // 클릭한 위치의 주소를 가져옴
            geocoder.coord2Address(latlng.getLng(), latlng.getLat(), function(result, status) {
                if (status === kakao.maps.services.Status.OK) {
                    var address = result[0].road_address ? result[0].road_address.address_name : result[0].address.address_name;
                    document.getElementById('hidden-address').value = address;
                }
            });
        });

        // 장소 검색 버튼 클릭 시 처리
        document.getElementById('search-btn').addEventListener('click', function() {
            var placeName = document.getElementById('address').value;
            if (!placeName) {
                alert('장소를 입력해주세요.');
                return;
            }

            var ps = new kakao.maps.services.Places(); // 장소 검색 객체 생성

            // 장소 검색
            ps.keywordSearch(placeName, function(results, status) {
                if (status === kakao.maps.services.Status.OK) {
                    var place = results[0];
                    var latLng = new kakao.maps.LatLng(place.y, place.x); // 검색된 장소 좌표

                    // 지도 이동 및 마커 위치 설정
                    map.setCenter(latLng);
                    marker.setPosition(latLng);

                    // 위도, 경도를 입력 필드에 설정
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

    // 페이지 로드 시 지도 초기화
    window.onload = function() {
        if (typeof kakao === 'undefined') {
            console.error("카카오 지도 API가 로드되지 않았습니다.");
        } else {
            initMap(); // 지도 초기화 함수 호출
        }
    };
</script>



					</div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
