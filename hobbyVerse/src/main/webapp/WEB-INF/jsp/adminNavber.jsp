<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- 스타일 추가 -->
<style>
.gradient-bg {
	background: linear-gradient(135deg, #6a11cb, #2575fc);
}

.navbar-brand {
	font-weight: bold;
	font-size: 1.3rem;
}

.nav-link {
	font-size: 1.1rem;
	transition: 0.3s;
}

.nav-link:hover {
	color: #ffeb3b !important;
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
				<li class="nav-item"><a class="nav-link" href="/api/admin/users">회원 관리</a></li>
				<li class="nav-item"><a class="nav-link" href="/api/admin/meetings">모임 관리</a></li>
				<li class="nav-item">
					<form action="/logout" method="post">
						<button type="submit" class="btn btn-danger">로그아웃</button>
					</form>
				</li>
			</ul>
		</div>
	</div>
</nav>
