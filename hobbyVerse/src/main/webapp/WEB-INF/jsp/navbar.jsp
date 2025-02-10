<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<nav class="navbar navbar-expand-lg navbar-dark gradient-bg">
	<div class="container">
		<a class="navbar-brand" href="/home">HobbyVerse</a>
		<button class="navbar-toggler" type="button" data-bs-toggle="collapse"
			data-bs-target="#navbarNav">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarNav">
			<ul class="navbar-nav ms-auto">
				<li class="nav-item"><a class="nav-link" href="/home">홈</a></li>
				<li class="nav-item"><a class="nav-link" href="#">카테고리</a></li>

				<!-- 로그인된 경우 -->
				<c:if test="${user != null}">
					<li class="nav-item"><a class="nav-link btn btn-primary"
						href="/meetup/createGroup.html">모임 등록하기</a></li>
				</c:if>

				<c:if test="${user != null}">
					<li class="nav-item"><a class="nav-link" href="/myPage">${user.name}님</a></li>
					<li class="nav-item">
						<form action="/logout" method="post">
							<button type="submit" class="btn btn-danger">로그아웃</button>
						</form>
					</li>
				</c:if>

				<!-- 로그인되지 않은 경우 -->
				<c:if test="${user == null}">
					<li class="nav-item"><a class="nav-link" href="/login">로그인</a></li>
					<li class="nav-item"><a class="nav-link btn gradient-btn"
						href="/signup">회원가입</a></li>
				</c:if>
			</ul>
		</div>
	</div>
</nav>
