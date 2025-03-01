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
    if (confirm("정말로 삭제하시겠습니까?")) {
        // "확인"을 클릭했을 경우
        alert("${message}"); // 컨트롤러에서 전달한 메시지 출력
        setTimeout(function() {
            window.location.href = "/home"; // 확인 후 페이지 이동
        }, 200);
    } else {
        // "취소"를 클릭했을 경우
        window.location.href = "/meetup/detail.html?id=${meet.m_id }"; // 상세보기 페이지로 돌아가기
    }
</script>
</body>
</html>