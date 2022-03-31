<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/nav.jsp" />

<div class="container mt-3">
<h1 class="my-4">주문 / 결제</h1>
<h3 class="my-4">구매자정보</h3>
<table class="table table-hover mb-5" id="customerInfo">
  <thead>
    <tr>
      <th scope="col"></th>
      <th scope="col"></th>
      <th scope="col"></th>
      <th scope="col"></th>
      <th scope="col"></th>
    </tr>
  </thead>
  <tbody>
   	<tr>
   	  <th scope="row" width=200>이름</th>
   	  <td colspan="4">${mvo.name }</td>
   	</tr>
   	<tr>
   	  <th scope="row">이메일</th>
   	  <td colspan="4">${mvo.email }</td>
   	</tr>
   	<tr>
   	  <th scope="row">휴대폰번호</th>
   	  <td colspan="4">${mvo.phoneNumber }</td>
   	</tr>
  </tbody>
</table>

<h3 class="my-4 d-flex d-inline-block">받는사람정보</h3>
<!-- <button type="button" class="btn btn-secondary">배송지 변경</button> -->
<table class="table table-hover mb-5" if="receiveInfo">
  <thead>
    <tr>
      <th scope="col"></th>
      <th scope="col"></th>
      <th scope="col"></th>
      <th scope="col"></th>
      <th scope="col"></th>
    </tr>
  </thead>
  <tbody>
   	<tr>
   	  <th scope="row" width=200>이름</th>
   	  <td colspan="4">${mvo.name }</td>
   	</tr>
   	<tr>
   	  <th scope="row">배송주소</th>
   	  <td colspan="4">${mvo.address } ${mvo.addressDetail }</td>
   	</tr>
   	<tr>
   	  <th scope="row">휴대폰번호</th>
   	  <td colspan="4">${mvo.phoneNumber }</td>
   	</tr>
   	<tr>
   	  <th scope="row">배송 요청사항</th>
   	  <td colspan="4"><input type="text" id="request"></td>
   	</tr>
  </tbody>
</table>

<h3 class="my-4 d-flex d-inline-block">결제정보</h3>
<form action="#">
	<table class="table table-hover mb-5" id="paymentInfo">
	  <thead>
	    <tr>
	      <th scope="col"></th>
	      <th scope="col"></th>
	      <th scope="col"></th>
	      <th scope="col"></th>
	      <th scope="col"></th>
	    </tr>
	  </thead>
	  <tbody>
	   	<tr>
	   	  <th scope="row" width=200>총 상품가격</th>
	   	  <td colspan="4">${total } 원</td>
	   	</tr>
	   	<tr>
	   	  <th scope="row">할인쿠폰</th>
	   	  <td colspan="4">0 원</td>
	   	</tr>
	   	<tr>
	   	  <th scope="row">배송비</th>
	   	  <td colspan="4">0 원</td>
	   	</tr>
	   	<tr>
	   	  <th scope="row">총 결제금액</th>
	   	  <td colspan="4">${total } 원</td>
	   	</tr>
	   	<tr>
	   	  <th scope="row">결제방식</th>
	   	  <td colspan="4">
	   	  	<select class="form-select" name="pay-type" style="width:200px;" id="option" required>
	   	  	  <option>Choose...</option>
	   	  	  <option value="card">카드</option>
	   	  	  <option value="tranfer">계좌이체</option>
	   	  	  <option value="deposit">무통장입금</option>
	   	  	  <option value="kakaopay">카카오페이</option>
	   	  	</select>
	   	  </td>
	   	</tr>
	  </tbody>
	</table>
	
	<input class="my-3" type="checkbox" value="remember-me" id="agreement" required> 구매조건 확인 및 결제대행 서비스 약관 동의
	
	<div class="row my-5 d-flex justify-content-center">
	  <button type="button" style="width:300px;" class="btn btn-lg btn-primary d-inline-block" id="payBtn" disabled>결제하기</button>
	</div>
</form>
</div>

<script>
	const email = '<c:out value="${email}"/>'
	const direct = '<c:out value="${direct}"/>'
</script>
<script src="/resources/js/payment.before.js"></script>
<script>
	
</script>

<jsp:include page="../common/footer.jsp" />