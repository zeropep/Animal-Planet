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
            <a href="/member/modifyPwd?email=${ses.email }" class="list-group-item list-group-item-action active">비밀번호 변경</a>
            <a href="/member/myboard?email=${ses.email }" class="list-group-item list-group-item-action">내가 쓴 글</a>
            <a href="/member/myorder?email=${ses.email }" class="list-group-item list-group-item-action">결제 목록</a>
            <a href="/member/resign?email=${ses.email }" class="list-group-item list-group-item-action">회원 탈퇴</a></div>
				<!--/.box -->
			</aside>
          <div class="col-md-9">
 			<div class="space50"></div>
            <div class="form-container">
            <h2 class="section-title text-left">비밀번호 변경</h2>
        <hr class="p-0 m-0"/>
	<form action="/member/modifyPwdChange" name="fr" method="post">
    <div class="wrapper light-wrapper">
      <div class="container p-3 mt-30">
        <div class="row w-100">
            <blockquote class="bordered">
    <div class="col d-flex align-items-start">
        <svg class="bi text-muted flex-shrink-0 me-3" width="1.75em" height="1.75em"><use xlink:href="#cpu-fill"/></svg>
        <div>
          <p><input type="hidden" id="email" name="email" value="${ses.email }" class="form-control"></p>
        </div>
      </div>  
<!--       변경할 비밀번호                -->
      
      <div class="col d-flex align-items-start">
        <svg class="bi text-muted flex-shrink-0 me-3" width="1.75em" height="1.75em"><use xlink:href="#cpu-fill"/></svg>
        <div>
          <p class="fw-bold mb-0">기존 비밀번호 : </p>
          <p><input type="password" id="oldPwd" name="oldPwd" class="form-control" style="width:480px;" required></p>
          <button class="btn btn-primary my-1" type="button" id="pwdCheck">기존 비밀번호 확인</button>
        </div>
      </div>      
<!--                                   -->

<!--       변경할 비밀번호                -->
      
      <div class="col d-flex align-items-start">
        <svg class="bi text-muted flex-shrink-0 me-3" width="1.75em" height="1.75em"><use xlink:href="#cpu-fill"/></svg>
        <div>
          <p class="fw-bold mb-0">변경할 비밀번호 : </p>
          <p><input type="password" id="pwd" name="pwd" value="" class="form-control"  onchange="isSame()" style="width:480px;" required></p>
        </div>
      </div>      
<!--                                   -->

<!--       변경할 비밀번호확인             -->
      <div class="col d-flex align-items-start">
        <svg class="bi text-muted flex-shrink-0 me-3" width="1.75em" height="1.75em"><use xlink:href="#cpu-fill"/></svg>
        <div>
          <p class="fw-bold mb-0">비밀번호 확인 : </p>
          <p><input type="password" id="checkPwd" name="checkPwd" class="form-control" onchange="isSame()" style="width:480px;" required > <span id="same"></span></p>
        </div>
      </div>
            </blockquote>
          <!-- /column -->
        </div>
        <!-- /.row -->
      </div>
      <!-- /.container -->
    </div>
      <button class="float-right btn btn-primary btn-lg my-5" type="submit" id="modBtn" disabled>비밀번호 변경</button>
    </form>
    </div>
   </div>
  </div>
</div>
</main>


<script src="/resources/js/member/member.modPwd.js"></script>
<jsp:include page="../common/footer.jsp" />
