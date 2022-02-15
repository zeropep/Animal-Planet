<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/nav.jsp" />

<div class="wrapper light-wrapper">
	<div class="container inner pt-60">
		<div class="row">
			<aside class="col-md-3 mt-90 pr-30">
				<!-- sidebar -->
				<nav class="sidebar sidebar-light rounded bg-white p-3">
					<div class="sidebar-menu">
						<!-- menu -->
						<ul class="list list-unstyled list-scrollbar">
							<!-- simple menu -->
							<li class="list-item">
								<!-- list title -->
								<p class="list-title text-uppercase border-bottom"><a href="/freeboard/list?bCate=free">자유게시판</a></p>
							</li>
							<li class="list-item">
								<!-- list title -->
								<p class="list-title text-uppercase border-bottom">
									<a href="/parcelboard/list?bCate=parcel">분양게시판</a>
								</p> <!-- list items, first level -->
								<ul class="list-unstyled mt-0">
									<li><a href="/parcelboard/list?bCate=parcel&species=Dog"
										class="list-link">강아지</a></li>
									<li><a href="/parcelboard/list?bCate=parcel&species=Cat"
										class="list-link">고양이</a></li>
									<li><a href="/parcelboard/list?bCate=parcel&species=Etc"
										class="list-link">기타</a></li>
									<li>
								</ul>
							</li>
							<li class="list-item mt-10">
								<!-- list title -->
								<p class="list-title text-uppercase border-bottom"><a href="/lostboard/list?bCate=lost">분실게시판</a></p> <!-- list items, first level -->
								<ul class="list-unstyled mt-0">
									<li><a href="/lostboard/list?bCate=lost&species=Dog" class="list-link">강아지</a></li>
									<li><a href="/lostboard/list?bCate=lost&species=Cat" class="list-link">고양이</a></li>
									<li><a href="/lostboard/list?bCate=lost&species=Etc" class="list-link">기타</a></li>
									<li>
								</ul>
							</li>
						</ul>
					</div>
				</nav>
				<!--/.box -->
			</aside>
			<div class="col-md-9">
				<h2 class="section-title">분양게시판</h2>
				<p class="float-left">${pgn.totalCount }개의 글</p>
<c:if test="${ses.email ne '' && ses.email ne null  }">
				<a class="btn btn-outline-primary float-right m-0"
					href="/parcelboard/register">글쓰기</a>
</c:if>
				<div class="form-container w-100 mt-100">
					<div class="row">
						<table class="table table-hover">
							<thead>
								<tr class="">
									<th scope="col" class="col-md-1 small p-0"></th>
									<th scope="col" class="col-md-4 small p-0">제목</th>
									<th scope="col" class="col-md-1 text-left small p-0">작성자</th>
									<th scope="col" class="col-md-1 text-center small p-0">작성일</th>
									<th scope="col" class="col-md-1 text-center small p-0">조회수</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${list }" var="bvo">
									<tr class="border-bottom">
										<th scope="row" class="small">
										<c:choose>
											<c:when test="${bvo.getBTag() eq 'ing'}"><a href="/parcelboard/list?bCate=parcel&bTag=${bvo.getBTag() }">[분양 중]</a> </c:when>
											<c:when test="${bvo.getBTag() eq 'reserved'}"><a href="/parcelboard/list?bCate=parcel&bTag=${bvo.getBTag() }">[분양 예약]</a></c:when>
											<c:when test="${bvo.getBTag() eq 'done'}"><a href="/parcelboard/list?bCate=parcel&bTag=${bvo.getBTag() }">[분양 완료]</a></c:when>
										</c:choose>
										</th>
										<td class="small"><a
											href="/parcelboard/detail?bno=${bvo.bno }">${bvo.title }</a></td>
										<td class="small">${bvo.nickName }</td>
										<td class="small">${bvo.regAt}</td>
										<td class="small">${bvo.readCount }</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>

						<div class="pagination bg text-center w-100">
							<ul class="pagination justify-content-center">
								<c:if test="${pgn.prev }">
									<li class=""><a
										href="/parcelboard/list?bCate=parcel&species=${pgn.pgvo.species }&bTag=${pgn.pgvo.getBTag() }&pageNo=${pgn.startPage - 1 }&qty=${pgn.pgvo.qty}&type=${pgn.pgvo.type}&keyword=${pgn.pgvo.keyword}"
										class="page-link">Prev</a></li>
								</c:if>
								<c:forEach begin="${pgn.startPage }" end="${pgn.endPage }"
									var="i">
									<li class=" ${pgn.pgvo.pageNo == i ? 'active':''}"
										aria-current="page"><a class="page-link"
										href="/parcelboard/list?bCate=parcel&species=${pgn.pgvo.species }&bTag=${pgn.pgvo.getBTag() }&pageNo=${i }&qty=${pgn.pgvo.qty}&type=${pgn.pgvo.type}&keyword=${pgn.pgvo.keyword}">${i }</a>
									</li>
								</c:forEach>
								<c:if test="${pgn.next }">
									<li class=""><a class="page-link"
										href="/parcelboard/list?bCate=parcel&species=${pgn.pgvo.species }&bTag=${pgn.pgvo.getBTag() }&pageNo=${pgn.endPage + 1 }&qty=${pgn.pgvo.qty}&type=${pgn.pgvo.type}&keyword=${pgn.pgvo.keyword}">Next</a>
									</li>
								</c:if>
							</ul>
							<div class="w-100 align-content-md-center text-center mt-10">
								<form action="/parcelboard/list?bCate=parcel&species=${pgn.pgvo.species }" method="get">
									<c:set value="${pgn.pgvo.type }" var="typed" />
									<select class="form-select w-25" name="type">
										<option ${typed == null ? 'selected':'' }>Choose...</option>
										<option value="t" ${typed eq 't' ? 'selected':'' }>Title</option>
										<option value="c" ${typed eq 'c' ? 'selected':'' }>Content</option>
										<option value="w" ${typed eq 'w' ? 'selected':'' }>Writer</option>
										<option value="tc" ${typed eq 'tc' ? 'selected':'' }>Title
											or Content</option>
										<option value="tw" ${typed eq 'tw' ? 'selected':'' }>Title
											or Writer</option>
										<option value="cw" ${typed eq 'cw' ? 'selected':'' }>Content
											or Writer</option>
									</select> <input class="form-control w-25" type="text" name="keyword"
										placeholder="Search" value="${pgn.pgvo.keyword }"> <input
										type="hidden" name="pageNo" value="1"> <input
										type="hidden" name="qty" value="${pgn.pgvo.qty }">
									<button type="submit"
										class="btn btn-success position-relative m-0">검색
									</button>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>



<script>
	let isUp = '<c:out value="${isUp}"/>';
	let isDel = '<c:out value="${isDel}"/>';
	if (parseInt(isUp)) {
		alert('게시글 등록 성공~');
	}
	if (parseInt(isDel)) {
		alert('게시글 삭제 성공~');
	}
</script>
<jsp:include page="../common/footer.jsp" />