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
    // 삭제 여부 확인 
    if ("정말로 삭제하시겠습니까?") {//이거 안뜸
        alert("${message}"); // 컨트롤러에서 전달한 메시지 출력
        setTimeout(function(){ window.location.href = "/home";},200);// 확인 후 페이지 이동
    } else {
        setTimeout(function() { window.location.href = "/home";},100);}
</script>
</body>
</html>