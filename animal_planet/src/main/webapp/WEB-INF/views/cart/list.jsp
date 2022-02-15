<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/nav.jsp" />

<div class="container mt-3">
<h1 class="my-4">장바구니</h1>
<table class="table table-hover mb-5">
  <thead>
    <tr>
      <th scope="col">썸네일자리</th>
      <th scope="col">제품이름</th>
      <th scope="col">수량</th>
      <th scope="col">가격</th>
      <th scope="col">배송비</th>
    </tr>
  </thead>
  <tbody id="cartArea">
   	<tr>
   	  <td scope="row"></td>
   	  <td><h4>${cavo.pname }</h4></td>
   	  <td><input type="number" style="width:100px;" class="form-control d-inline-block" 
   	  			min="1" value="${cavo.cartStock }">&nbsp;&nbsp;<button type="button"
   	  			class="btn btn-sm btn-secondary" id="modStock">수정</button></td>
   	  <td>${(cavo.price) * (cavo.cartStock) }</td>
   	  <td>무료</td>
   	</tr>
      <tr>
         <td colspan="5" ><h5 class="text-right">상품가격 0 원 + 배송비 <strong>무료</strong> = 0 원</h5></td>
  	  </tr>
  </tbody>
</table>

<table class="table table-hover">
  <thead>
    <tr>
      <th scope="col" colspan="4">쿠폰적용</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th scope="row" colspan="4"><h4>적용가능한 쿠폰이 없습니다.</h4></th>
    </tr>
  </tbody>
</table>

<div class="text-center my-5" id="totalResult" style="height:60px;line-height:50px;border:5px solid grey;">총 상품가격 0 원 - 총 할인 0 원 + 총 배송비 0 원 = 총 주문금액 0 원</div>

<div class="row my-5 d-flex justify-content-center">
  <a href="/nproduct/list?category1=Dog" style="width:300px;" class="btn btn-lg btn-secondary d-inline-block">계속 쇼핑하기</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <a href="/payment/before?email=${email }&direct=no" style="width:300px;" class="btn btn-lg btn-primary d-inline-block">구매하기</a>
</div>
</div>

<script>
	const email = '<c:out value="${email}"/>';
</script>
<script src="/resources/js/cart.list.js"></script>
<script>
	getCartList(email);
</script>
<jsp:include page="../common/footer.jsp" />