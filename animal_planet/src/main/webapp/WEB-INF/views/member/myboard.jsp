<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/nav.jsp" />

<main>
	<div class="container inner h-100">
		<div class="row">
			<aside class="col-md-3 mt-10 pr-30">
				<!-- sidebar -->
              <figure class="rounded mb-20">
      			<c:set var="fList"  value="${memberDTO.getFList() }"/>
  				<c:choose>
              		<c:when test="${fList.size() > 0 }">
  						<img src="/upload/${fn:replace(fList.get(0).saveDir,'\\','/')}/${fList.get(0).uuid }_${fList.get(0).fileName}">
  					</c:when>
  					<c:otherwise>
  						<img src="/resources/img/propic0.jpg" alt="" />
  					</c:otherwise>
  				</c:choose></figure>
				<p class="text-bold fa-lg"><i class="fa fa-paw mr-10"></i>${mvo.nickName} 님</p>
            <div class="list-group shadow mt-10"> 
            <a href="/member/detail?email=${ses.email }" class="list-group-item list-group-item-action">내 프로필</a>
            <a href="/member/modifyPwd?email=${ses.email }" class="list-group-item list-group-item-action">비밀번호 변경</a>
            <a href="/member/myboard?email=${ses.email }" class="list-group-item list-group-item-action active">내가 쓴 글</a>
            <a href="/member/myorder?email=${ses.email }" class="list-group-item list-group-item-action">결제 목록</a>
            <a href="/member/resign?email=${ses.email }" class="list-group-item list-group-item-action">회원 탈퇴</a></div>
				<!--/.box -->
			</aside>
          <div class="col-md-9">
 			<div class="space50"></div>
            <div class="form-container">
            <h2 class="section-title text-left">내가 쓴 글</h2>
        <hr class="p-0 m-0"/>
    <div class="wrapper light-wrapper mt-20">
      <div class="container">
			<table class="table table-hover">
				<thead>
					<tr class="text-center">
						<th scope="col" class="col-md-1 small p-0">분류</th>
						<th scope="col" class="col-md-4 small p-0">제목</th>
						<th scope="col" class="col-md-1 small p-0">작성자</th>
						<th scope="col" class="col-md-1 small p-0">작성일</th>
						<th scope="col" class="col-md-1 small p-0">조회수</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${list.size() > 0 }">
							<c:forEach items="${list }" var="bvo">
								<tr class="border-bottom">
									<th scope="row" class="small">
									<c:choose>
										<c:when test="${bvo.getBCate() eq 'free'}">[자유게시판]</c:when>
										<c:when test="${bvo.getBCate() eq 'parcel'}">[분양게시판]</c:when>
										<c:when test="${bvo.getBCate() eq 'lost'}">[분실게시판]</c:when>
									</c:choose>
									</th>
									<td class="small"><a href="/${bvo.getBCate() }board/detail?bno=${bvo.bno }">${bvo.title }</a></td>
									<td class="small text-center">${bvo.nickName }</td>
									<td class="small text-center">${fn:substring(bvo.regAt,0,10) }</td>
									<td class="small text-center">${bvo.readCount }</td>
								</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr class="border-bottom">
								<th scope="row" class="small text-center" colspan="5">등록한 게시물이 없습니다.</th>
							</tr>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
          <!-- /column -->
        <!-- /.row -->
      </div>
      <!-- /.container -->
    </div>
    </div>
  </div>
  			<aside class="col-md-3 mt-10 pr-30">
			</aside>
          <div class="col-md-9">
    <div class="wrapper light-wrapper mt-20">
      <div class="container">

			<div class="pagination bg text-center w-100">
				<ul class="pagination justify-content-center">
					<c:if test="${pgn.prev }">
						<li class=""><a
							href="/member/myboard?email=${ses.email }&pageNo=${pgn.startPage - 1 }&qty=${pgn.pgvo.qty}"
							class="page-link">Prev</a></li>
					</c:if>
					<c:forEach begin="${pgn.startPage }" end="${pgn.endPage }"
						var="i">
						<li class=" ${pgn.pgvo.pageNo == i ? 'active':''}"
							aria-current="page"><a class="page-link"
							href="/member/myboard?email=${ses.email }&pageNo=${i }&qty=${pgn.pgvo.qty}">${i }</a>
						</li>
					</c:forEach>
					<c:if test="${pgn.next }">
						<li class=""><a class="page-link"
							href="/member/myboard?email=${ses.email }&pageNo=${pgn.endPage + 1 }&qty=${pgn.pgvo.qty}">Next</a>
						</li>
					</c:if>
				</ul>
			</div>
          <!-- /column -->
        <!-- /.row -->
      </div>
      <!-- /.container -->
    </div>
    </div>
  </div>
</div>
</div>
</main>

<jsp:include page="../common/footer.jsp" />
