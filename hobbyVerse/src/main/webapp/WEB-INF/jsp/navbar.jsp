<%@ page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<style>
/* 페이지 전체 여백 없애기 */
body, html {
	margin: 0;
	padding: 0;
	width: 100%;
	overflow-x: hidden; /* 수평 스크롤 방지 */
}
/* 네비게이션 바 배경 색상 */
.gradient-bg {
    background: linear-gradient(to right, #1e3c72, #2a5298); /* 네이비 → 블루 */
}

/* 버튼 스타일 */
.gradient-btn {
    background: linear-gradient(to right, #2a5298, #1e3c72); /* 블루 → 네이비 */
    color: white;
    border: none;
    transition: background 0.3s ease-in-out;
}

/* 버튼 호버 시 색상 */
.gradient-btn:hover {
    background: linear-gradient(to right, #1e3c72, #2a5298);
    color: white;
}

/* 네비게이션 링크 스타일 */
.navbar-nav .nav-link {
    color: white !important;
    transition: color 0.3s;
}

/* 네비게이션 링크 호버 */
.navbar-nav .nav-link:hover {
    color: #ffcc00 !important; /* 따뜻한 골드 색상 */
}
</style>
<nav class="navbar navbar-expand-lg navbar-dark gradient-bg">
	<div class="container-fluid">
		<sec:authorize access="!hasRole('ROLE_ADMIN')">
			<a class="navbar-brand" href="/home">HobbyVerse</a>
		</sec:authorize>
		<sec:authorize access="hasRole('ROLE_ADMIN')">
			<a class="navbar-brand" href="/home">HobbyVerse 관리자</a>
		</sec:authorize>

		<!-- 검색창 -->
		<div class="d-flex w-auto justify-content-center mx-2">
			<form action="/meetup/search.html" method="post" class="w-auto">
				<div class="input-group">
					<input type="text" name="title"
						class="form-control border-0 rounded-start"
						placeholder="모임을 검색하세요..."
						style="font-size: 0.875rem; padding: 0.5rem; height: 30px; width: 250px;">
					<button class="btn gradient-btn rounded-end"
						style="padding: 0.3rem 1rem; font-size: 0.875rem; height: 30px;">검색</button>
				</div>
			</form>
		</div>

		<!-- 토글 버튼 -->
		<button class="navbar-toggler" type="button" data-bs-toggle="collapse"
			data-bs-target="#navbarNav">
			<span class="navbar-toggler-icon"></span>
		</button>

		<!-- 네비게이션 메뉴 -->
		<div class="collapse navbar-collapse" id="navbarNav">
			<ul class="navbar-nav ms-auto me-2">
				<li class="nav-item"><a class="nav-link" href="/home">홈</a></li>
				<li class="nav-item"><a class="nav-link" href="/boards">게시판</a></li>

				<!-- 카테고리 드롭다운 -->
				<li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle" href="/category/key"
					id="categoryDropdown" role="button" aria-expanded="false">카테고리</a>
					<ul class="dropdown-menu" aria-labelledby="categoryDropdown">
						<li><a class="dropdown-item" href="/category/moveSport">스포츠</a></li>
						<li><a class="dropdown-item" href="/category/moveMusic">음악</a></li>
						<li><a class="dropdown-item" href="/category/moveStudy">스터디</a></li>
						<li><a class="dropdown-item" href="/category/moveGame">게임</a></li>
						<li><a class="dropdown-item" href="/category/moveTravel">여행</a></li>
						<li><a class="dropdown-item" href="/category/moveEtc">기타</a></li>
					</ul></li>

				<li class="nav-item"><a class="nav-link" href="/inquiries">문의사항</a></li>
				<li class="nav-item"><a class="nav-link" href="/notices">공지사항</a></li>

				<!-- 로그인된 경우 -->
				<sec:authorize access="isAuthenticated()">
					<li class="nav-item"><a class="nav-link" href="/meetup/createGroup.html">모임 등록하기</a></li>
					<sec:authorize access="hasRole('ADMIN')">
					<li class="nav-item dropdown">
                	<a class="nav-link dropdown-toggle" href="/api/admin/dashboard" id="userDropdown" role="button" aria-expanded="false">관리자페이지</a>
                    	<ul class="dropdown-menu" aria-labelledby="userDropdown">
                        	<li><a class="dropdown-item" href="/api/admin/users">회원관리</a></li>
                            <li><a class="dropdown-item" href="/api/admin/meetings">모임관리</a></li>
                            <li><a class="dropdown-item" href="/api/admin/inquiries">문의사항 관리</a></li>
                            <li><a class="dropdown-item" href="/api/admin/reports">신고항목 관리</a></li>
                            <li>
                            	<form action="/logout" method="post" class="d-inline">
                                	<button type="submit" class="dropdown-item">로그아웃</button>
                                </form>
                            </li>
                        </ul>
               		</li>
               		</sec:authorize>
				</sec:authorize>
				
				 <!-- 로그인되지 않은 경우 -->
                 <sec:authorize access="isAnonymous()">
                     <li class="nav-item"><a class="nav-link" href="/login">로그인</a></li>
                     <li class="nav-item"><a class="nav-link btn gradient-btn" href="/signup">회원가입</a></li>
                 </sec:authorize>

				<!-- 마이페이지 드롭다운 -->
				<sec:authorize access="hasRole('ROLE_USER')">
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href="#" id="userDropdown"
						role="button" aria-expanded="false">${user.name}님</a>
						<ul class="dropdown-menu dropdown-menu-end" aria-labelledby="userDropdown">
							<li><a class="dropdown-item" href="/myPage">마이페이지</a></li>
							<li>
								<form action="/logout" method="post" class="d-inline">
									<button type="submit" class="dropdown-item">로그아웃</button>
								</form>
							</li>
						</ul></li>
				</sec:authorize>
			</ul>
		</div>
	</div>
</nav>


<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
        $(document).ready(function(){
            $('.dropdown').mouseenter(function() {
                $(this).addClass('show');
                $(this).find('.dropdown-menu').addClass('show');
            }).mouseleave(function() {
                $(this).removeClass('show');
                $(this).find('.dropdown-menu').removeClass('show');
            });
        });
</script>