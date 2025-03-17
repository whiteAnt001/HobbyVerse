<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- 푸터 내용 -->
<footer class="footer bg-dark text-white py-2">
    <div class="footer-container">
        <div class="row">
            <div class="col-md-3">
                <h5>사이트 링크</h5>
                <ul class="list-unstyled">
                    <li><a href="#" class="text-white">홈</a></li>
                    <li><a href="#" class="text-white">사이트 소개</a></li>
                    <li><a href="#" class="text-white">문의하기</a></li>
                    <li><a href="#" class="text-white">이용 약관</a></li>
                    <li><a href="#" class="text-white">개인정보 보호</a></li>
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
/* 푸터 스타일 */
footer {
    padding: 0;
    background-color: #343a40;
    color: white;
}

.footer-container {
    max-width: 1200px; /* 푸터가 너무 넓게 퍼지지 않도록 최대 너비 설정 */
    margin: 0 auto; /* 중앙 정렬 */
    padding: 15px 0; /* 푸터 안쪽 여백 */
}

.footer a {
    text-decoration: none;
}

.footer a:hover {
    text-decoration: underline;
}

.list-unstyled {
    font-size: 13px;
}

#copywrite {
    font-size: 13px;
}

footer .container {
    width: 100%;
}
</style>
