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
      <h2>상품 수정</h2>
    </div>
      <c:set var="npvo" value="${pdto.npvo }"/>
<!-- 상품등록란 시작 -->
      <div class="col-md-12">
        <form action="/nproduct/modify" method="post" id="form">
          <input type="hidden" name="npno" id="npno" value="${npvo.npno }">
		  <input type="hidden" name="pageNo" value="${pgvo.pageNo }">
		  <input type="hidden" name="qty" value="${pgvo.qty }">
		  <input type="hidden" name="type" value="${pgvo.type }">
		  <input type="hidden" name="keyword" value="${pgvo.keyword }">
          <div class="row g-3">
          
            <div class="col-12">
              <label for="pname" class="form-label">Product Name</label>
              <input type="text" class="form-control" name="pname" id="pname" value="${npvo.pname }" required>
            </div>
          
          	<div class="col-6">
              <label for="MadeIn" class="form-label">Made In</label>
              <select class="form-select" id="MadeIn" name="MadeIn" required>
                <option value="">Choose...</option>
                <option value="us" ${npvo.madeIn eq 'us' ? 'selected' : '' }>United States</option>
                <option value="ko" ${npvo.madeIn eq 'ko' ? 'selected' : '' }>Republic of Korea</option>
                <option value="cn" ${npvo.madeIn eq 'cn' ? 'selected' : '' }>China</option>
                <option value="eu" ${npvo.madeIn eq 'eu' ? 'selected' : '' }>European Union</option>
                <option value="et" ${npvo.madeIn eq 'et' ? 'selected' : '' }>Etc</option>
              </select>
            </div>

            <div class="col-6">
              <label for="price" class="form-label">Price</label>
              <input type="text" class="form-control" id="price" name="price" value="${npvo.price }" required>
            </div>

            <div class="col-12 mb-20">
              <label for="description" class="form-label"></label>
              <textarea class="summernote" name="description" id="content">${npvo.description }</textarea>              
            </div>

            <div class="col-md-4">
              <label for="category1" class="form-label">Category</label>
              <select class="form-select" id="category1" name="category1" required>
                <option value="">Choose...</option>
                <option value="Dog" selected>Dog</option>
              </select>
            </div>

            <div class="col-md-4">
              <label for="category2" class="form-label">Category Detail</label>
              <select class="form-select" id="category2" name="category2" required>
                <option value="" >Choose detail category</option>
                <option value="Food" ${npvo.category2 eq 'Food' ? 'selected' : '' }>Food</option>
                <option value="Snack" ${npvo.category2 eq 'Snack' ? 'selected' : '' }>Snack</option>
                <option value="Nutrient" ${npvo.category2 eq 'Nutrient' ? 'selected' : '' }>Nutrient</option>
                <option value="Supplies" ${npvo.category2 eq 'Supplies' ? 'selected' : '' }>Supplies</option>
              </select>
            </div>
            
            <div class="col-md-4">
              <label for="stock" class="form-label">Stock</label>
              <input type="text" class="form-control" id="stock" name="stock" value="${npvo.stock }" required>
            </div>
			
            <input type="hidden" id="images" name="image">

          <button class="w-100 btn btn-yellow btn-lg mt-50" id="modBtn" type="submit">수정하기</button>
          <button class="w-100 btn btn-red btn-lg mb-50" id="delBtn" type="button">삭제하기</button>
        </div>
        </form>
      </div>
  </main>
</div>

<form action="/nproduct/remove" method="POST" id="delForm">
	<input type="hidden" name="npno" value="${npvo.npno }" data-email="ses.email">
	<input type="hidden" name="pageNo" value="${pgvo.pageNo }">
	<input type="hidden" name="qty" value="${pgvo.qty }">
	<input type="hidden" name="type" value="${pgvo.type }">
	<input type="hidden" name="keyword" value="${pgvo.keyword }">
</form>

<script src="/resources/js/product/product.modify.summer.js"></script>
<script src="/resources/js/product/product.remove.js"></script>
<jsp:include page="../common/footer.jsp" />