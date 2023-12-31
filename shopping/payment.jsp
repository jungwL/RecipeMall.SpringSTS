<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
   isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<c:set var="userList" value="${paymentMap.userList}"/>
<c:set var="cartList" value="${paymentMap.cartList}"/>
<%
   request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>recipeMall</title>
<script src="https://kit.fontawesome.com/54880b83c5.js" crossorigin="anonymous"></script>
    <script src="${contextPath}/views/js/jquery-3.6.4.min.js"></script>
    <script src="${contextPath}/views/js/jquery-ui.min.js"></script>
    <script src="${contextPath}/views/shopping/js/payment.js"></script>
    <script src="${contextPath}/views/shopping/js/address_change.js"></script>
    <script src="${contextPath}/views/shopping/js/kakaoPay.js"></script>
    <link rel="stylesheet" href="${contextPath}/views/shopping/css/shopping_common.css">
    <link rel="stylesheet" href="${contextPath}/views/shopping/css/payment.css">
    <link rel="shortcut icon" href="${contextPath}/views/images/smalllogo.png" />
    <!-- <script type="text/javascript" src="${contextPath}/views/js/doro.js"></script>-->
     <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script src="${contextPath}/views/js/login.js"></script>
    <script src="${contextPath}/views/js/naver_login.js"></script>
    <script src="${contextPath}/views/js/kakao_login.js"></script>
    <link rel="stylesheet" href="${contextPath}/views/css/login.css">
    <script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js" charset="utf-8"></script>
    <script src="https://t1.kakaocdn.net/kakao_js_sdk/2.1.0/kakao.min.js"
    integrity="sha384-dpu02ieKC6NUeKFoGMOKz6102CLEWi9+5RQjWSV0ikYSFFd8M3Wp2reIcquJOemx" crossorigin="anonymous"></script>
    <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
</head>
<body>
<!--[s]전체 컨텐츠 영역  -->
    <!--[s]건너뛰기 링크-->
    <a id="skipNav" href="">본문 바로가기</a>
    <!--[e]건너뛰기 링크-->


    <!-- [s]광고배너 영역 -->
    <div class="adbanner">
        <p><a href="#">지금 가입하면 무료배송!<button class="banner_btn" onclick="close_div()"><i
                        class="fa-solid fa-x"></i></button></a></p>
    </div>
    <!--[e]광고배너 영역 -->


    <!-- [s]Header 영역 -->
    <jsp:include page="/WEB-INF/views/fix/shopHeader.jsp"/>
    <!-- [e]Header 영역 -->
    
    <!-- [s]메인 컨텐츠 영역  -->
    <div id="main_content">
        <div class="payment_content">
            <div>
                <!-- [s] 주문자 영역 -->
                <div class="orderer_area">
                    <h2>주문자 정보</h2>
                    <ul>
                        <li>
                            <label for="orderer_name">이름</label>
                            <input type="text" id="orderer_name" name="orderer_name" value="${userList[0].name}" required>
                        </li>
                        <li>
                            <label for="orderer_phone">연락처</label>
                            <input type="text" id="orderer_phone" name="orderer_phone" value="${userList[0].phone}" required>
                        </li>
                    </ul>
                </div>
                <!-- [e] 주문자 영역 -->

                <!-- [s] 배송지 영역 -->
                <form action="#">
                <div class="shipping_address">
                
                    <h2><i class="fa-solid fa-location-dot"></i> 배송지</h2>
                    <button onclick="sample4_execDaumPostcode()">배송지 변경</button>              
                    <div class="reciver">
                        <span>${userList[0].name}</span>
                        <span>${userList[0].phone}</span>
                    </div>
                    <div class="safe_number">
                        <input type="checkbox" id="safe_phone" name="safe_phone">
                        <label for="safe_phone">안심번호 사용하기</label>
                    </div>             
                                        
                    <div id="inputContainer">
                       <input id="original_address" type="text" readonly value="${userList[0].userAddr}"><input type="hidden" id="noUse" required> 
                       <span id="guide" style="color:#999;"></span>
                       <input id="original_address2" type="text" value="${userList[0].userAddr2}" placeholder="상세 주소를 입력해주세요." required>
                    </div>
                    

                    <select name="deilvery_message" id="deilvery_message">
                        <option value="배송시 요청사항을 선택해 주세요.">배송시 요청사항을 선택해 주세요.</option>
                        <option value="직접 수령하겠습니다.">직접 수령하겠습니다.</option>
                        <option value="배송 전 연락바랍니다.">배송 전 연락바랍니다.</option>
                        <option value="부재 시 경비실에 맡겨주세요.">부재 시 경비실에 맡겨주세요.</option>
                        <option value="부재 시 문 앞에 놓아주세요.">부재 시 문 앞에 놓아주세요.</option>
                        <option value="부재 시 택배함에 넣어주세요.">부재 시 택배함에 넣어주세요.</option>
                        <option value="6">직접 입력</option>
                    </select>
                    <div id="custom_delivery_message_container"></div>
                </div>
                </form>
                <!-- [e] 배송지 영역 -->
                <!-- [s] 결제하기 영역 -->
                <div class="payment_area">
                    <h2>결제하기</h2>
                    <div class="product_amout">
                        <span>상품 금액</span>
                        <span id="product_amount_value">${paymentMap.priceAll}원</span>
                    </div>
                    <div class="use_point">
                        <span>배송비</span>
                        <span id ="delivery_amount_value">2,500원</span>
                    </div>
                    <div class="payment_amout">
                        <span>결제 금액</span>
                        <span id="payment_amount_value">${paymentMap.paymentAll}원</span>
                    </div>
                    <div class="payment_type">
                        <ul>
                            <li><button id="kakaoPayg">카카오페이</button></li>
                            <li><button id="accountTransfer">계좌이체</button></li>
                        </ul>
                    </div>
                    <div class="transfer_number payment_method">
                        <select name="transfer" id="transfer">
                            <option value="sinhan">신한은행 100-000-123456</option>
                            <option value="kakaobank">카카오뱅크 1234-1234-105454</option>
                        </select>
                        <input type="text" name="transfer_name" class="transfer_name" placeholder="입금자명을 입력해주세요.">
                    </div>
                    <div class="order_agree">
                        <span>주문자 동의</span>
                        <div class="agree_check">
                            <ul>
                                <li>
                                    <input type="checkbox" id="all_agree" name="all_agree">
                                    <label for="all_agree">전체 동의하기</label>
                                </li>
                                <li>
                                    <input type="checkbox" id="agree1" name="agree1" class="input_check">
                                    <label for="agree1">[필수]개인정보 수집 및 이용 동의</label> <span class="show_agree">자세히</span>
                                    <div class="agree_text">
                                        <p>RECIPE-MALL은 아래의 목적으로 개인정보를 수집 및 이용하며, 회원의 개인정보를 안전하게 처리하는데 최선을 다하고 있습니다. 아래의 내용을 확인 후 동의하여 주시기 바랍니다.</p>
                                        <table border="1">
                                            <th>유형</th>
                                            <th>구분</th>
                                            <th>수집 및 이용 목적</th>
                                            <th>수집 및 이용 항목</th>
                                            <th>보유 및 이용 기간</th>
                                            <tr>
                                                <td rowspan="2">필수</td>
                                                <td>상품구매</td>
                                                <td rowspan="2">
                                                    <ul>
                                                        <li>서비스 및 상품 제공에 관한 계약 이행 및 요금정산</li>
                                                        <li>고객 상담 및 불만, 민원 사무 처리</li>
                                                        <li>판매자와 구매자간 거래의 원활한 진행, 본인 의사의 확인</li>
                                                        <li>상품∙서비스 이용 실적 정보 통계∙분석</li>
                                                        <li>상품∙서비스 개선 및 추천, 불법∙부정 이용 방지</li>
                                                    </ul>
                                                </td>
                                                <td>
                                                    구매자 정보(이름, 이메일, 휴대폰번호, 전화번호, 공동현관 비밀번호), 수령자 정보(이름, 전화번호, 휴대폰 번호, 주소)
                                                </td>
                                                <td rowspan="2">
                                                    <ul>
                                                        <li>탈퇴 요청 5일 후 지체 없이 파기합니다.</li>
                                                        <li>내부 방침에 의해 서비스 부정 이용 기록은 부정 가입 및 이용 방지를 위하여 회원 탈퇴 시점으로부터 1년간 보관 후 파기합니다.</li>
                                                        <li>단,관계 법령에 따라 일정 기간 보존해야 하는 경우 해당 기간 보관 후 파기합니다.</li>
                                                    </ul>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>현금환불요청</td>
                                                <td>환불계좌 정보(은행, 계좌번호, 예금주)</td>
                                            </tr>
                                        </table>
                                    </div>
                                </li>
                                <li>
                                    <input type="checkbox" id="agree2" name="agree2" class="input_check">
                                    <label for="agree1">[필수]개인정보 제 3자 제공 동의 </label><span class="show_agree">자세히</span>
                                    <div class="agree_text">
                                        <table border="1">
                                            <th>유형</th>
                                            <th>제공 받는 자</th>
                                            <th>제공 목적</th>
                                            <th>제공 항목</th>
                                            <th>보유 및 이용 기간</th>
                                            <tr>
                                                <td>필수</td>
                                                <td>RECIPE-MALL</td>
                                                <td>
                                                    <ul>
                                                        <li> 주문 상품 및 서비스의 제공, 계약 이행</li>
                                                        <li>고객 상담 및 불만, 민원 사무 처리</li>
                                                    </ul>
                                                </td>
                                                <td>구매자 정보(아이디, 이름, 전화번호, 휴대폰 번호, 이메일, 상품 구매정보) 수령자 정보(이름, 전화번호, 휴대폰 번호, 배송지 주소)</td>
                                                <td>
                                                    <ul>
                                                        <li>상품 구매/배송/반품 서비스 처리 완료 후 180일간 보관 후 파기</li>
                                                        <li>단,관계 법령에 따라 일정 기간 보관해야 하는 항목은 해당 기간 보관 후 파기합니다.</li>
                                                    </ul>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </li>
                                <li>
                                    <input type="checkbox" id="agree3" name="agree3" class="input_check">
                                    <label for="agree1">[필수]전자결제대행 이용 동의 </label><span class="show_agree">자세히</span>
                                    <div class="agree_text">
                                        카카오페이 전자금융거래 이용약관
                                        <Strong>제1조</Strong> (목적)
                                        본 약관은 주식회사 카카오페이(이하 ‘회사’라 합니다)가 제공하는 전자지급결제대행서비스, 선불전자지급수단의 발행 및 관리서비스, 전자고지결제서비스(이하 통칭하여 ‘전자금융거래서비스’라 합니다)를 회원이 이용함에 있어, 회사와 회원 간 권리, 의무 및 회원의 이용절차 등에 관한 사항을 규정하는 것을 그 목적으로 합니다.<br>
                                        <strong>제2조</strong> (정의)
                                        ① 본 약관에서 정한 용어의 정의는 아래와 같습니다.
                                        1. ‘전자금융거래’라 함은 회사가 전자적 장치를 통하여 전자금융업무를 제공하고, 회원이 회사의 종사자와 직접 대면하거나 의사소통을 하지 아니하고 자동화된 방식으로 이를 이용하는 거래를 말합니다.
                                        2. ‘전자지급수단’이라 함은 선불전자지급수단, 신용카드 등 전자금융거래법 제2조 제11호에서 정하는 전자적 방법에 따른 지급수단을 말합니다.
                                        3. ‘전자지급거래’라 함은 자금을 주는 자(이하 ‘지급인’이라 합니다)가 회사로 하여금 전자지급수단을 이용하여 자금을 받는 자(이하 ‘수취인’이라 합니다)에게 자금을 이동하게 하는 전자금융거래를 말합니다.
                                        4. ‘전자적 장치’라 함은 전자금융거래정보를 전자적 방법으로 전송하거나 처리하는데 이용되는 장치로서 현금자동지급기, 자동입출금기, 지급용단말기, 컴퓨터, 전화기 그 밖에 전자적 방법으로 정보를 전송하거나 처리하는 장치를 말합니다.
                                        5. ‘접근매체’라 함은 전자금융거래에 있어서 거래지시를 하거나 회원 및 거래내용의 진실성과 정확성을 확보하기 위하여 사용되는 수단 또는 정보로서 전자식 카드 및 이에 준하는 전자적 정보(신용카드번호를 포함합니다), 전자서명법 상의 전자서명생성정보 및 인증서, 금융기관 또는 전자금융업자에 등록된 회원번호, 회원의 생체정보, 이상의 수단이나 정보를 사용하는데 필요한 비밀번호 등 전자금융거래법 제2조 제10호에서 정하고 있는 것을 말합니다.
                                        6. ‘전자금융거래서비스’라 함은 회사가 회원에게 제공하는 제4조 기재의 서비스를 말합니다.
                                        7. ‘회원’이라 함은 본 약관 제2장과 제3장과 제4장 에서 달리 정한 경우를 제외하고는 본 약관에 동의하고 본 약관에 따라 회사가 제공하는 전자금융거래서비스를 이용하는 이용자를 말합니다.
                                        8. ‘거래지시’라 함은 회원이 본 약관에 따라 회사에게 전자금융거래의 처리를 지시하는 것을 말합니다.
                                        9. ‘오류’라 함은 회원의 고의 또는 과실 없이 전자금융거래가 전자금융거래계약 또는 회원의 거래지시에 따라 이행되지 아니한 경우를 말합니다.
                                        ② 본 조 및 본 약관의 다른 조항에서 정의한 것을 제외하고는 전자금융거래법 등 관련 법령에 정한 바에 따릅니다.<br>
                                        <strong>제3조</strong> (약관의 명시, 설명 및 변경)
                                        ① 회사는 회원이 전자금융거래를 하기 전에 본 약관을 개별 서비스에 게시하고 본 약관의 중요한 내용을 확인할 수 있도록 합니다.
                                        ② 회사는 회원의 요청이 있는 경우 전자문서의 전송(전자우편을 이용한 전송을 포함합니다), 모사전송, 우편 또는 직접교부의 방식에 의하여 본 약관의 사본을 회원에게 교부합니다.
                                        ③ 회사가 본 약관을 변경하는 때에는 그 시행일 1월 전에 변경되는 약관을 금융거래정보 입력화면 또는 개별 서비스의 공지사항 게시판 등에 게시하고 회원에게 통지합니다. 다만, 법령의 개정으로 인하여 긴급하게 약관을 변경한 때에는 변경된 약관을 홈페이지에 1개월 이상 게시하고 회원에게 전자우편 등을 통하여 사후 통지합니다.
                                        ④ 회사는 제3항의 공지나 통지를 할 경우 “회원이 변경에 동의하지 아니한 경우 공지나 통지를 받은 날로부터 30일 이내에 계약을 해지할 수 있으며, 계약해지의 의사표시를 하지 아니한 경우에는 변경에 동의한 것으로 본다.”라는 취지의 내용을 공지하거나 통지합니다.
                                        ⑤ 회원이 제4항의 공지나 통지를 받은 날로부터 30일 이내에 계약해지의 의사표시를 하지 아니한 경우에는 변경에 동의한 것으로 봅니다.<br>
                                        <strong>제4조</strong> (전자금융거래서비스의 종류)
                                        ① 전자금융거래서비스는 다음 각 호의 개별 서비스로 구성됩니다.
                                        1. 전자지급결제대행서비스
                                        2. 선불전자지급수단 발행 및 관리서비스
                                        3. 전자고지결제서비스
                                        ② 회사는 필요시 회원에게 사전 고지하고 전자금융거래서비스를 추가하거나 변경할 수 있습니다.<br>
                                        <strong>제5조</strong> (서비스 이용 시간)
                                        ① 회사는 회원에게 연중무휴 1일 24시간 전자금융거래서비스를 제공함을 원칙으로 합니다. 다만, 금융회사 기타 결제수단 발행업자의 사정에 따라 달리 정할 수 있습니다.
                                        ② 회사는 정보통신설비의 보수, 점검 기타 기술상의 필요나 금융회사 기타 결제수단 발행업자의 사정에 의하여 전자금융거래서비스 중단이 불가피한 경우, 전자금융거래서비스 중단 3일 전까지 게시 가능한 전자적 수단을 통하여 전자금융거래서비스 중단 사실을 게시한 후 전자금융거래서비스를 일시 중단할 수 있습니다. 다만, 시스템 장애복구, 긴급한 프로그램 보수, 외부요인 등 불가피한 경우에는 사전 게시 없이 전자금융거래서비스를 중단할 수 있습니다.<br>
                                        <strong>제6조</strong>(거래내용의 확인)
                                        ① 회사는 개별 서비스 내 회원 정보 조회 화면을 통하여 회원의 거래내용(회원의 오류정정 요구사실 및 처리 결과에 관한 사항을 포함합니다)을 확인할 수 있도록 하며, 회원이 거래내용에 대해 서면교부를 요청하는 경우에는 요청을 받은 날로부터 2주 이내에 모사전송, 우편 또는 직접 교부의 방법으로 거래내용에 관한 서면을 교부합니다.
                                        ② 회사는 제1항에 따른 회원의 거래내용 서면교부 요청을 받은 경우 전자적 장치의 운영장애, 그 밖의 이유로 거래내용을 제공할 수 없는 때에는 즉시 회원에게 전자문서 전송(전자우편을 이용한 전송을 포함한다)의 방법으로 그러한 사유를 알려야 하며, 전자적 장치의 운영장애 등의 사유로 거래내용을 제공할 수 없는 기간은 제1항의 거래내용에 관한 서면의 교부기간에 산입하지 아니합니다.
                                        ③ 제1항의 대상이되는 거래내용 중 대상기간이 5년인 것은 다음 각호와 같습니다.
                                        1. 거래계좌의 명칭 또는 번호
                                        2. 전자금융거래의 종류 및 금액
                                        3. 전자금융거래상대방을 나타내는 정보
                                        4. 전자금융거래일시
                                        5. 전자적 장치의 종류 및 전자적 장치를 식별할 수 있는 정보
                                        6. 회사가 전자금융거래의 대가로 받은 수수료
                                        7. 회원의 출금 동의에 관한 사항
                                        8. 해당 전자금융거래와 관련한 전자적 장치의 접속기록
                                        9. 전자금융거래의 신청 및 조건의 변경에 관한 사항
                                        10. 건당 거래금액이 1만원을 초과하는 전자금융거래에 관한 기록
                                        ④ 제1항의 대상이 되는 거래내용 중 대상기간이 1년인 것은 다음 각 호와 같습니다.
                                        1. 건당 거래금액이 1만원 이하인 전자금융거래에 관한 기록
                                        2. 전자지급수단의 이용과 관련된 거래승인에 관한 기록
                                        3. 회원의 오류정정 유구사실 및 처리결과에 관한 사항
                                        4. 기타 금융위원회가 고시로 정한 사항
                                        ⑤ 회원이 제1항에서 정한 서면교부를 요청하고자 할 경우 다음의 주소 및 전화번호로 요청할 수 있습니다.
                                        - 주소 : 경기도 성남시 분당구 판교역로 166 카카오판교아지트 B동 15층 카카오페이
                                        - 사이트 주소 : https://www.kakaopay.com/
                                        - 전화번호 : 1644-7405<br>
                                        <strong>제7조</strong> (거래지시의 철회)
                                        ① 회원이 회사의 전자금융거래서비스를 이용하여 전자지급거래를 한 경우, 회원은 지급의 효력이 발생하기 전까지 본 약관에서 정한 바에 따라 제6조 제5항에 기재된 주소, 전화번호, 전자우편주소를 이용한 우편, 전화연락, 전자문서 전송의 방법으로 또는 개별 서비스 내 철회에 의한 방법으로 거래지시를 철회할 수 있습니다. 단, 각 서비스 별 거래지시 철회의 효력 발생시기는 본 약관 제17조, 제27조, 제 31조에서 정한 바에 따릅니다.
                                        ② 회원은 전자지급의 효력이 발생한 경우에 전자상거래등에서의 소비자보호에 관한 법률 등 관련 법령상 청약의 철회의 방법에 따라 결제대금을 반환 받을 수 있습니다.<br>
                                        <strong>제8조</strong> (오류의 정정)
                                        ① 회원은 전자금융거래서비스를 이용함에 있어 오류가 있음을 안 때에는 회사에 대해 그 정정을 요구할 수 있습니다.
                                        ② 회사는 전항의 규정에 따른 오류의 정정요구를 받은 때 또는 스스로 전자금융거래에 오류가 있음을 안 때에는 이를 즉시 조사하여 처리한 후 정정요구를 받은 날 또는 오류가 있음을 안 날부터 2주 이내에 그 결과를 회원에게 알려 드립니다.<br>
                                        <strong>제9조</strong>(전자금융거래 기록의 생성 및 보존)
                                        ① 회사는 회원이 이용한 전자금융거래의 내용을 추적, 검색하거나 그 내용에 오류가 발생한 경우에 이를 확인하거나 정정할 수 있는 기록을 생성하여 보존합니다.
                                        ② 제1항의 규정에 따라 회사가 보존하여야 하는 기록의 종류 및 보존방법은 제6조 제3항 및 제4항에 따릅니다.<br>
                                        <strong>제10조</strong> (개인정보 보호)
                                        ① 회사는 전자금융거래서비스를 제공함에 있어서 취득한 회원의 인적사항, 회원의 계좌, 접근매체 및 전자금융거래의 내용과 실적에 관한 정보 또는 자료를 금융실명법 등 법령에 의하거나 회원의 동의를 얻지 아니하고 제3자에게 제공, 누설하거나 업무 상 목적 외에 사용하지 아니합니다.
                                        ② 회사는 회원이 안전하게 전자금융거래서비스를 이용할 수 있도록 회원의 개인정보보호를 위하여 개인정보취급방침을 운용합니다. 회사의 개인정보취급방침은 회사의 홈페이지 또는 개별 서비스에 링크된 화면에서 확인할 수 있습니다.<br>
                                        <strong>제11조</strong> (회사의 책임)
                                        ① 회사는 다음 각호의 사고로 인하여 회원에게 손해가 발생한 경우에는 그 손해를 배상할 책임을 부담합니다.
                                        1. 접근매체의 위조나 변조로 발생한 사고
                                        2. 계약체결 또는 거래지시의 전자적 전송이나 처리과정에서 발생한 사고
                                        3. 전자금융거래를 위한 전자적 장치 또는 정보통신망 이용촉진 및 정보보호 등에 관한 법률 제2조 제1항 제1호에 따른 정보통신망에 침입하여 거짓이나 그 밖의 부정한 방법으로 획득한 접근매체의 이용으로 발생한 사고
                                        ② 회사는 제1항에도 불구하고 다음 각호의 경우에는 그 책임의 전부 또는 일부를 회원이 부담하게 할 수 있습니다.
                                        1. 회원이 접근매체를 제3자에게 대여하거나 그 사용을 위임한 경우 또는 양도나 담보의 목적으로 제공한 경우
                                        2. 제3자가 권한 없이 회원의 접근매체를 이용하여 전자금융거래를 할 수 있음을 알았거나 쉽게 알 수 있었음에도 불구하고 접근매체를 누설하거나 노출 또는 방치한 경우
                                        3. 법인(중소기업기본법제2조 제2항에 의한 소기업을 제외한다)인 회원에게 손해가 발생한 경우로서 회사가 사고를 방지하기 위하여 보안절차를 수립하고 이를 철저히 준수하는 등 합리적으로 요구되는 충분한 주의의무를 다한 경우
                                        ③ 회사는 회원으로부터 거래지시가 있음에도 불구하고 천재지변, 회사의 귀책사유가 없는 기타의 불가항력적인 사유로 처리 불가능하거나 지연된 경우로서 회원에게 처리 불가능 또는 지연사유를 통지한 경우(금융기관 또는 결제수단발행업자나 통신판업자가 통지한 경우를 포함합니다)에는 회원에 대해 이로 인한 책임을 부담하지 않습니다.<br>
                                        <strong>제12조</strong> (분쟁처리 절차)
                                        ① 회원은 회사 고객센터 또는 이메일등의 전자적 방법을 통하여 전자금융거래와 관련한 의견 및 불만의 제기, 손해배상의 청구 등의 분쟁처리를 요구할 수 있습니다.
                                        카카오페이 고객센터 : 전화 1644-7405
                                        인터넷접수 : https://www.kakaopay.com/qna/consumer/complain
                                        ② 회원이 회사에 대하여 분쟁처리를 신청한 경우 회사는 15일 이내에 이에 대한 조사 또는 처리 결과를 회원에게 안내 합니다.
                                        ③ 회원은 회사의 분쟁처리결과에 대하여 이의가 있을 경우 금융위원회의 설치 등에 관한 법률 제51조의 규정에 따른 금융감독원의 금융분쟁조정위원회나 소비자기본법 제60조 제1항의 규정에 따른 한국소비자원의 소비자분쟁조정위원회에 회사의 전자금융거래서비스의 이용과 관련한 분쟁조정을 신청할 수 있습니다.<br>
                                        <strong>제13조</strong> (회사의 안전성 확보 의무)
                                        회사는 전자금융거래가 안전하게 처리될 수 있도록 전자금융거래의 종류 별로 전자적 전송이나 처리를 위한 인력, 시설, 전자적 장치 등의 정보기술부문 및 전자금융업무에 관하여 금융위원회가 정하는 기준을 준수합니다.<br>
                                        <strong>제14조</strong> (약관 외 준칙)
                                        ① 회사와 회원 사이에 개별적으로 합의한 사항이 본 약관에 정한 사항과 다를 때에는 그 합의사항을 본 약관에 우선하여 적용합니다.
                                        ② 전자금융거래에 관하여 본 약관에 정하지 않은 사항은 개별약관이 정하는 바에 따릅니다.
                                        ③ 본 약관과 전자금융거래에 관한 개별약관에 정하지 아니한 사항(용어의 정의 포함)에 대하여는 다른 합의사항이 없으면 전자금융거래법, 여신전문금융업법, 전자상거래 등에서의 소비자 보호에 관한 법률 등 관계 법령에서 정한 바에 따릅니다.<br>
                                        <strong>제15조</strong> (관할)
                                        회사와 회원 간에 발생한 분쟁에 관한 관할은 민사소송법에서 정한 바에 따릅니다.<br>
                                        <strong>제16조</strong>(정의)
                                        본 장에서 정하는 용어의 정의는 아래와 같습니다.
                                        ① ‘전자지급결제대행 서비스’라 함은 전자적 방법으로 재화 또는 용역(이하 '재화 등'이라고 합니다)의 구매에 있어서 지급결제 정보를 송신하거나 수신하는 것 또는 그 대가의 정산을 대행하거나 매개하는 서비스를 말합니다.
                                        ② ‘회원’이라 함은 본 약관에 동의하고 회사가 제공하는 전자지급결제대행 서비스를 이용하는 자를 말합니다.<br>
                                        <strong>제17조</strong>(거래지시의 철회)
                                        ① 회원이 전자지급결제대행 서비스를 이용한 경우 회원은 거래지시된 금액의 정보에 대하여 수취인의 계좌가 개설되어 있는 금융기관 또는 회사의 계좌의 원장에의 입금기록 또는 전자적 장치에의 입력이 끝나기 전까지 거래지시를 철회할 수 있습니다.
                                        ② 회사는 회원의 거래지시의 철회에 따라 지급거래가 이루어지지 않은 경우 수령한 자금을 회원에게 반환하여야 합니다.<br>
                                        <strong>제18조</strong>(이용금액의 한도)
                                        회사의 정책 및 결제업체(이동통신사,카드사 등)의 기준에 따라 회원의 결제수단 별 월 누적 결제액 및 결제한도가 제한될 수 있습니다.<br>
                                        <strong>제19조</strong>(접근매체의 관리)
                                        ① 회사는 전자지급결제대행 서비스 제공 시 접근매체를 선정하여 회원의 신원, 권한 및 거래지시의 내용 등을 확인합니다.
                                        ② 회원은 접근매체를 사용함에 있어서 다른 법률에 특별한 규정이 없는 한 다음 각 호의 행위를 하여서는 아니 됩니다.
                                        1. 접근매체를 양도하거나 양수하는 행위
                                        2. 접근매체를 대여하거나 사용을 위임하는 행위
                                        3. 접근매체를 질권 기타 담보 목적으로 하는 행위
                                        4. 1호부터 3호까지의 행위를 알선하는 행위
                                        ③ 회원은 자신의 접근매체를 제3자에게 누설 또는 노출하거나 방치하여서는 안되며, 접근매체의 도용이나 위조 또는 변조를 방지하기 위하여 충분한 주의를 기울여야 합니다.
                                        ④ 회사는 회원으로부터 접근매체의 분실이나 도난 등의 통지를 받은 때에는 그 때부터 제3자가 그 접근매체를 사용함으로 인하여 회원에게 발생한 손해를 배상할 책임이 있습니다.<br>
                                        <strong>제20조</strong>(정의)
                                        본 장에서 사용하는 용어의 정의는 다음과 같습니다.
                                        ① ‘선불전자지급수단’이라 함은 회사가 운영하는 웹사이트 및 제휴사 서비스 등에서 재화 또는 용역(이하 ‘재화 등’이라고 합니다)을 구매할 수 있는 카카오페이머니 등과 같이 회사가 발행 당시 미리 회원에게 공지한 전자금융거래법 상 선불전자지급수단을 말합니다.
                                        ② ‘충전’이라 함은 선불전자지급수단의 일정액을 확보하기 위해 회사가 지정한 지불수단을 통해 선불전자지급수단을 구매하거나, 회사 또는 회사가 지정한 제3자의 서비스 등(이하 ‘서비스 등’이라 합니다)에서의 활동을 통해 선불전자지급수단을 적립 받는 것을 말합니다.
                                        ③ ‘회원’이라 함은 본 약관에 동의하고 판매자로부터 재화 등을 구매하고 선불전자지급수단을 결제수단으로 하여 그 대가를 지급하는 자를 말합니다.
                                        ④ ‘판매자’라 함은 선불전자지급수단에 의한 거래에 있어서 회원에게 재화 등을 판매하는 자를 말합니다.<br>
                                        <strong>제21조</strong>(접근매체의 관리)
                                        ① 회사는 회원으로부터 접근매체의 분실 또는 도난 등의 통지를 받기 전에 발생하는 선불전자지급수단에 저장된 금액에 대한 손해에 대하여는 책임지지 않습니다.
                                        ② 제2장 결제대행서비스 제19조 제1항 내지 제4항은 본 장에 준용합니다.<br>
                                        <strong>제22조</strong> (거래의 정지)
                                        ① 회사는 회원이 아래 각 호의 사유에 해당하는 경우 해당 회원에게 전자우편 또는 기타 유효한 수단을 통해 통보하고, 회원 자격을 박탈하거나 선불전자지급수단의 사용을 일시적으로 제한할 수 있습니다.
                                        1. 회원 가입시 등록한 개인정보의 전부 또는 일부가 허위임이 밝혀지는 경우
                                        2. 타인의 명의나 개인정보를 도용하여 회원 가입 후 선불전자지급수단을 이용하는 경우
                                        3. 타인의 결제정보 등을 도용하거나 부정한 행위로 거래를 하는 경우
                                        4. 회원의 접근매체를 매매하거나 양도하는 경우
                                        5. 결제수단을 제공하는 사업자가 지정한 방식으로 이용요금을 납부하지 않고 장기 연체하는 경우
                                        6. 다른 회원의 선불전자지급수단 사용을 방해하거나, 회사의 선불전자지급수단 제공에 지장을 초래하는 경우
                                        7. 회사가 정한 기간 내에 사용제한 사유를 해소하지 못한 경우
                                        8. 기타 선불전자지급수단 관련한 법령을 위반하는 경우
                                        ② 제1항에 해당하는 회원은 해당 사유를 해소한 이후 회사의 승낙에 따라 선불전자지급수단을 다시 사용할 수 있습니다.<br>
                                        <strong>제23조 </strong>(선불전자지급수단의 충전)
                                        ① 회원은 계좌출금 , 기타 회사가 정하는 지불수단으로 선불전자지급수단을 구매하거나, 서비스 등에서의 활동으로 회사 또는 회사의 제휴사로부터 적립 받아 선불전자지급수단을 충전할 수 있습니다.
                                        ② 회사가 지정한 지불 수단을 통한 선불전자지급수단 구매는 제1항에서 규정하는 지불 수단별로 지정된 금액으로 충전을 할 수 있으며, 지불 수단에 따라 자체 제한금액이 있을 수 있습니다.<br>
                                        <strong>제24조 </strong>(선불전자지급수단의 이용)
                                        ① 회원은 회사가 정한 기한 및 이용방법에 따라 선불전자지급수단을 이용할 수 있으며, 회사는 그 구체적인 사항을 본 약관 또는 선불전자지급수단 관련 서비스 페이지를 통해 공지합니다.
                                        ② 회원은 서비스 등에서 재화 등을 구매할 때 선불전자지급수단을 지불 수단으로 사용할 수 있습니다.
                                        ③ 선불전자지급수단은 재화 등의 구매완료 시점에 즉시 차감됩니다.
                                        ④ 회원이 선불전자지급수단을 사용하는 경우 서비스 등에서 적립 받은 무상의 선불전자지급수단(이하 ‘적립선불’이라고 합니다), 회원이 구매한 선불전자지급수단(이하 ‘구매선불’이라고 합니다)의 순서로 차감합니다.
                                        ⑤ 회원이 선불전자지급수단을 사용한 재화 등의 구매를 취소하는 경우 회사는 재화 등 구매시 사용한 선불전자지급수단을 재충전하는 것을 원칙으로 합니다.<br>
                                        <strong>제25조 </strong>(선불전자지급수단의 유효기간)
                                        ① 개별 선불전자지급수단을 마지막으로 이용한 날 로부터 10년이 경과하는 동안 해당 선불전자지급수단을 한번도 적립하거나 사용하지 않은 경우 회원이 충전한 해당 선불전자지급수단은 자동소멸됩니다.
                                        ② 회사는 전항에 따른 선불전자지급수단의 자동소멸 전에 회원에게 소멸예정 사실을 전자우편 등의 방법으로 통지합니다.
                                        ③ 본 약관에 대한 동의를 철회하는 경우 적립선불은 소멸되어 환급이 불가능합니다.<br>
                                        <strong>제26조 </strong>(선불전자지급수단의 환급)
                                        ① 회원은 보유 중인 선불전자지급수단의 환급을 회사에 요구할 경우 구매선불 전액을 환급 받을 수 있습니다. 다만, 회사로부터 무상 제공받은 적립선불의 경우 환급 대상에서 제외되며, 카카오페이상품권의 경우에는 별도의 이용약관에서 정한 바에 따릅니다.
                                        ② 다음 각 호의 경우에는 구매선불의 잔액 전부를 환급합니다.
                                        1. 천재지변 등의 사유로 서비스 등에서 재화 또는 용역을 제공하기 곤란하여 선불전자지급수단을 사용하지 못하게 된 경우
                                        2. 선불전자지급수단의 결함으로 서비스 등에서 재화 또는 용역을 제공하지 못하는 경우
                                        3. 회원이 구매선불 잔액의 환급을 요청하는 경우
                                        4. 본 약관에 대한 동의를 철회하는 경우
                                        ③ 현금 환급은 회원으로부터 환급 신청이 접수된 후 회원의 입금사실을 확인한 시점에서 제칠(7)영업일 이내에 회원이 지정한 계좌로 현금 입금됩니다.
                                        ④ 회원은 회사에서 정한 기한 및 이용방법에 따라 선불전자지급수단을 이용할 수 있으며, 회사는 환급 등 구체적인 사항을 개별 선불전자지급수단의 고객센터 페이지를 통해 안내합니다.<br>
                                        <strong>제27조 </strong>(거래지시의 철회)
                                        회원이 선불전자지급수단을 이용하여 자금을 지급하는 경우 회원은 거래 지시된 금액의 정보가 수취인이 지정한 전자적 장치에 도달하기 전까지 거래지시를 철회할 수 있습니다.<br>
                                        <strong>제28조 </strong>(금지사항)
                                        회원은 선불전자지급수단을 양도, 판매, 담보제공 등의 처분행위를 할 수 없습니다.<br>
                                        <strong>제29조 </strong>(이용금액의 한도)
                                        ① 회사는 선불전자지급수단에 대해 전자금융거래법상의 한도를 그 보유 한도로 준용합니다. 단 보유 한도는 회사의 정책에 따라 감액될 수 있습니다.
                                        ② 제2장 결제대행서비스 제18조는 본 장에 준용합니다.<br>
                                        <strong>제30조 </strong>(정의)
                                        본 장에서 사용하는 용어의 정의는 다음과 같습니다.
                                        ① ‘전자고지결제서비스’라 함은 회사의 모바일메신저(이하 ‘카카오톡’이라 합니다)를 근간으로 국세, 지방세, 공공요금, 각종지로요금의 고지, 수납, 정산, 수납대금이체 등을 편리하고 효율적으로 처리하기 위해 제공하는 시스템 및 서비스 일체를 말합니다.
                                        ② ‘빌러(고지기관)’라 함은 각종 서비스를 이용한 대가에 대해 요금고지서를 ‘회원’에게 발송하는 자를 말한다.
                                        ③ ‘카톡청구서’라 함은 ‘빌러’의 요금고지서 대신 ‘카카오톡’ 기반에 모바일기기로 전송하는 전자적인 방식의 고지대행서비스를 말한다.
                                        ④ ‘회원’이라 함은 본 약관에 동의하고 요금고지서를 ‘카톡청구서’로 받는자를 말한다.<br>
                                        <strong>제31조 </strong>(거래지시의 철회)
                                        회원이 전자고지결제서비스내 지급수단을 이용하여 자금을 지급하는 경우 거래지시된 금액의 정보가 수취인의 계좌가 개설되어 있는 금융기관 또는 전자금융업자의 전자적 장치에 입력이 끝나기 전까지 거래지시를 철회할 수 있습니다.<br>
                                        <strong>제32조 </strong>(접근매체의 관리)
                                        ① 제2장 결제대행서비스 제19조 제1항 내지 4항은 본 장에 준용합니다.<br>
                                        <strong>제33조 </strong>(착오송금에 관한 사항) 
                                        ① 회원이 착오로 수취금융회사, 수취계좌번호 등을 잘못 기재하거나 입력하여 수취인에게 선불전자지급수단 등의 자금이 이동(이하 ‘착오송금’이라 합니다)된 경우, 회사에 통지하여 회사 또는 수취 금융회사 등을 통해 수취인에게 연락하여 착오 송금액 반환을 요청할 수 있습니다.
                                        ② 회사는 수취인에 대한 연락 사실, 수취인의 반환의사 유무, 수취인이 반환의사가 없는 경우 그 사유 등 회원 요청사항에 대한 처리결과 또는 관련 처리 진행상황을 회원이 전항의 ‘착오송금’ 발생사실을 회사에 통지한 날로부터 15일 이내에 회원에게 알려야 합니다.
                                        ③ 회사 또는 수취 금융회사를 통한 착오송금 반환 요청에도 수취인이 반환하지 않는 경우, 회원은 ｢예금자보호법｣ 제5장(착오송금 반환지원)에 따라 예금보험공사에 착오송금 반환지원 제도 이용을 신청할 수 있습니다. 다만 연락처를 통한 송금, SNS회원 간 송금 거래 등 예금보험공사가 수취인의 실지명의를 취득할 수 없는 거래는 반환지원 신청이 제한됩니다.
                                        *실지명의란 개인의 경우 주민등록표에 기재된 성명 및 주민등록번호 등 「금융실명거래 및 비밀보장에 관한 법률」 제2조제4호에 따른 실지명의를 말합니다.
                                        ④ 제3항의 ｢예금자보호법｣ 에 따른 착오송금 반환지원 제도는 개정 ｢예금자보호법｣ 시행일인 2021년 7월 6일 이후 발생한 착오송금에 대해 신청 가능합니다.
                                        ⑤ 회사는 예금보험공사가 착오송금 반환지원 업무의 원활한 수행을 위해 회사에 착오송금 수취인의 반환불가 사유, 실지명의, 주소 및 연락처, 착오송금 발생 현황 등의 자료를 요청하는 경우 정당한 사유가 없으면 이에 따라야 합니다.
                                        ⑥ 회원이 예금보험공사를 통해 착오송금 반환지원을 신청한 내역이 다음 각 호에 해당하는 경우 관련 법령에 따라 예금보험공사의 지원 절차가 중단될 수 있습니다.
                                        1. 회원이 거짓이나 부정한 방법으로 반환지원을 신청한 경우
                                        2. 착오송금이 아님이 객관적인 자료로 확인되는 경우
                                        3. 신청일 이전 반환 지원을 신청한 착오송금과 관련된 소송 등이 진행 중이거나 완료된 경우
                                        4. 그 밖에 예금보험위원회가 인정하는 경우
                                        본 약관은 2022년 6월 24일부터 적용됩니다.
                                    </div>
                                </li>
                            </ul>  
                        </div>
                    </div>
                </div>
                <!-- [e] 결제하기 영역 -->
            </div>
            <!-- [s] 주문 상품 정보 영역 -->
            <form action="${contextPath}/order/goPayment.do" method="POST" class="order_product_form" id="paymentForm">
               <div class="order_product">
                   <div class="order_product_number">
                       <h2>주문상품 ${paymentMap.Cnt}개</h2>
                   </div>         
                   <c:forEach var="cart" items="${cartList}">
                      <div class="order_product_imp">
                         <img src="${contextPath}/views/shopping/productImages/${cart.prodImage}" alt="chamyoe">
                          <div>
                              <span>${cart.prodName}</span>
                              <span>${cart.prodPrice}원 / ${cart.cartCount}개</span>
                              <span>${cart.prodPrice * cart.cartCount}원</span>                             
                          </div>
                     </div>
                     <input type="hidden" name="prodCode" value="${cart.prodCode}" class="hidden_input">
                     <input type="hidden" name="cartCount" value="${cart.cartCount}" class="hidden_input">
                     <input type="hidden" name="prodName" value="${cart.prodName}" class="hidden_input">
                   </c:forEach>                   
                   <input type="hidden" name="allProdPrice" value="${paymentMap.paymentAll}" class="hidden_input">
                   <input type="hidden" id="hiddenAddress" name="userAddr" value="${userList[0].userAddr}" class="hidden_input">
                   <input type="hidden" name="id" value="${user.id}" class="hidden_input">
                   <input type="hidden" name="userAddr2" value="${userList[0].userAddr2}" class="hidden_input">
                   <input type="hidden" name="deliveryMSG" id="deliveryMSG" value="배송시 요청사항을 선택해 주세요." class="hidden_input">
               </div>
               </form>
               <div class="go_payment">
                  <button id="paymentButton" class="kakaoPayGoGo">${paymentMap.paymentAll}원 결제하기</button>
               </div>
            <!-- [e] 주문 상품 정보 영역 -->
           </div>
    </div>
    <!-- [e]메인 컨텐츠 영역  -->

    <!-- [s]footer 영역 -->
    <jsp:include page="/WEB-INF/views/fix/footer.jsp"/>
    <!-- [e]footer 영역 -->
    <jsp:include page="/WEB-INF/views/fix/login.jsp"/>
</body>
</html>