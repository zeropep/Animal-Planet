<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="../common/header.jsp"/>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=6baf0b55357c98fcbb127a575fed03bf&libraries=services"></script>
<jsp:include page="../common/nav.jsp"/>

    <div class="wrapper light-wrapper">
      <div class="container inner">
        <h2 class="section-title mb-40 text-center">지역 병원 리스트</h2>
        <div class="row">
          <div class="col-lg-3">
          
             <div id="accordion1" class="accordion-wrapper">
              <div class="card bg-white shadow">
                <div class="card-header">
                  <h3> <a data-toggle="collapse" data-parent="#accordion1" href="#collapse1-1">강북지역</a> </h3>
                </div>
                <!-- /.card-header -->
                <div id="collapse1-1" class="collapse">
                  <div class="card-block">
                    <div class="list-group shadow" id="list-tab" role="tablist"> 
		              <a class="list-group-item list-group-item-action ${opn eq '3000000' ? 'active' : '' }" id="list-home-list" href="/hospital/list?opn=3000000" role="tab">종로구</a> 
		              <a class="list-group-item list-group-item-action ${opn eq '3010000' ? 'active' : '' }" id="list-home-list" href="/hospital/list?opn=3010000" role="tab">중구</a> 
		              <a class="list-group-item list-group-item-action ${opn eq '3020000' ? 'active' : '' }" id="list-home-list" href="/hospital/list?opn=3020000" role="tab">용산구</a> 
		              <a class="list-group-item list-group-item-action ${opn eq '3030000' ? 'active' : '' }" id="list-home-list" href="/hospital/list?opn=3030000" role="tab">성동구</a> 
		              <a class="list-group-item list-group-item-action ${opn eq '3040000' ? 'active' : '' }" id="list-home-list" href="/hospital/list?opn=3040000" role="tab">광진구</a> 
		              <a class="list-group-item list-group-item-action ${opn eq '3050000' ? 'active' : '' }" id="list-home-list" href="/hospital/list?opn=3050000" role="tab">동대문구</a> 
		              <a class="list-group-item list-group-item-action ${opn eq '3060000' ? 'active' : '' }" id="list-home-list" href="/hospital/list?opn=3060000" role="tab">중랑구</a> 
		              <a class="list-group-item list-group-item-action ${opn eq '3070000' ? 'active' : '' }" id="list-home-list" href="/hospital/list?opn=3070000" role="tab">성북구</a> 
		              <a class="list-group-item list-group-item-action ${opn eq '3080000' ? 'active' : '' }" id="list-home-list" href="/hospital/list?opn=3080000" role="tab">강북구</a> 
		              <a class="list-group-item list-group-item-action ${opn eq '3090000' ? 'active' : '' }" id="list-home-list" href="/hospital/list?opn=3090000" role="tab">도봉구</a> 
		              <a class="list-group-item list-group-item-action ${opn eq '3100000' ? 'active' : '' }" id="list-home-list" href="/hospital/list?opn=3100000" role="tab">노원구</a> 
		              <a class="list-group-item list-group-item-action ${opn eq '3110000' ? 'active' : '' }" id="list-home-list" href="/hospital/list?opn=3110000" role="tab">은평구</a> 
		              <a class="list-group-item list-group-item-action ${opn eq '3120000' ? 'active' : '' }" id="list-home-list" href="/hospital/list?opn=3120000" role="tab">서대문구</a> 
		              <a class="list-group-item list-group-item-action ${opn eq '3130000' ? 'active' : '' }" id="list-home-list" href="/hospital/list?opn=3130000" role="tab">마포구</a> 
		            </div>
                  </div>
                  <!-- /.card-block -->
                </div>
                <!-- /.collapse -->
              </div>
              <!-- /.card -->
              <div class="card bg-white shadow">
                <div class="card-header">
                  <h3> <a class="collapsed" data-toggle="collapse" data-parent="#accordion1" href="#collapse1-2">강남지역</a> </h3>
                </div>
                <!-- /.card-header -->
                <div id="collapse1-2" class="collapse">
                  <div class="card-block">
                    <div class="list-group shadow" id="list-tab" role="tablist"> 
                       <a class="list-group-item list-group-item-action ${opn eq '3140000' ? 'active' : '' }" id="list-home-list" href="/hospital/list?opn=3140000" role="tab">양천구</a>
                       <a class="list-group-item list-group-item-action ${opn eq '3150000' ? 'active' : '' }" id="list-home-list" href="/hospital/list?opn=3150000" role="tab">강서구</a>
                       <a class="list-group-item list-group-item-action ${opn eq '3160000' ? 'active' : '' }" id="list-home-list" href="/hospital/list?opn=3160000" role="tab">구로구</a>
                       <a class="list-group-item list-group-item-action ${opn eq '3170000' ? 'active' : '' }" id="list-home-list" href="/hospital/list?opn=3170000" role="tab">금천구</a>
                       <a class="list-group-item list-group-item-action ${opn eq '3180000' ? 'active' : '' }" id="list-home-list" href="/hospital/list?opn=3180000" role="tab">영등포구</a>
                       <a class="list-group-item list-group-item-action ${opn eq '3190000' ? 'active' : '' }" id="list-home-list" href="/hospital/list?opn=3190000" role="tab">동작구</a>
                       <a class="list-group-item list-group-item-action ${opn eq '3200000' ? 'active' : '' }" id="list-home-list" href="/hospital/list?opn=3200000" role="tab">관악구</a>
                       <a class="list-group-item list-group-item-action ${opn eq '3210000' ? 'active' : '' }" id="list-home-list" href="/hospital/list?opn=3210000" role="tab">서초구</a>
                       <a class="list-group-item list-group-item-action ${opn eq '3220000' ? 'active' : '' }" id="list-home-list" href="/hospital/list?opn=3220000" role="tab">강남구</a>
                       <a class="list-group-item list-group-item-action ${opn eq '3230000' ? 'active' : '' }" id="list-home-list" href="/hospital/list?opn=3230000" role="tab">송파구</a>
                       <a class="list-group-item list-group-item-action ${opn eq '3240000' ? 'active' : '' }" id="list-home-list" href="/hospital/list?opn=3240000" role="tab">강동구</a>
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
          <div class="col-lg-9">
	       <div class="container">
	          <div class="row">
			    <div class="col-sm-12 col-md-6">
					<a href="#map" class="btn btn-primary" id="mapView">지도보기</a>
			    </div>
			    <div class="col-sm-12 col-md-6">
			      <form action="/hospital/list" method="GET" class="form-inline">
			      <div class="row">
			  		<input type="hidden" name="opn" value="${opn }">
			  		<input type="hidden" name="pageNo" value="1">
			  		<input type="hidden" name="qty" value="${pgn.pgvo.qty }">
			  		<input type="text" class="form-control mx-2" name="keyword" placeholder="Search" >
			  		<button type="submit" class="btn btn-success position-relative">Search</button>
				  </div>
				  </form>
			    </div>
			  </div>
			
				<table class="table table-hover mb-40">
				  <thead>
				    <tr>
				      <th scope="col">병원이름</th>
				      <th scope="col">도로명주소</th>
				      <th scope="col">전화번호</th>
				    </tr>
				  </thead>
				  <tbody>
				  	<c:forEach items="${list }" var="hvo">
				    <tr>
				      <td><a href="/hospital/detail?hno=${hvo.hno}&pageNo=${pgn.pgvo.pageNo }&qty=${pgn.pgvo.qty}&type=${pgn.pgvo.type}&keyword=${pgn.pgvo.keyword }">${hvo.bplcnm }</a></td>
				      <td>${(hvo.rdnwhladdr ne null && hvo.rdnwhladdr ne '') ? hvo.rdnwhladdr : hvo.sitewhladdr }</td>
				      <td>${hvo.sitetel }</td>
				    </tr>
				    </c:forEach>
				  </tbody>
				</table>
				
			  <div class="">
				<div class="pagination bg text-center">
				  <ul>
				  <c:if test="${pgn.prev }">
				    <li>
				      <a href="/hospital/list?opn=${opn }&pageNo=${pgn.startPage - 1 }&qty=${pgn.pgvo.qty }&keyword=${pgn.pgvo.keyword }" class="btn btn-pastel-default shadow"><i class="mi-arrow-left"></i></a>
				    </li>
				  </c:if>
				  <c:forEach begin="${pgn.startPage }" end="${pgn.endPage }" var="i">
				    <li class="page-item ${pgn.pgvo.pageNo == i ? 'active' : '' }" aria-current="page">
				      <a href="/hospital/list?opn=${opn }&pageNo=${i }&qty=${pgn.pgvo.qty}&keyword=${pgn.pgvo.keyword }" class="btn btn-pastel-default shadow">${i }</a>
				    </li>
				  </c:forEach>
				  <c:if test="${pgn.next }">
				    <li>
				      <a href="/hospital/list?opn=${opn }&pageNo=${pgn.endPage + 1 }&qty=${pgn.pgvo.qty}&keyword=${pgn.pgvo.keyword }" class="btn btn-pastel-default shadow" ><i class="mi-arrow-right"></i></a>
				    </li>
				  </c:if>
				  </ul>
				</div>
			  </div>
	        <!-- /.row -->
	      </div>
          </div>
          <!-- /column -->
          </div>
	      
        </div>
        <!-- /.row -->
      </div>
      <!-- /.container -->
      
     <div class="wrapper light-wrapper hidden" id="mapContainer">
      <div class="container">
        <div class="row mb-40">
            <div id="map" style="width:1170px;height:500px;"></div>
          <!-- /column -->
        </div>
        <!-- /.row -->
      </div>
      <!-- /.container -->
    </div>

<script>
	let list = [];
	<c:forEach items="${list}" var="hvo">
		list.push({
			hno: '${hvo.hno}',
			name: "${hvo.bplcnm}",
			lat: '${hvo.lat}',
			lon: '${hvo.lon}'
		});
	</c:forEach>
</script>

<script src="/resources/js/hospital/hospital.list.js"></script>
<jsp:include page="../common/footer.jsp"/>