<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
		<a class="navbar-brand" href="/api/admin/dashboard">HobbyVerse 관리자</a>
		<button class="navbar-toggler" type="button" data-bs-toggle="collapse"
			data-bs-target="#adminNavbar">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="adminNavbar">
			<ul class="navbar-nav ms-auto">
				<li class="nav-item"><a class="nav-link" href="/home">홈</a></li>
				<li class="nav-item"><a class="nav-link" href="/boards">게시판</a></li>
				<li class="nav-item"><a class="nav-link" href="/category/key">카테고리</a></li>
				<li class="nav-item"><a class="nav-link" href="/api/admin/dashboard">대시보드</a></li>
				
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
