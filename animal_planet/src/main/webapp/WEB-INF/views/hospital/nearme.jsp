<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    response.addHeader("Access-Control-Allow-Origin", "*");
%>

<jsp:include page="../common/header.jsp"/>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=6baf0b55357c98fcbb127a575fed03bf&libraries=services"></script>
<jsp:include page="../common/nav.jsp"/>

    <div class="wrapper light-wrapper">
      <div class="container inner">
        <h2 class="section-title mb-40 text-center">내 근처 병원</h2>
        <div class="row">
          <div class="col-lg-12">
          	<p>※ 마커 클릭시 병원 이름과 링크가 표시됩니다.</p>
			<div id="map" style="width:100%;height:500px;"></div>
          </div>
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

<script src="/resources/js/hospital/hospital.nearme.js"></script>

<jsp:include page="../common/footer.jsp"/>