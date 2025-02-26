<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>추천하기</title>
</head>
<body>
   <script type="text/javascript">
        window.onload = function() {
            alert("${message}");  // 메시지 출력
            window.location.href = "${redirectUrl}";  // 해당 URL로 이동
        };
    </script>
</body>
</html>
