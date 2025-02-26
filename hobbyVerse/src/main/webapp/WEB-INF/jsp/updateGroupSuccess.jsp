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
    if (confirm("정말로 수정하시겠습니까?")) {
        alert("${message}"); // 컨트롤러에서 전달한 메시지 출력
        setTimeout(function(){ window.location.href = "/home";},200);// 확인 후 페이지 이동
    } else {
    	alert("수정되지 않았습니다.")
    	setTimeout(function(){ window.location.href = "/home";},100); // 취소 후 index.jsp로 이동
    }
</script>
</body>
</html>