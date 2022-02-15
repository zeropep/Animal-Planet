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
      <h2>새 글 쓰기</h2>
    </div>
      
<!-- 상품등록란 시작 -->
      <div class="col-md-12">
        <form action="/parcelboard/register" method="post" id="form">
          <div class="row g-3">
          
          	<div class="col-md-6">
              <label for="bCate" class="form-label">게시판 카테고리</label>
              <select class="form-select" id="bCate" name="bCate">
                <option value="">Choose...</option>
                <option value="free">자유게시판</option>
                <option value="parcel" selected>분양게시판</option>
                <option value="lost">분실게시판</option>
              </select>
            </div>
            
            <div class="col-md-6">
              <label for="bTag" class="form-label">분양 상태</label>
              <select class="form-select" id="bTag" name="bTag">
                <option value="">Choose...</option>
                <option value="ing">분양 중</option>
                <option value="reserved">분양 예약</option>
                <option value="done">분양 완료</option>
              </select>
            </div>
			
			<div class="col-md-4">
              <label for="gender" class="form-label">성별</label>
              <select class="form-select" id="gender" name="gender">
                <option value="">Choose...</option>
                <option value="male">수컷</option>
                <option value="female">암컷</option>
              </select>
            </div>
            
            <div class="col-md-4">
              <label for="species" class="form-label">종류</label>
              <select class="form-select" id="species" name="species">
                <option value="">Choose...</option>
                <option value="Dog">개</option>
                <option value="Cat">고양이</option>
                <option value="Etc">기타</option>
              </select>
            </div>
            
            <div class="col-md-4">
              <label for="breed" class="form-label">품종</label>
              <input type="text" class="form-control" name="breed"
               id="breed" placeholder="ex) 푸들..">              
            </div>
            
			<input type="hidden" class="form-control" name="nickName"
                id="nickName" value="${ses.nickName }" >
            
          	<div class="col-12">
              <label for="title" class="form-label">제목</label>
              <input type="text" class="form-control" name="title"
               id="title" placeholder="Title">              
            </div>

            <div class="col-12">
              <label for="content" class="form-label"></label>
              <textarea class="summernote" name="content" id="content"></textarea>              
            </div>
            
            <input type="hidden" id="images" name="image">

          <button class="w-100 btn btn-primary btn-lg my-5" id="regBtn" type="submit">Continue to Register</button>
        </div>
        </form>
      </div>
  </main>
</div>

<script src="/resources/js/board/board.register.summer.js"></script>
<!-- <script src="/resources/js/board/board.register.js"></script> -->
<jsp:include page="../common/footer.jsp" />