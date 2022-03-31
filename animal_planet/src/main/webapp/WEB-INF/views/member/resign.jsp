<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/nav.jsp" />

<main>
	<div class="container inner h-100">
		<div class="row">
			<aside class="col-md-3 mt-10 pr-30">
				<!-- sidebar -->
              <figure class="rounded mb-20">
      			<c:set var="fList"  value="${memberDTO.getFList() }"/>
  				<c:choose>
              		<c:when test="${fList.size() > 0 }">
  						<img src="/upload/${fn:replace(fList.get(0).saveDir,'\\','/')}/${fList.get(0).uuid }_${fList.get(0).fileName}">
  					</c:when>
  					<c:otherwise>
  						<img src="/resources/img/propic0.jpg" alt="" />
  					</c:otherwise>
  				</c:choose></figure>
				<p class="text-bold fa-lg"><i class="fa fa-paw mr-10"></i>${mvo.nickName} 님</p>
            <div class="list-group shadow mt-10"> 
            <a href="/member/detail?email=${ses.email }" class="list-group-item list-group-item-action">내 프로필</a>
            <a href="/member/modifyPwd?email=${ses.email }" class="list-group-item list-group-item-action">비밀번호 변경</a>
            <a href="/member/myboard?email=${ses.email }" class="list-group-item list-group-item-action">내가 쓴 글</a>
            <a href="/member/myorder?email=${ses.email }" class="list-group-item list-group-item-action">결제 목록</a>
            <a href="/member/resign?email=${ses.email }" class="list-group-item list-group-item-action active">회원 탈퇴</a></div>
				<!--/.box -->
			</aside>
          <div class="col-md-9">
 			<div class="space50"></div>
            <div class="form-container">
            <h2 class="section-title text-left">회원 탈퇴</h2>
        	<hr class="p-0 m-0"/>
    		<div class="wrapper light-wrapper mt-20">
      			<div class="container">
      				<h5 class="color-red mt-40">회원 탈퇴시 회원정보는 즉시 삭제되며 복구할 수 없습니다.<br>계속 진행하시겠습니까?</h5>
      				<form action="/member/resign" method="post">
      					<input type="hidden" value="${ses.email }">
	      				<button class="btn btn-pastel-red float-right mt-150" type="submit" id="resignBtn">탈퇴하기</button>
      				</form>
      			</div>
    		</div>
    		</div>
  			</div>
  		</div>
	</div>
</main>

<script src="/resources/js/member/member.resign.js"></script>
<jsp:include page="../common/footer.jsp" />
