<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="UTF-8">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>취미/스터디 매칭 플랫폼</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

<style>
    /* 기본 스타일 */
    body {
        font-family: Arial, sans-serif;
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

    .image {
        width: 100%;
        height: 100%;
        object-fit: cover;
        border-radius: 10px;
    }

    .arrow-btn {
        width: 50px;
        height: 50px;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 24px;
        background-color: white;
        border: 1px solid #ccc;
        cursor: pointer;
    }

    .arrow-btn:hover {
        background-color: #f8f9fa;
    }

    .card {
        width: 220px;
        border-radius: 10px;
        overflow: hidden;
    }

    .card-body {
        padding: 1rem;
    }

    .card-title {
        font-size: 1.1rem;
        font-weight: bold;
    }

    .card-text {
        font-size: 0.875rem;
    }

    .d-flex {
        flex-wrap: nowrap;
        overflow-x: auto;
    }

    .container {
        max-width: 100%;
        padding: 0 15px;
    }

    /* 섹션 스타일 */
    .section {
        margin-bottom: 40px;
    }

    .section-header {
        font-size: 1.5rem;
        font-weight: bold;
        margin-bottom: 20px;
    }

    .ad-banner {
        background-color: #f4f4f4;
        padding: 15px;
        text-align: center;
        margin-bottom: 30px;
    }

</style>
</head>
<body>

    <!-- 헤더 -->
    <jsp:include page="/WEB-INF/jsp/navbar.jsp" />

   <section class="ad-banner">
    <div class="ad-slider">
        <!-- 광고 내용 -->
        <div class="ad" id="ad1">광고 1: 특별 이벤트 1</div>
        <div class="ad" id="ad2">광고 2: 특별 이벤트 2</div>
        <div class="ad" id="ad3">광고 3: 특별 이벤트 3</div>
        <div class="ad" id="ad4">광고 4: 특별 이벤트 4</div>
    </div>

    <div class="ad-controls d-flex justify-content-center align-items-center">
        <!-- 왼쪽 화살표 -->
        <button class="arrow-btn" onclick="changeAd(-1)">
            <i class="fas fa-chevron-left"></i>
        </button>

        <!-- 작은 원들 -->
        <div class="dots">
            <span class="dot" onclick="setCurrentAd(0)"></span>
            <span class="dot" onclick="setCurrentAd(1)"></span>
            <span class="dot" onclick="setCurrentAd(2)"></span>
            <span class="dot" onclick="setCurrentAd(3)"></span>
        </div>

        <!-- 오른쪽 화살표 -->
        <button class="arrow-btn" onclick="changeAd(1)">
            <i class="fas fa-chevron-right"></i>
        </button>
    </div>
</section>


	<!-- 인기 있는 이벤트 섹션 -->
    <section class="section">
        <h3 class="section-header text-center">지금 가장 인기있는 모임 TOP8</h3>
        <div class="d-flex align-items-center justify-content-between">
            <!-- 왼쪽 버튼 -->
            <button class="arrow-btn me-3"
                <c:if test="${currentPage <= 1}">disabled style="opacity: 0.5;"</c:if>
                onclick="location.href='../home?PAGE_NUM=${currentPage - 1}'">
                <i class="fas fa-chevron-left"></i>
            </button>

            <div class="d-flex flex-nowrap overflow-auto" style="gap: 20px;">
                <c:forEach var="meet" items="${meetList}">
                    <div class="card shadow-sm">
                        <img src="${pageContext.request.contextPath}/upload/${meet.imagename}" alt="" class="image">
                        <div class="card-body text-center">
                            <h5 class="card-title">${meet.title}</h5>
                            <p class="card-text">진행일: ${meet.m_date}</p>
                            <p class="card-text">위치: ${meet.address }</p>
							<div class="d-flex justify-content-between">
								<p class="card-text">추천 ${meet.recommend}</p>
								<p class="card-text">
									<i class="fas fa-eye"></i> ${meet.views}
								</p>
							</div>
							<a href="/meetup/detail.html?id=${meet.m_id}" class="btn btn-primary btn-sm">자세히 보기</a>
                        </div>
                    </div>
                </c:forEach>
            </div>

            <!-- 오른쪽 버튼 -->
            <button class="arrow-btn ms-3"
                <c:if test="${currentPage >= pageCount}">disabled style="opacity: 0.5;"</c:if>
                onclick="location.href='../home?PAGE_NUM=${currentPage + 1}'">
                <i class="fas fa-chevron-right"></i>
            </button>
        </div>
    </section>

    <!-- 인기 게시글 섹션 -->
    <section class="section popular-posts">
        <h3 class="section-header text-center">인기 게시글</h3>
        <div class="row">
            <!-- 게시글 목록 예시 -->
            <div class="col-md-4">
                <div class="card shadow-sm">
                    <img src="your-image-url" alt="게시글 이미지" class="image">
                    <div class="card-body">
                        <h5 class="card-title">게시글 제목</h5>
                        <p class="card-text">게시글 간단 설명</p>
                        <a href="#" class="btn btn-secondary btn-sm">자세히 보기</a>
                    </div>
                </div>
            </div>
            <!-- 추가 게시글 카드들 -->
        </div>
    </section>

    <jsp:include page="/WEB-INF/jsp/footer.jsp" />

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
    let currentAdIndex = 0;
    const ads = [
        '특별 이벤트 1',
        '특별 이벤트 2',
        '특별 이벤트 3',
        // 추가 광고 내용
    ];
    const adBanner = document.querySelector('.ad-banner p');

    function changeAd() {
        currentAdIndex = (currentAdIndex + 1) % ads.length;
        adBanner.textContent = ads[currentAdIndex];
    }

    setInterval(changeAd, 5000);  // 5초마다 광고 변경
    let currentAdIndex = 0;
    const ads = document.querySelectorAll('.ad');  // 광고 요소들을 가져옵니다.
    const dots = document.querySelectorAll('.dot');  // 작은 원들
    const adSlider = document.querySelector('.ad-slider');

    function changeAd(direction) {
        currentAdIndex += direction;

        if (currentAdIndex < 0) {
            currentAdIndex = ads.length - 1;  // 마지막 광고로 돌아감
        } else if (currentAdIndex >= ads.length) {
            currentAdIndex = 0;  // 첫 번째 광고로 돌아감
        }

        updateAdDisplay();
    }

    function setCurrentAd(index) {
        currentAdIndex = index;
        updateAdDisplay();
    }

    function updateAdDisplay() {
        // 광고 슬라이더의 위치를 변경
        adSlider.style.transform = `translateX(-${currentAdIndex * 100}%)`;

        // 작은 원의 활성화 상태 변경
        dots.forEach((dot, index) => {
            if (index === currentAdIndex) {
                dot.classList.add('active');
            } else {
                dot.classList.remove('active');
            }
        });
    }

    // 초기 광고 표시 설정
    updateAdDisplay();

    // 5초마다 자동으로 광고 변경
    setInterval(() => changeAd(1), 5000);

    
</script>
</body>
</html>
