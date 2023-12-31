<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>RecipeMall-관리자</title>
<script src="https://kit.fontawesome.com/fd4a2f2bab.js" crossorigin="anonymous"></script>
<script src="${contextPath}/resources/js/jquery-3.6.4.min.js"></script>
<script src="${contextPath}/resources/js/jquery-ui.min.js"></script>
<!-- <script src="js/admin.js"></script> -->
<link rel="stylesheet" href="${contextPath}/resources/css/admin.css">
<link rel="stylesheet" href="${contextPath}/resources/css/select.css">
<title>Insert title here</title>
</head>
<body>
	<div id="box">
	<c:choose>
    	<c:when test="${isAdmLogon == true}">
        <jsp:include page="/WEB-INF/views/fix/adminSide.jsp"/>
    	</c:when>
    	<c:otherwise>
    		<jsp:forward page="/WEB-INF/views/admin/adminLogin.jsp"/>
    	</c:otherwise>
    </c:choose>
    </div>
</body>
</html>