<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>삭제 확인</title>
</head>
<body>
<script type="text/javascript">
	setTimeout(function(){
		alert("삭제가 완료되었습니다.");
		location.href="/api/admin/reports";
	},100);
</script>
</body>
</html>
