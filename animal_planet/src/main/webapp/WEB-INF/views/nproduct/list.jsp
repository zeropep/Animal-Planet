<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/nav.jsp" />

   <div class="wrapper light-wrapper">
      <div class="container inner">
        <h2 class="section-title mb-40 text-center">강아지</h2>
        <div class="row">
          <div class="col-lg-2">
          
             <div id="accordion1" class="accordion-wrapper">
              <div class="card bg-white shadow">
                <div class="card-header">
                  <h3> <a data-toggle="collapse" data-parent="#accordion1" href="#collapse1-1">개</a> </h3>
                </div>
                <!-- /.card-header -->
                <div id="collapse1-1" class="collapse">
                  <div class="card-block">
                    <div class="list-group shadow" id="list-tab" role="tablist"> 
		              <a class="list-group-item list-group-item-action ${opn eq '3000000' ? 'active' : '' }" id="list-home-list" href="/nproduct/list?category1=Dog&category2=Food" role="tab">사료</a> 
		              <a class="list-group-item list-group-item-action ${opn eq '3010000' ? 'active' : '' }" id="list-home-list" href="/nproduct/list?category1=Dog&category2=Snack" role="tab">간식</a> 
		              <a class="list-group-item list-group-item-action ${opn eq '3020000' ? 'active' : '' }" id="list-home-list" href="/nproduct/list?category1=Dog&category2=Nutrient" role="tab">영양제</a> 
		              <a class="list-group-item list-group-item-action ${opn eq '3030000' ? 'active' : '' }" id="list-home-list" href="/nproduct/list?category1=Dog&category2=Supplies" role="tab">각종용품</a> 
		            </div>
                  </div>
                  <!-- /.card-block -->
                </div>
                <!-- /.collapse -->
              </div>
              <!-- /.card -->
              <div class="card bg-white shadow">
                <div class="card-header">
                  <h3> <a class="collapsed" data-toggle="collapse" data-parent="#accordion1" href="#collapse1-2">고양이</a> </h3>
                </div>
                <!-- /.card-header -->
                <div id="collapse1-2" class="collapse">
                  <div class="card-block">
                    <div class="list-group shadow" id="list-tab" role="tablist"> 
                       <a class="list-group-item list-group-item-action" id="list-home-list" href="/common/somingSoon" role="tab">사료</a>
                       <a class="list-group-item list-group-item-action" id="list-home-list" href="/common/somingSoon" role="tab">간식</a>
                       <a class="list-group-item list-group-item-action" id="list-home-list" href="/common/somingSoon" role="tab">영양제</a>
                       <a class="list-group-item list-group-item-action" id="list-home-list" href="/common/somingSoon" role="tab">각종용품</a>
		            </div>
                  </div>
                  <!-- /.card-block -->
                </div>
                <!-- /.collapse -->
              </div>
              <!-- /.card -->
              <div class="card bg-white shadow">
                <div class="card-header">
                  <h3> <a class="collapsed" data-toggle="collapse" data-parent="#accordion1" href="#collapse1-3">다른 친구들</a> </h3>
                </div>
                <!-- /.card-header -->
                <div id="collapse1-3" class="collapse">
                  <div class="card-block">
                    <div class="list-group shadow" id="list-tab" role="tablist"> 
                       <a class="list-group-item list-group-item-action" id="list-home-list" href="/common/somingSoon" role="tab">산책용품</a>
                       <a class="list-group-item list-group-item-action" id="list-home-list" href="/common/somingSoon" role="tab">리빙</a>
                       <a class="list-group-item list-group-item-action" id="list-home-list" href="/common/somingSoon" role="tab">급식/수기</a>
                       <a class="list-group-item list-group-item-action" id="list-home-list" href="/common/somingSoon" role="tab">의류</a>
		            </div>
                  </div>
                  <!-- /.card-block -->
                </div>
                <!-- /.collapse -->
              </div>
              <!-- /.card -->
            </div>
            <!-- /.accordion-wrapper -->
            
          </div>
          <div class="col-lg-10 mb-30">
	       <div class="container">
	          <div class="row">
			    <div class="col-sm-12 col-md-6">
<c:if test="${ses.grade eq 100  }">
					<a href="/nproduct/register" class="btn btn-primary" id="mapView">새 아이템 넣기</a>
</c:if>
			    </div>
			    <div class="col-12 mb-20">
				<p class="float-left small">${pgn.totalCount }개의 상품</p>
			      <form action="/nproduct/list" method="GET" class="form-inline float-right">
			      <div class="row">
			      <c:set value="${pgn.pgvo.type }" var="typed"></c:set>
			  		<select class="form-select" name="type" style="width:40%;">
			    	  <option ${typed == null ? 'selected' : '' }>Choose...</option>
			    	  <option value="n" ${typed eq 'n' ? 'selected' : '' }>상품명</option>
			    	  <option value="d" ${typed eq 'd' ? 'selected' : '' }>제품상세</option>
			    	  <option value="m" ${typed eq 'm' ? 'selected' : '' }>제조국</option>
			    	  <option value="nd" ${typed eq 'nd' ? 'selected' : '' }>상품명 또는 제품상세</option>
			    	  <option value="dm" ${typed eq 'dm' ? 'selected' : '' }>제품상세 또는 제조국</option>
			    	  <option value="nm" ${typed eq 'nm' ? 'selected' : '' }>상품명 또는 제조국</option>
			  		</select>
			  		<input type="hidden" name="pageNo" value="1">
			  		<input type="hidden" name="qty" value="${pgn.pgvo.qty }">
			        <input type="text" class="form-control" name="keyword" placeholder="Search" value="${pgn.pgvo.keyword }" style="width:40%;overflow:hidden;">
			  		<button type="submit" class="btn btn-success position-relative">검색
			  		</button>
				  </div>
				  </form>
			    </div>
			  </div>
			  
				<div class="tiles grid">
		          <div class="items row isotope boxed grid-view text-center">
		            <c:forEach items="${list }" var="pdto">
		            <div class="item grid-sizer col-md-6 col-lg-4">
		              <div class="box bg-white shadow p-30">
		                <figure class="main polaroid overlay overlay1">
		                  <a href="/nproduct/detail?npno=${pdto.npvo.npno }&pageNo=${pgn.pgvo.pageNo }&qty=${pgn.pgvo.qty}&type=${pgn.pgvo.type}&keyword=${pgn.pgvo.keyword }">
		                    <c:choose>
		                      <c:when test="${pdto.FList.size() > 0 }" >
		                        <img src="/upload/${fn:replace(pdto.FList[0].saveDir,'\\','/')}/${pdto.FList[0].uuid }_${pdto.FList[0].fileName}" alt="" style="height:318px;"/>
		                      </c:when>
		                      <c:otherwise>
		                        <img src="/resources/style/images/art/g1.jpg" alt="" />
		                      </c:otherwise>
		                    </c:choose></a>
			                  <figcaption>
			                    <h5 class="text-uppercase from-top mb-0">See Detail</h5>
			                  </figcaption>
		                </figure>
		                <h4 class="text-uppercase mb-0">${pdto.npvo.pname }</h4>
		                <h6 class="text-uppercase mb-0">${pdto.npvo.price } 원</h6>
		              </div>
		              <!-- /.box -->
		            </div>
		            <!--/.item -->
		            </c:forEach>
		          </div>
		          <!--/.row -->
		        </div>
		        <!-- /.tiles -->
	      </div>
          </div>
          <!-- /column -->
          
          <div class="col-lg-2"></div>
             
          <div class="col-lg-10">
	       <div class="container">
	          <div class="row">
			    <div class="col-12">
				  <div class="">
					<div class="pagination bg text-center">
					  <ul>
					  <c:if test="${pgn.prev }">
					    <li>
					      <a href="/nproduct/list?category1=Dog&pageNo=${pgn.startPage - 1 }&qty=${pgn.pgvo.qty }&type=${pgn.pgvo.type}&keyword=${pgn.pgvo.keyword }" class="btn btn-pastel-default shadow"><i class="mi-arrow-left"></i></a>
					    </li>
					  </c:if>
					  <c:forEach begin="${pgn.startPage }" end="${pgn.endPage }" var="i">
					    <li class="page-item ${pgn.pgvo.pageNo == i ? 'active' : '' }" aria-current="page">
					      <a href="/nproduct/list?category1=Dog&pageNo=${i }&qty=${pgn.pgvo.qty}&type=${pgn.pgvo.type}&keyword=${pgn.pgvo.keyword }" class="btn btn-pastel-default shadow">${i }</a>
					    </li>
					  </c:forEach>
					  <c:if test="${pgn.next }">
					    <li>
					      <a href="/nproduct/list?category1=Dog&pageNo=${pgn.endPage + 1 }&qty=${pgn.pgvo.qty}&type=${pgn.pgvo.type}&keyword=${pgn.pgvo.keyword }" class="btn btn-pastel-default shadow" ><i class="mi-arrow-right"></i></a>
					    </li>
					  </c:if>
					  </ul>
					</div>
				  </div>
			    </div>
			  </div>
			  
	        </div>
          </div>
          <!-- /column -->
          </div>
	      
        </div>
        <!-- /.row -->
      </div>
      <!-- /.container -->
      
<script>
	let isUp = '<c:out value="${isUp}"/>';
	let isDel = '<c:out value="${isDel}"/>';
	if (parseInt(isUp)) {
		alert("상품등록 성공");
	}
	if (parseInt(isDel)) {
		alert("상품삭제 성공");
	}
</script>
<jsp:include page="../common/footer.jsp" />