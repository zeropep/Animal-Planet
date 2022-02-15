<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/nav.jsp" />

<div class="container">
  <main>
    <div class="py-5 text-center mt-30"> </div>

<!-- 상품상세정보란 시작 -->
      <div class="col-md-10 col-lg-10 m-auto">
			<a href="/freeboard/list?bCate=free&species=${pgn.pgvo.species }&bTag=${pgn.pgvo.getBTag() }&pageNo=${pgvo.pageNo }&qty=${pgvo.qty}&type=${pgvo.type}&keyword=${pgvo.keyword}" class="btn btn-primary float-right">목록으로</a>
   
        <p class="mb-3 small pt-10">자유게시판 > </p>
          <div class="row g-3 mb-100 w-100">
<c:set var="bvo" value="${bdto.bvo }"/>
          
          <div class="col-12">
              <label for="title" class="form-label">제목</label>
              <input type="text" class="form-control" name="title"
               id="title" value="${bvo.title }" readonly>              
            </div>

            <div class="col-12"> 
              <p class="font-weight-bold m-0">작성자 : ${bvo.nickName } </p>
              <p class="small float-left">조회 ${bvo.readCount }</p>
              <p class="small float-left ml-10">등록일 : ${bvo.regAt }</p> 
            <c:if test="${bvo.modAt ne null}">
            <p class="small float-left ml-10">(수정일 : ${bvo.modAt })</p>            
            </c:if>            
              <hr>
            </div>
            <div class="col-12" >
             ${bvo.content }          
            </div>

			</div>
            
			<div class="col-12 mt-50 mb-20">
			<a href="/freeboard/list?bCate=free&species=${pgn.pgvo.species }&bTag=${pgn.pgvo.getBTag() }&pageNo=${pgvo.pageNo }&qty=${pgvo.qty}&type=${pgvo.type}&keyword=${pgvo.keyword}" class="btn btn-primary float-left">목록으로</a>
			<c:if test="${bvo.nickName eq ses.nickName}">
    		  <button type="button" id="delBtn" class="btn btn-outline-danger float-right">삭제</button>
    	   	  <a href="/freeboard/modify?bno=${bvo.bno }&pageNo=${pgvo.pageNo }&qty=${pgvo.qty}&type=${pgvo.type}&keyword=${pgvo.keyword}" id="modBtn" class="btn btn-outline-warning float-right">수정</a>
 			</c:if> 	
        	</div>
        </div>
      </div>
    </div>
  </main>
</div>
<form action="/freeboard/remove" method="post" id="delForm">
	<input type="hidden" name="bno" value="${bvo.bno }">
	<input type="hidden" name="pageNo" value="${pgvo.pageNo }">
    <input type="hidden" name="qty" value="${pgvo.qty }">
    <input type="hidden" name="type" value="${pgvo.type }">
    <input type="hidden" name="keyword" value="${pgvo.keyword }">
</form>


<!-- 댓글영역 시작 -->
<div class="container" style="margin-bottom:60px;">
<!-- <sec:authorize access="isAuthenticated()">
<sec:authentication property="principal.mvo.nickName" var="authNick" />  
아래 닉네임 바꾸기-->
<c:if test="${ses.email ne '' && ses.email ne null  }">
<div class="input-group my-3">
	<span class="input-group-text" id=cmtNickName style="height:48px">${ses.nickName }</span>
	<input type="text" class="form-control" id="cmtText" value="댓글을 남겨보세요. ">
	<button class="btn btn-success" id="cmtPostBtn" type="button">Post</button>
</div>
</c:if>
<!-- </sec:authorize> -->
<div class="mb-20">
<ul class="list-group list-group-flush col-10 m-auto" id="cmtListArea">
  
</ul>
<div class="row col-10" id="cmtPaging">
    </div>
</div>
</div>
<script>
const bnoVal = document.querySelector("input[name=bno]").value;
</script>

<script src="/resources/js/board.detail.js"></script>
<script src="/resources/js/board.comment.js"></script>
<script>
let isMod = '<c:out value="${isMod}"/>';
if (parseInt(isMod)) {
	alert('게시글 수정 성공~');
}
getCommentList(bnoVal);
</script>
<jsp:include page="../common/footer.jsp" />