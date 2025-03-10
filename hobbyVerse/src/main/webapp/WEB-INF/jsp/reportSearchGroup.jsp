<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>신고 모임</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
    	.gradient-bg {background: linear-gradient(135deg, #6a11cb, #2575fc);} 
    	.table-hover tbody tr:hover {background-color: #f1f1f1;} 
    	.filter-bar input[type="text"] {border-radius: 20px; border: 1px solid #007bff; 
    		padding: 8px 15px; width: 100%;} 
    	.filter-bar input[type="submit"] {background-color: #007bff; color: white; border: none; 
    		padding: 8px 15px; border-radius: 20px; cursor: pointer; transition: background-color 0.3s;} 
    	.filter-bar input[type="submit"]:hover {background-color: #0056b3;}
    </style>

</head>
<body>
    <!-- 관리자 네비게이션 바 포함 -->
    <jsp:include page="/WEB-INF/jsp/adminNavber.jsp"/>

    <div class="container mt-5">
        <h2 class="text-center">🔍 검색 결과</h2>
        
        <!-- 검색 폼 -->
        <form action="/api/admin/reportsSearch" method="get">
            <div class="container mt-4">
                <div class="row">
                    <div class="col-md-6 mx-auto">
                        <div class="filter-bar d-flex justify-content-between align-items-center">
                            <input type="text" name="title" placeholder="모임 이름 검색" class="form-control"/>
                            <input type="submit" value="검색" class="btn btn-primary"/>
                        </div>
                    </div>
                </div>
            </div>
        </form>
        
        <table class="table table-hover mt-4">
    <thead class="table-dark">
        <tr>
            <th>ID</th>
            <th>모임이름</th>
            <th>주최자</th>
            <th>신고횟수</th>
            <th></th>
        </tr>
    </thead>
    <tbody>
        <c:choose>
            <c:when test="${empty reportList}">
                <tr>
                    <td colspan="4" style="text-align: center;">검색된 결과가 존재하지 않습니다.</td>
                </tr>
            </c:when>
            <c:otherwise>
                <c:forEach var="report" items="${reportList}">
		          <tr>
		          	<td>${report.report_id}</td>
		            	<c:forEach var="meet" items="${meetList}">
			                <c:if test="${meet.m_id == report.m_id}">
				                <td>${meet.title}</td>
				                <td>${meet.w_id}</td>
			                </c:if>
		                </c:forEach>
		           	<td>${report.report_count}</td>
		           	<!-- 관리 버튼들 -->
                    <td>
                     	<a href="/api/admin/reportsSearch?report_id=${report.report_id}" class="btn btn-sm btn-outline-secondary me-3">상세보기</a>
                    </td>
		          </tr>
		        </c:forEach>
            </c:otherwise>
        </c:choose>
    </tbody>
</table>

        
        <c:choose>
            <c:when test="${not empty reportList}">
                <c:set var="startPage" value="${currentPage - (currentPage - 1) % 10}" />
                <c:set var="endPage" value="${startPage + 9}" />
                <c:set var="endPage" value="${endPage > pageCount ? pageCount : endPage}" />
                
                <c:set var="pageCount" value="${reportList.size() < 10 ? 1 : pageCount}" />
                
                <div align="center">
                    <c:if test="${startPage > 1}">
                        <a href="/api/admin/reports?PAGE_NUM=${startPage - 1}">[이전]</a>
                    </c:if>
                    <c:forEach begin="${startPage}" end="${endPage}" var="i">
                        <a href="/api/admin/reports?PAGE_NUM=${i}" class="${currentPage == i ? 'active-page' : ''}">
                            ${i}
                        </a>
                    </c:forEach>
                    <c:if test="${endPage < pageCount}">
                        <a href="/api/admin/reports?PAGE_NUM=${endPage + 1}">[다음]</a>
                    </c:if>
                </div>
            </c:when>
        </c:choose>
    </div>
    
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
