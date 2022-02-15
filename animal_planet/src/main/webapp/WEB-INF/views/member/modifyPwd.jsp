<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/nav.jsp" />
 <script>
 function isSame() {
	    var pwd =  document.getElementById('pwd').value;
	    var checkPwd =  document.getElementById('checkPwd').value;
	    if (pwd.length < 4 || pwd.length > 16) {
	        window.alert('비밀번호는 4글자 이상, 16글자 이하만 이용 가능합니다.');
	        document.getElementById('pwd').value=document.getElementById('checkPwd').value='';
	        document.getElementById('same').innerHTML='';
	    }
	    if(document.getElementById('pwd').value!='' && document.getElementById('checkPwd').value!='') {
	        if(document.getElementById('pwd').value==document.getElementById('checkPwd').value) {
	            document.getElementById('same').innerHTML='비밀번호가 일치합니다.';
	            document.getElementById('same').style.color='blue';
	        }
	        else {
	            document.getElementById('same').innerHTML='비밀번호를 다시 확인해주세요.';
	            document.getElementById('same').style.color='red';
	        }
	    }
	}

</script>

<script>
function check() {
	  if(fr.pwd.value==fr.pwd.checkPwd.value) {
		  
    return true;

  }else if(fr.pwd.value!=fr.checkPwd.value) {
    alert("변경할 비밀번호를 확인해주세요!");
    fr.pwd.focus();
    return false;

  }

}
</script>
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
            <a href="/member/remove?email=${ses.email }" class="list-group-item list-group-item-action">회원 탈퇴</a></div>
				<!--/.box -->
			</aside>
          <div class="col-md-9">
 <div class="space50"></div>
            <div class="form-container">
            <h2 class="section-title text-left">비밀번호 변경</h2>
        <hr class="p-0 m-0"/>
	<form action="/member/modifyPwdChange" name="fr" method="post" onsubmit="return check()">
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
          <p><input type="password" id="checkPwd" name="checkPwd" value=""  class="form-control" onchange="isSame()" style="width:480px;" required > <span id="same"></span></p>
        </div>
      </div>
            </blockquote>
          <!-- /column -->
        </div>
        <!-- /.row -->
      </div>
      <!-- /.container -->
    </div>
      <button class="float-right btn btn-primary btn-lg my-5" type="submit" onchange="isSame()" >비밀번호 변경</button>
    </form>
    </div>
   </div>
  </div>
</div>
</main>

<jsp:include page="../common/footer.jsp" />
