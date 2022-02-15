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
  <main>
    <div class="py-5 text-center">
      <h2>글 수정하기</h2>
    </div>

<!-- 게시글 편집란 시작 -->
      <div class="col-md-12">
        <form action="/parcelboard/modify" method="post" enctype="multipart/form-data" id="form">
		<c:set var="bvo" value="${bdto.bvo }"/>
        <input type="hidden" name="bno" value="${bvo.bno }">
          <div class="row g-3">
			
                <input type="hidden" class="form-control" name="nickName"
                id="nickName" value="${bvo.nickName }">
            
            <div class="col-12">
              <label for="title" class="form-label">제목</label>
              <input type="text" class="form-control" name="title"
               id="title" value="${bvo.title }">              
            </div>
            
            <div class="col-md-4">
              <label for="gender" class="form-label">성별</label>
              <select class="form-select" id="gender" name="gender">
                <option value="">Choose...</option>
                <option value="male" ${bvo.gender eq 'male' ? 'selected' : '' }>수컷</option>
                <option value="female" ${bvo.gender eq 'female' ? 'selected' : '' }>암컷</option>
              </select>
            </div>
            
            <div class="col-md-4">
              <label for="species" class="form-label">종류</label>
              <select class="form-select" id="species" name="species">
                <option value="">Choose...</option>
                <option value="Dog" ${bvo.species eq 'Dog' ? 'selected' : '' }>개</option>
                <option value="Cat" ${bvo.species eq 'Cat' ? 'selected' : '' }>고양이</option>
                <option value="Etc" ${bvo.species eq 'Etc' ? 'selected' : '' }>기타</option>
              </select>
            </div>
            
            <div class="col-md-4">
              <label for="breed" class="form-label">품종</label>
              <input type="text" class="form-control" name="breed"
               id="breed" value="${bvo.breed }">              
            </div>
            
            <div class="col-12">
              <label for="content" class="form-label"></label>
              <textarea class="summernote" name="content" id="content">${bvo.content }</textarea>              
            </div> 

            
            <input type="hidden" id="images" name="image">
            
    		<button type="submit" class="w-100 btn btn-primary btn-lg my-5" id="regBtn">Submit</button>
        </div>
        </form>
      </div>
    </div>
  </main>
</div>

<script src="/resources/js/board/board.modify.summer.js"></script>
<script src="/resources/js/board/board.modify.js"></script>
<jsp:include page="../common/footer.jsp" />