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
                  </figure>
  					</c:otherwise>
  				</c:choose></figure>
				<p class="text-bold fa-lg"><i class="fa fa-paw mr-10"></i>${mvo.nickName} 님</p>
            <div class="list-group shadow mt-10"> 
            <a href="/member/detail?email=${ses.email }" class="list-group-item list-group-item-action active">내 프로필</a>
            <a href="/member/modifyPwd?email=${mvo.email }" class="list-group-item list-group-item-action">비밀번호 변경</a>
            <a href="/member/myboard?email=${ses.email }" class="list-group-item list-group-item-action">내가 쓴 글</a>
            <a href="/member/myorder?email=${ses.email }" class="list-group-item list-group-item-action">결제 목록</a>
            <a href="/member/resign?email=${ses.email }" class="list-group-item list-group-item-action">회원 탈퇴</a></div>
				<!--/.box -->
			</aside>
          <div class="col-md-9">
            <div class="form-container">
            <h2 class="section-title text-left">내 정보 수정</h2>
            <p class="small"> 정보를 수정해 주세요</p>
        <hr class="p-0 m-0"/>
             <form action="/member/modify" method="post" enctype="multipart/form-data">
    <div class="wrapper light-wrapper">
      <div class="container p-3 mt-30">
        <div class="row w-100">
            <blockquote class="bordered">
              <p class="col-6 float-left">이메일 : <input type="text" id="email" name="email" value="${ses.email }" class="form-control" readonly></p>
              <p class="col-6 float-left">이름 : <input type="text" id="name" name="name" value="${mvo.name }" class="form-control" ></p>
              <p class="col-6 float-left">닉네임 : <input type="text" id="nickName" name="nickName" value="${mvo.nickName}" class="form-control" ></p>
              <p class="col-6 float-left">연락처 : <input type="text" id="phoneNumber" name="phoneNumber" value="${mvo.phoneNumber }" class="form-control" ></p>
              <p class="col-12 float-left">주소 : <input type="text" id="address" name="address" value="${mvo.address }" class="form-control " > - <input type="text" id="addressDetail" name="addressDetail" value="${mvo.addressDetail }" class="form-control" ></p>
            </blockquote>
          <!-- /column -->
        </div>
        <!-- /.row -->
 <!-- ------기존 파일 리스트---------------------------------------------------- -->
       <div class="col d-flex align-items-start">
      <c:set var="fList"  value="${memberDTO.getFList() }"/>
      
			<div class="col-12 mb-3" id= "profileHide" >
			 <p style="font-size:18px; line-height:30px; font-style:normal;">프로필이미지 : </p>
			<ul class="list-group list-group-flush">
			<c:forEach items="${fList }" var="fvo" >
  				<li class="list-group-item d-flex justify-content-between align-items-start">
  				<c:choose>
  					<c:when test="${fvo.fileType > 0 }">
  					<div>
  						<img src="/upload/${fn:replace(fvo.saveDir,'\\','/')}/${fvo.uuid }_th_${fvo.fileName}">
  					</div>
  					</c:when>
  					<c:otherwise>
  					<div>
  						<!-- 클립모양의 아이콘을 넣어서 파일을 표현할 수 있음 -->
  					</div>
  					</c:otherwise>
  				</c:choose>
    				<div class="ms-2 me-auto">
      				<div class="fw-bold">${fvo.fileName }</div>
      				
      				${fvo.regAt }
    				</div>
    				<span class="badge bg-secondary rounded-pill">${fvo.fileSize } Byte</span>
  				</li>
  			</c:forEach>
  			</ul>
			</div>
			</div>
			<!-- 새로 등록한 파일리스트 출력 부분 -->
            <div class="col-12 d-grid">
  				<input class="form-control" type="file" style="display: none;"
  				 id="files" name="files" multiple>
  				<button type="button" id="trigger" class="btn btn-outline-primary btn-block d-block">프로필 이미지 선택</button>
			</div>		
			<div class="col-12" id="fileZone"></div>
            
      <!--     -------------------------------------------------------------------               -->
        
      </div>
      <!-- /.container -->
    </div>
			<button type="submit" class="btn btn-outline-primary float-right" id="regBtn">개인정보 수정하기</button>
       </form> 
       </div>
    </div>
    
    
    </div>
 </div>
</main>

<script src="/resources/js/member/member.modify.js"></script>
<jsp:include page="../common/footer.jsp" />