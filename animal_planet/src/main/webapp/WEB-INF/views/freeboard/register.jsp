<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../common/header.jsp" />
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<link href="/resources/dist/css/summernote/summernote-lite.css" rel="stylesheet">
<script src="/resources/dist/js/summernote/summernote-lite.js"></script>
<script src="/resources/dist/js/summernote/summernote-ko-KR.js"></script>
<jsp:include page="../common/nav.jsp" />

<div class="container">
  <main>
    <div class="py-5 text-center">
      <h2>새 글 작성</h2>
    </div>

      
<!-- 상품등록란 시작 -->
      <div class="col-md-10 col-lg-10 m-auto">
        <form action="/freeboard/register" method="post" id="form">
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
                <option value="lifetalk">일상 이야기</option>
                <option value="together">함께해요</option>
                <option value="donation">무료 나눔</option>
              </select>
			</div>
			
			<div class="col-12">
              <label for="title" class="form-label">제목</label>
              <input type="text" class="form-control" name="title"
               id="title" placeholder="Title">              
            </div>
                <input type="hidden" class="form-control" name="nickName"
                id="nickName" value="${ses.nickName }" >

            <div class="col-12">
              <label for="content" class="form-label"></label>
              <textarea class="summernote" id="content" name="content"></textarea>              
            </div>
            
            <input type="hidden" id="images" name="image">

          <button class="w-100 btn btn-primary btn-lg my-5" id="regBtn" type="submit">등록하기</button>
        </div>
        </form>
      </div>
  </main>
</div>

<script src="/resources/js/board/board.register.summer.js"></script>
<jsp:include page="../common/footer.jsp" />