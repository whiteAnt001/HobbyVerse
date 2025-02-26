<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<script type="text/javascript">
	alert("${message}");  // 컨트롤러에서 전달한 메시지를 출력
    window.location.href = "/home";  // 이후 이동할 페이지 설정
</script>
</body>
</html>