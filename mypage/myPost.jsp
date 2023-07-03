<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
request.setCharacterEncoding("utf-8");
%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>RecipeMall-마이페이지</title>
<script src="https://kit.fontawesome.com/54880b83c5.js" crossorigin="anonymous"></script>
<script src="${contextPath}/views/js/jquery-3.6.4.min.js"></script>
<script src="${contextPath}/views/js/jquery-ui.min.js"></script>
<script src="${contextPath}/views/js/common.js"></script>
<script src="${contextPath}/views/mypage/js/mypage.js"></script>
<link rel="stylesheet" href="${contextPath}/views/mypage/css/mypage.css">
<link rel="stylesheet" href="${contextPath}/views/mypage/css/mypage_common.css">
<link rel="stylesheet" href="${contextPath}/views/mypage/css/mypage_4.css">
<link rel="shortcut icon" href="${contextPath}/views/image/smalllogo.png" />
</head>
<body>
	<!--[s]건너뛰기 링크-->
	<a id="skipNav" href="">본문 바로가기</a>
	<!--[e]건너뛰기 링크-->
	<!-- [s]Header 영역 -->
	<!-- [s]Header 영역 -->
	<jsp:include page="/WEB-INF/views/fix/mypageHeader.jsp"/>
	<!-- [s]Header 영역 -->
	<!-- [s]Header 영역 -->
	<!-- content_mypage_s -->
	<div id="main_content" class="mypage_box">
		<div id="mypage">
			<h2 class="mypage_title">
				<a href="${contextPath}/main/mypage.do">마이페이지</a>
			</h2>
			<!-- sidebar -->
			<jsp:include page="/WEB-INF/views/fix/mypageSidebar.jsp"/>
			<!-- sidebar -->
			<!-- mypage_content -->
			<div class="mypage_content">
				<h3 class="menu_title">글 관리</h3>
				<div class="post">
					<div class="post_select">
						<ul class="post_s">
							<li>
								<div class="post_class">
									<ul class="post_menu">
										<li class="board_all menu_li"><a href="#">전체</a></li>
										<li class="board_recipe menu_li active"><a class="active_a" href="#">레시피</a></li>
										<li class="board_free menu_li"><a href="#">자유게시판</a></li>
									</ul>
								</div>
							</li>
							<li>
								<div class="post_date_s post_h">
									<ul>
										<li><a href="#">처음</a></li>
										<li><a href="#">최신</a></li>
									</ul>
								</div>
							</li>
							<li>
								<div class="post_cnt post_h">
									<select name="" id="">
										<option value="">10개</option>
										<option value="">30개</option>
									</select>
								</div>
							</li>
							<li><button class="post_view_btn">보기</button></li>
						</ul>
					</div>
					<div class="my_post_list">
						<table class="post_list_tb">
							<thead>
								<tr>
									<th>번호</th>
									<th>게시판</th>
									<th>제목</th>
									<th>작성일</th>
									<th>삭제</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="free" items="${posts.free}" varStatus="status">
									<tr>
										<td class="post_n">${status.count}</td>
										<td class="post_board">
											자유게시판
										</td>
										<td class="post_title"><a href="${contextPath}/free/view.do?boardNo=${free.boardNo}">${free.boardName}</a></td>
										<td class="post_date">${free.writeDate}</td>
										<td class="post_chk">삭제</td>
									</tr>
								</c:forEach>
								<c:forEach var="recipe" items="${posts.recipe}" varStatus="status">
									<tr>
										<td class="post_n">${status.count}</td>
										<td class="post_board">
											레시피
										</td>
										<td class="post_title"><a href="${contextPath}/recipe/specific.do?id=${log_id}&recipeNo=${recipe.recipeNo}">${recipe.recipeTitle}</a></td>
										<td class="post_date">${recipe.writeDate}</td>
										<td class="post_chk">삭제</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
					<button class="update_btn">수정</button>
					<button class="delete_btn">삭제</button>
					<div class="paging_box">
						<ul>
							<li><a href="#">&lt;</a></li>
							<li><a href="#">1</a></li>
							<li><a href="#">2</a></li>
							<li><a href="#">&gt;</a></li>
						</ul>
					</div>
				</div>
			</div>
			<!-- mypage_content -->
		</div>
	</div>
	<!-- content_mypage_e -->

	<!-- footer_s -->
	<jsp:include page="/WEB-INF/views/fix/footer.jsp"/>
	<!-- footer_e -->
</body>
</html>