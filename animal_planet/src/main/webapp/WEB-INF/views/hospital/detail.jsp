<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="../common/header.jsp"/>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=6baf0b55357c98fcbb127a575fed03bf&libraries=services"></script>
<jsp:include page="../common/nav.jsp"/>

	<div class="wrapper light-wrapper">
      <div class="container inner">
        <h2 class="section-title mb-40 text-center">${hvo.bplcnm }</h2>
        <div class="grid grid-view">
          <div class="row isotope text-center">
            <div class="item grid-sizer col-md-6 col-lg-4">
              <div class="box bg-pastel-red">
                <div class="icon fs-50 color-dark mb-20"><i class="si-seo_website-code"></i></div>
                <h5>영업 상태</h5>
                <p>${hvo.trdstatenm }</p>
              </div>
            </div>
            <!--/column -->
                        <div class="item grid-sizer col-md-6 col-lg-4">
              <div class="box bg-pastel-leaf">
                <div class="icon fs-50 color-dark mb-20"><i class="si-mail_read-mail"></i></div>
                <h5>전화번호</h5>
                <p>${(hvo.sitetel ne null && hvo.sitetel ne '') ? hvo.sitetel : '-'  }</p>
              </div>
            </div>
            <!--/column -->
            <div class="item grid-sizer col-md-6 col-lg-4">
              <div class="box bg-pastel-meander">
                <div class="icon fs-50 color-dark mb-20"><i class="si-pet_cat"></i></div>
                <h5>데이터 갱신일</h5>
                <p>${(hvo.updatedt ne null && hvo.updatedt ne '') ? hvo.updatedt : '-'  }</p>
              </div>
            </div>
            <!--/column -->
            <div class="item grid-sizer col-md-6 col-lg-4">
              <div class="box bg-pastel-orange">
                <div class="icon fs-50 color-dark mb-20"><i class="si-seo_optimization-growth-stats"></i></div>
                <h5>휴업 시작일</h5>
                <p>${(hvo.clgstdt ne null && hvo.clgstdt ne '') ? hvo.clgstdt : '-'  }</p>
              </div>
            </div>
            <!--/column -->
            <div class="item grid-sizer col-md-6 col-lg-4">
              <div class="box bg-pastel-yellow">
                <div class="icon fs-50 color-dark mb-20"><i class="si-design_color-drop"></i></div>
                <h5>휴업 종료일</h5>
                <p>${(hvo.clgenddt ne null && hvo.clgenddt ne '') ? hvo.clgenddt : '-'  }</p>
              </div>
            </div>
            <!--/column -->
            <div class="space30 d-none d-lg-block clearfix"></div>
            <div class="item grid-sizer col-md-6 col-lg-4">
              <div class="box bg-pastel-green">
                <div class="icon fs-50 color-dark mb-20"><i class="si-camping_life-preserver"></i></div>
                <h5>재개업 일자</h5>
                <p>${(hvo.ropnymd ne null && hvo.ropnymd ne '') ? hvo.ropnymd : '-'  }</p>
              </div>
            </div>
            <!--/column -->
            <div class="item grid-sizer col-md-6 col-lg-4">
              <div class="box bg-pastel-teal">
                <div class="icon fs-50 color-dark mb-20"><i class="si-design_pen-tool"></i></div>
                <h5>지번 주소</h5>
                <p>${(hvo.sitewhladdr ne null && hvo.sitewhladdr ne '') ? hvo.sitewhladdr : '-'  }</p>
              </div>
            </div>
            <!--/column -->
            <div class="space30 d-none d-lg-block clearfix"></div>
            <div class="item grid-sizer col-md-6 col-lg-4">
              <div class="box bg-pastel-aqua">
                <div class="icon fs-50 color-dark mb-20"><i class="si-love_diamond"></i></div>
                <h5>도로명 주소</h5>
                <p>${(hvo.rdnwhladdr ne null && hvo.rdnwhladdr ne '') ? hvo.rdnwhladdr : '-'  }</p>
              </div>
            </div>
            <!--/column -->
          </div>
          <!--/.row -->
        </div>
        <!--/.grid -->
      </div>
      <!-- /.container -->
    </div>
    
    <div class="wrapper light-wrapper">
      <div class="container">
        <div class="row mb-40">
          <div id="map" style="width:1170px;height:500px;"></div>
        </div>
        <!-- /.row -->
      </div>
      <!-- /.container -->
    </div>
    
        <!-- /.wrapper -->
    <div class="wrapper light-wrapper">
      <div class="container mb-40">
        <div class="row">
          <div class="col-lg-12">
            <form>
              <div class="form-group row" id="comment">
                <label for="inputEmail3" class="col-sm-2 col-form-label" id="cmtWriter">Nick name</label>
                <div class="col-sm-8">
                  <input type="email" class="form-control" id="cmtText" placeholder="Add Comment">
                </div>
                <button class="btn btn-success position-relative col-sm-1" type="button" id="cmtPostBtn">Post</button>
                <button class="btn btn-pastel-yellow position-relative col-sm-1 hidden" data-cno="" 
                type="button" id="cmtModBtn">Modify</button>
              </div>
            </form>
          </div>
          <div class="col-lg-12 mb-40">
            <div class="list-group shadow" id="cmtArea"></div>
<!--             <ul class="list-group list-group-flush" id="cmtArea">
              <li></li>
            </ul> -->
          </div>
          <div class="col-lg-12">
           	<div class="pagination bg text-center" id="cmtPaging"></div>
          </div>
          <!-- /column -->
        </div>
        <!-- /.row -->
      </div>
      <!-- /.container -->
    </div>
    <!-- /.wrapper -->
    
    <div class="wrapper light-wrapper">
      <div class="container">
        <a href="/hospital/list?opn=${hvo.opnsfteamcode }&pageNo=${pgvo.pageNo }&qty=${pgvo.qty}&keyword=${pgvo.keyword }" class="w-100 btn btn-outline-primary">Back to List</a>
      </div>
      <!-- /.container -->
    </div>

		<!-- Modal -->
	<div class="modal" id="myModal">
  <div class="modal-dialog">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">Comment</h4>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>

      <!-- Modal body -->
      <div class="modal-body">
       <div class="input-group my-3">
       <input
			type="text" class="form-control" id="cmtTextMod"
			placeholder="Add Comment">
		<button class="btn btn-success" type="button" id="cmtModBtn">Modify</button>
	   </div>
      </div>

    </div>
  </div>
</div>
</div>
<script>
	const hnoVal = '<c:out value="${hvo.hno}"/>';
	const lat = '<c:out value="${hvo.lat}"/>';
	const lon = '<c:out value="${hvo.lon}"/>';
	const bplcnm = '<c:out value="${hvo.bplcnm}"/>';
</script>

<script src="/resources/js/hospital/hospital.detail.js"></script>
<script src="/resources/js/hospital/hospital.comment.js"></script>
<script>
	getCommentList(hnoVal);
</script>
<jsp:include page="../common/footer.jsp"/>