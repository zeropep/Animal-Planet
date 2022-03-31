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
              <figure class="rounded mb-20" data-aos="flip-down">
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
            <div data-aos="fade-down" class="list-group shadow mt-10"> 
            <a href="/member/detail?email=${ses.email }" class="list-group-item list-group-item-action active">내 프로필</a>
            <a href="/member/modifyPwd?email=${ses.email }" class="list-group-item list-group-item-action">비밀번호 변경</a>
            <a href="/member/myboard?email=${ses.email }" class="list-group-item list-group-item-action">내가 쓴 글</a>
            <a href="/member/myorder?email=${ses.email }" class="list-group-item list-group-item-action">결제 목록</a>
            <a href="/member/resign?email=${ses.email }" class="list-group-item list-group-item-action">회원 탈퇴</a></div>
				<!--/.box -->
			</aside>
          <div class="col-md-9">
 <div class="space50"></div>
            <div class="form-container">
            <h2 class="section-title text-left">내 프로필</h2>
        <hr class="p-0 m-0"/>
    <div class="wrapper light-wrapper">
      <div class="container p-3 mt-30">
        <div class="row w-100">
            <blockquote class="bordered">
              <p>이메일 : ${ses.email }</p>
              <p>이름   : ${mvo.name }</p>
              <p>닉네임 : ${mvo.nickName }</p>
              <p>연락처 : ${mvo.phoneNumber }</p>
              <p>주소   : ${mvo.address }  ${mvo.addressDetail }</p>
              <p>가입일 : ${mvo.joinDate }</p>
            </blockquote>
          <!-- /column -->
        </div>
        <!-- /.row -->
      </div>
      <!-- /.container -->
    </div>
                 <c:if test="${ses.email eq mvo.email }">
			<a href="/member/modify?email=${ses.email }&mno=${mvo.mno }" id="modBtn" class="next btn shadow float-right text-bold">개인정보 수정<i class="mi-arrow-right"></i></a>
    </c:if> </div>
                </div>
    
    
    </div>
            </div>
</main>

<script>
let isUp = '<c:out value="${isUp}"/>';
if (parseInt(isUp)) {
	alert("회원정보 수정 성공~");
}
</script>
<jsp:include page="../common/footer.jsp" />