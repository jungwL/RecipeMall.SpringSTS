<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
request.setCharacterEncoding("utf-8");
%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
				<div class="side_bar">
				<!-- user_info:회원 프로필사진,포인트,출석체크 -->
				<div class="user_info_box">
					<div class="user_profile">
						<img src="${contextPath}/resources/images/user.png" alt="user">
						<p>${user.id}님</p>
					</div>
				</div>
				<!-- mypage menu -->
				<div class="mypage_menu">
					<ul class="main_menu">
						<li><a href="${contextPath}/mypage/userInfo.do?id=${user.id}">내 정보</a></li>
						<li><a href="#">주문/배송</a>
							<ul class="sub_menu">
								<li><a href="${contextPath}/mypage/orderList.do?id=${user.id}">- 주문목록/배송조회</a></li>
								<li><a href="${contextPath}/mypage/listShippingAddr.do?id=${user.id}">- 배송지 등록</a></li>
                              <li><a href="${contextPath}/mypage/myCart.do?id=${user.id}">- 장바구니</a></li>
							</ul>
						</li>
						<li><a href="#">상품</a>
							<ul class="sub_menu">
								<li><a href="${contextPath}/mypage/productFaq.do?id=${user.id}">- 상품 문의</a></li>
								<li><a href="${contextPath}/mypage/viewReview.do?id=${user.id}">- 상품 리뷰</a></li>
							</ul>
						</li>
						<li><a href="#">글/댓글 관리</a>
							<ul class="sub_menu">
								<li><a href="${contextPath}/mypage/myPost.do?id=${user.id}">- 글 </a></li>
								<li><a href="${contextPath}/mypage/myReply.do?id=${user.id}">- 댓글</a></li>
							</ul>
						</li>
						<li><a href="">고객센터</a>
							<ul class="sub_menu">
								<li><a href="${contextPath}/mypage/faqList.do">- 자주하는 질문</a></li>
								<li><a href="${contextPath}/mypage/inqueryList.do?id=${user.id}">- 일대일 문의</a></li>
								<li><a href="${contextPath}/mypage/noticeList.do">- 공지사항</a></li>
							</ul>
						</li>
					</ul>
				</div>
			</div>