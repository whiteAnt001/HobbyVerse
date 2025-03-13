<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<footer class="footer bg-dark text-white py-2">
    <div class="container">
        <div class="row">
            <div class="col-md-3">
                <h5>사이트 링크</h5>
                <ul class="list-unstyled">
                    <li><a href="/home" class="text-white">홈</a></li>
                    <li><a href="/about" class="text-white">회사 소개</a></li>
                    <li><a href="/contact" class="text-white">문의하기</a></li>
                    <li><a href="/terms" class="text-white">이용 약관</a></li>
                    <li><a href="/privacy" class="text-white">개인정보 보호</a></li>
                </ul>
            </div>
            <div class="col-md-3">
                <h5>소셜 미디어</h5>
                <ul class="list-unstyled">
                    <li><a href="https://www.facebook.com" target="_blank" class="text-white">Facebook</a></li>
                    <li><a href="https://twitter.com" target="_blank" class="text-white">Twitter</a></li>
                    <li><a href="https://www.instagram.com" target="_blank" class="text-white">Instagram</a></li>
                </ul>
            </div>
        </div>
        <div class="text-center" id="copywrite">
            <p>&copy; HobbyVerse | 모든 권리 보유</p>
        </div>
    </div>
</footer>

<!-- 푸터 CSS 스타일 -->
<style>
footer {margin: 0; padding: 0;}
	.container{margin-left: 20px; margin-top: 15px; }
    .footer a {
        text-decoration: none;
    }

    .footer a:hover {
        text-decoration: underline;
    }
    .list-unstyled {font-size: 13px;}
    #copywrite{ font-size: 13px;}
</style>
