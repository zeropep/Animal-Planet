<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/nav.jsp" />

<div class="container">
	<main>
		<div class="py-5 text-center">
			<h2>Board Detail</h2>
			<p class="lead">Below is an example form built entirely with
				Bootstrap’s form controls. Each required form group has a validation
				state that can be triggered by attempting to submit the form without
				completing it.</p>
		</div>

		<div class="row g-5">
			<div class="col-md-5 col-lg-4 order-md-last">
				<h4 class="d-flex justify-content-between align-items-center mb-3">
					<span class="text-primary">Comment</span>
				</h4>
				<ul class="list-group mb-3">
					<!-- 댓글 -->
					<li class="list-group-item d-flex justify-content-between lh-sm">
						<div>
							<h6 class="my-0">Product name</h6>
							<small class="text-muted">Brief description</small>
						</div> <span class="text-muted">$12</span>
					</li>
					<!-- 여기까지 -->
				</ul>

				<form class="card p-2">
					<div class="input-group">
						<input type="text" class="form-control" id="content"
							placeholder="Be nice...">
						<button type="submit" class="btn btn-secondary"
							data-set="${ses.email }">Submit</button>
					</div>
				</form>
			</div>
			<!-- 게시글 수정란 시작 -->
			<div class="col-md-7 col-lg-8">
				<h4 class="mb-3">Board infomation</h4>
				
				<c:set var="pvo" value="${pdto.pvo }"/>
				
				<form action="/product/modify" method="POST" enctype="multipart/form-data">
					<input type="hidden" name="pno" id="pno" value="${pvo.pno }">
					<input type="hidden" name="pageNo" value="${pgvo.pageNo }">
					<input type="hidden" name="qty" value="${pgvo.qty }">
					<input type="hidden" name="type" value="${pgvo.type }">
					<input type="hidden" name="keyword" value="${pgvo.keyword }">
					<div class="row g-3">

						<div class="col-6">
							<label for="writer" class="form-label">Writer</label>
							<input type="email" class="form-control" name="writer" id="writer"
								value="${pvo.writer }">
						</div>

						<div class="col-6">
							<label for="regAt" class="form-label">Reg At</label> 
							<input
								type="text" class="form-control" id="regAt"
								value="${pvo.regAt }">
						</div>

						<div class="col-6">
							<label for="modAt" class="form-label">Mod At</label> 
							<input
								type="text" class="form-control" id="modAt"
								value="${pvo.modAt }">
						</div>

						<div class="col-6">
							<label for="readCount" class="form-label">Read Count</label> 
							<input
								type="text" class="form-control" id="readCount"
								value="${pvo.readCount }">
						</div>

						<div class="col-6">
							<label for="title" class="form-label">Title</label> 
							<input
								type="text" class="form-control" name="title" id="title"
								value="${pvo.cmtQty }">
						</div>

						<div class="col-6">
							<label for="pname" class="form-label">Product Name</label> <input
								type="text" class="form-control" name="pname" id="pname"
								value="${pvo.pname }" required>
						</div>

						<div class="col-12">
							<label for="desc" class="form-label">Description</label>
							<textarea class="form-control" name="description" id="desc"
								required>${pvo.description }</textarea>
						</div>

						<div class="col-md-5">
							<label for="madeBy" class="form-label">Made By</label>
							<c:set var="made" value="${pvo.madeBy }" />
							<select class="form-select" id="madeBy" name="madeBy" required>
								<option value="">Choose...</option>
								<option value="us" ${made eq 'us' ? 'selected' : '' }>United
									States</option>
								<option value="ko" ${made eq 'ko' ? 'selected' : '' }>Republic
									of Korea</option>
								<option value="cn" ${made eq 'cn' ? 'selected' : '' }>China</option>
								<option value="eu" ${made eq 'eu' ? 'selected' : '' }>European
									Union</option>
							</select>
						</div>

						<div class="col-md-4">
							<label for="category" class="form-label">Category</label>
							<c:set var="cate" value="${pvo.category }" />
							<select class="form-select" id="category" name="category"
								required>
								<option value="">Choose...</option>
								<option value="Cloth" ${cate eq 'Cloth' ? 'selected' : '' }>Cloth</option>
								<option value="Electronic"
									${cate eq 'Electronic' ? 'selected' : '' }>Electronic</option>
								<option value="Food" ${cate eq 'Food' ? 'selected' : '' }>Food</option>
								<option value="Health" ${cate eq 'Health' ? 'selected' : '' }>Health</option>
								<option value="Media" ${cate eq 'Media' ? 'selected' : '' }>Media</option>
							</select>
							<div class="invalid-feedback">Please provide a valid state.
							</div>
						</div>

						<div class="col-md-3" mt-3>
							<label for="price" class="form-label">Price</label> <input
								type="text" class="form-control" id="price" name="price"
								value="${pvo.price }" required >
						</div>
						
						<!-- 새로 등록한 파일리스트 -->
						<div class="col-12 d-grid">
						  <input class="form-control" type="file" style="display:none;"
						  			id="files" name="files" multiple>
						  <button type="button" id="trigger" class="btn btn-outline-primary btn-block d-block">Files Upload</button>
						</div>
						
						<div class="col-12" id="fileZone">
							
						</div>
						
						<c:set var="FList" value="${pdto.FList }"/>
						
						<!-- 기존에 있던 파일 -->
						<div class="col-12 my-3">
							<ul class="list-group list-group-flush">
							<c:forEach items="${FList }" var="fvo">
							  <li class="list-group-item d-flex justify-content-between align-items-start">
							  <c:choose>
							  	<c:when test="${fvo.fileType > 0 }">
							  	  <div>
							  	    <img src="/upload/${fn:replace(fvo.saveDir, '\\', '/')}/${fvo.uuid }_th_${fvo.fileName}">
							  	  </div>
							  	</c:when>
							  	<c:otherwise>
							  	  <div>
							  	    <!-- 파일아이콘 -->
							  	  </div>
							  	</c:otherwise>
							   </c:choose>
							    <div class="ms-2 me-auto">
							      <div class="fw-bold">${fvo.fileName }</div>
							      ${fvo.regAt }
							    </div>
							    <span class="badge bg-secondary rounded-pill">${fvo.fileSize } Bytes</span>
							    <button type="button" class="btn btn-sm btn-outline-danger py-0 file-x" data-uuid="${fvo.uuid }">X</button>
							  </li>
							</c:forEach>
							</ul>
						</div>
						
						<div class="col-6">
							<a href="/board/list?pageNo=${pgvo.pageNo }&qty=${pgvo.qty}&type=${pgvo.type}&keyword=${pgvo.keyword }" class="w-100 btn btn-outline-primary">Back to List</a>
						</div>
						<div class="col-6">
							<button type="submit" class="w-100 btn btn-outline-warning" id="regBtn">Modify</button>
						</div>
					</div>
					<!-- 게시글 수정란 끝 -->
				</form>
			</div>
		</div>
	</main>
</div>
<script src="/resources/js/product.register.js"></script>
<script src="/resources/js/product.modify.js"></script>
<jsp:include page="../common/footer.jsp" />