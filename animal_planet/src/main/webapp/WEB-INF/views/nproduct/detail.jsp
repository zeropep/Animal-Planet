<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/nav.jsp" />

	<c:set var="npvo" value="${pdto.npvo }"/>
	<c:set var="fList" value="${pdto.FList }"/>

    <div class="wrapper light-wrapper">
      <div class="container inner pt-60">
        <div class="boxed">
          <div class="bg-white shadow rounded">
            <div class="image-block-wrapper">
              <div class="image-block col-lg-6">
                <c:choose>
                  <c:when test="${fList.size() > 0 }" >
                    <div class="image-block-bg bg-image" data-image-src="/upload/${fn:replace(fList[0].saveDir,'\\','/')}/${fList[0].uuid }_${fList[0].fileName}"></div>
                  </c:when>
                  <c:otherwise>
                    <div class="image-block-bg bg-image" data-image-src="/resources/style/images/art/g1.jpg"></div>
                  </c:otherwise>
                </c:choose>
              </div>
              <!--/.image-block -->
              <div class="container-fluid">
                <div class="row">
                  <div class="col-lg-6 offset-lg-6">
                    <div class="box">
                      <div class="align-self-center text-center">
                        <h3 class="">${npvo.pname }</h3>
                        <input type="hidden" value="${npvo.price }" id="price">
                        <p >${npvo.price } 원 (배송비 : 무료)</p>
                        <hr style="margin-top:10px;margin-bottom:10px;padding:0px;" />
                        <form>
			              <div class="form-group row">
			                <label for="prodName" class="col-sm-2 col-form-label">상품</label>
			                <div class="col-sm-10">
			                  <input type="text" class="form-control" id="prodName" value="${npvo.pname }" readonly>
			                </div>
			              </div>
			              <div class="form-group row">
			                <label for="buyQty" class="col-sm-2 col-form-label">수량</label>
			                <div class="col-sm-10">
			                  <input type="number" class="form-control" id="buyQty" min="1" value="1">
			                </div>
			              </div>
                        <hr style="margin-top:10px;margin-bottom:10px;padding:0px;" />
                        <p id="total">총 가격 : ${npvo.price * 1 } 원</p>
                        <button type="button" class="btn" id="buy">결제하기</button>
                        <button type="button" class="btn" id="cart">장바구니</button>
			            </form>
                      </div>
                    </div>
                    <!-- /.box -->
                  </div>
                  <!--/column -->
                </div>
                <!--/.row -->
              </div>
              <!--/.container-fluid -->
            </div>
            <!--/.image-block-wrapper -->
          </div>
          <!-- /.bg -->
        </div>
        <!-- /.boxed -->
      </div>
      <!-- /.container -->
    </div>
    <!-- /.wrapper -->
    
        <!-- /.wrapper -->
    <div class="wrapper light-wrapper">
      <div class="container">
        <div class="row">
            <div class="tabs-wrapper bg-white shadow col-12 mb-40">
              <ul class="nav nav-tabs">
                <li class="nav-item"> <a class="nav-link active" data-toggle="tab" href="#tab1-1">제품정보</a> </li>
                <li class="nav-item"> <a class="nav-link" data-toggle="tab" href="#tab1-2">리뷰</a> </li>
              </ul>
              <!-- /.nav-tabs -->
              <div class="tab-content col-12">
                <div class="tab-pane fade show active" id="tab1-1">
                  <div class="col-12" style="background-color:#fff;min-height:400px">
		            ${npvo.description }          
		          </div>
                </div>
                <div class="tab-pane fade" id="tab1-2">
                    <div class="row">
			          <div class="col-lg-12">
			            <form>
			              <div class="form-group row" id="comment">
<c:if test="${ses.email ne '' && ses.email ne null  }">
			                <label for="inputEmail3" class="col-sm-2 col-form-label" id="cmtWriter">${ses.nickName }</label>
			                <div class="col-sm-8">
			                  <input type="email" class="form-control" id="cmtText" placeholder="Add Comment">
			                </div>
			                <button class="btn btn-success position-relative col-sm-1" type="button" id="cmtPostBtn">등록</button>
			                <button class="btn btn-pastel-yellow position-relative col-sm-1 hidden" data-cno="" 
			                type="button" id="cmtModBtn">Modify</button>
</c:if>
			              </div>
			            </form>
			          </div>
			          <div class="col-lg-12 mb-40">
			            <div class="list-group shadow" id="cmtArea"></div>
			<!--             <ul class="list-group list-group-flush" id="cmtArea">
			              <li></li>
			            </ul> -->
			          </div>
			          <div class="col-lg-12 mb-40">
			           	<div class="pagination bg text-center" id="cmtPaging"></div>
			          </div>
			          <!-- /column -->
			        </div>
			        <!-- /.row -->
                </div>
              </div>
              <!-- /.tab-content -->
            </div>
            <!-- /.tabs-wrapper -->
	            <div class="col-lg-12">
					<a href="/nproduct/list?category1=Dog&pageNo=${pgvo.pageNo }&qty=${pgvo.qty}&type=${pgn.pgvo.type}&keyword=${pgn.pgvo.keyword }" class="w-100 btn">Back to List</a>
				</div>
<c:if test="${ses.grade eq 100  }">
				<div class="col-lg-12">
					<a href="/nproduct/modify?npno=${npvo.npno }&pageNo=${pgvo.pageNo }&qty=${pgvo.qty}&type=${pgn.pgvo.type}&keyword=${pgn.pgvo.keyword }" type="button" class="w-100 btn btn-yellow" id="modBtn">MOD</a>						
				</div>
</c:if>
        </div>
        <!-- /.row -->
      </div>
      <!-- /.container -->
    </div>
    <!-- /.wrapper -->

<script>
	const npnoVal = '<c:out value="${npvo.npno}"/>';
</script>
<script src="/resources/js/product/product.comment.js"></script>
<script src="/resources/js/product/product.purchase.js"></script>
<script>
	let isMod = '<c:out value="${isMod}"/>';
	if (parseInt(isMod)) {
		alert("상품수정 성공");
	}
	getCommentList(npnoVal);
</script>
<jsp:include page="../common/footer.jsp" />