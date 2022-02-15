<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="../common/header.jsp" />
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<link href="/resources/dist/css/summernote/summernote-lite.css" rel="stylesheet">
<script src="/resources/dist/js/summernote/summernote-lite.js"></script>
<script src="/resources/dist/js/summernote/summernote-ko-KR.js"></script>
<jsp:include page="../common/nav.jsp" />

<div class="container">
    <div class="py-5 text-center">
      <h2>게시글 수정</h2>
    </div>

<!-- 게시글 편집란 시작 -->
      <div class="col-md-10 col-lg-10 m-auto">
        <form action="/freeboard/modify" method="post" enctype="multipart/form-data" id="form">
<c:set var="bvo" value="${bdto.bvo }"/>
        <input type="hidden" name="bno" value="${bvo.bno }">
          <div class="row g-3">
			
            <div class="col-md-6">
			  <label for="species" class=""></label>
              <input type="hidden" class="" name="species"
               id="species" value="">
              <label for="bCate" class="form-label">게시판 카테고리</label>
              <select class="form-select" id="bCate" name="bCate">
                <option value="">Choose...</option>
                <option value="free" selected>자유게시판</option>
                <option value="parcel">분양게시판</option>
                <option value="lost">분실게시판</option>
              </select>
			</div>
            <div class="col-md-6">
              <label for="bCate" class="form-label">게시판 태그</label>
              <select class="form-select" id="bTag" name="bTag">
                <option value="">Choose...</option>
                <option value="lifetalk" ${bvo.getBTag() eq 'lifetalk' ? 'selected' : '' }>일상 이야기</option>
                <option value="together" ${bvo.getBTag() eq 'together' ? 'selected' : '' }>함께해요</option>
                <option value="donation" ${bvo.getBTag() eq 'donation' ? 'selected' : '' }>무료 나눔</option>
              </select>
			</div>
            <div class="col-12">
              <label for="title" class="form-label">제목</label>
              <input type="text" class="form-control" name="title"
               id="title" value="${bvo.title }" >              
            </div>
            <div class="col-12">
              <label for="nickName" class="form-label">Writer</label>
                <input type="text" class="form-control" name="nickName"
                id="nickName" value="${bvo.nickName }" readonly >
                <!-- 나중에 히든으로 바꾸고 로그인된 계정의 닉네임을 가져오도록 수정 -->
            </div>
            

             <div class="col-12">
              <label for="content" class="form-label"></label>
              <textarea name="content" class="summernote"
               id="content">${bvo.content }</textarea>              
            </div>
            
            <input type="hidden" id="images" name="image">

    		<button type="submit" class="w-100 btn btn-primary btn-lg my-5" id="regBtn">등록하기</button>
        </div>
        </form>
      </div>
    </div>

<script src="/resources/js/board/board.modify.summer.js"></script>
<script src="/resources/js/board.modify.js"></script>
<jsp:include page="../common/footer.jsp" />