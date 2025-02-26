<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수정 확인</title>
</head>
<body>
<script type="text/javascript">
	setTimeout(function(){ 
		alert("수정이 완료되었습니다.");
		location.href="/meetup/detail.html?id=${meetup.m_id}";
	},100);
</script>
</body>
</html>
