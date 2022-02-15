<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<body>
  <div class="content-wrapper">
	<nav class="navbar wide bg-light navbar-expand-lg">
	  <div class="container-fluid flex-row justify-content-center">
	    <div class="navbar-header">
	      <div class="navbar-brand"><a href="/"><img src="#" srcset="/resources/style/images/logo2.png 1x, /resources/style/images/logo2@2x.png 2x" alt="" /></a></div>
	      <div class="navbar-hamburger ml-auto d-lg-none d-xl-none"><button class="hamburger animate" data-toggle="collapse" data-target=".navbar-collapse"><span></span></button></div>
	    </div>
		<div class="navbar-collapse collapse justify-content-between align-items-center">
		  <ul class="navbar-nav plain mx-auto text-center">
		    <li class="nav-item"><a class="nav-link" href="/">Home</a></li>
		    <li class="nav-item dropdown"><a class="nav-link dropdown-toggle" href="#">상품</a>
		      <ul class="dropdown-menu">
		        <li class="nav-item"><a class="dropdown-item" href="/nproduct/list?category1=Dog">개</a></li>
		        <li class="nav-item"><a class="dropdown-item" href="/common/somingSoon">고양이</a></li>
		        <li class="nav-item"><a class="dropdown-item" href="/common/somingSoon">다른 친구들</a></li>
		      </ul>
		    </li>
		    <li class="nav-item dropdown"><a class="nav-link dropdown-toggle" href="#">게시판</a>
		      <ul class="dropdown-menu">
		        <li class="nav-item"><a class="dropdown-item" href="/freeboard/list?bCate=free">자유게시판</a></li>
		        <li class="nav-item"><a class="dropdown-item" href="/parcelboard/list?bCate=parcel">분양게시판</a></li>
		        <li class="nav-item"><a class="dropdown-item" href="/lostboard/list?bCate=lost">분실게시판</a></li>
		      </ul>
		    </li>
		    <li class="nav-item dropdown"><a class="nav-link dropdown-toggle" href="#">병원정보</a>
		      <ul class="dropdown-menu">
		        <li class="nav-item"><a class="dropdown-item" href="/hospital/select">지역 선택</a></li>
		        <li class="nav-item"><a class="dropdown-item" href="/hospital/nearme">내 근처 병원</a></li>
		      </ul>
		    </li>
		  </ul>
		</div>
		
		<ul class="navbar-nav plain mx-auto text-right align-items-center">
		  <c:choose>
        	<c:when test="${ses.email ne null && ses.email ne ''}">
       			<c:choose>
       				<c:when test="${ses.grade > 100 }">
       				<li class="nav-item dropdown"><a class="nav-link dropdown-toggle p-0" href="#">
       				<i class="fa fa-user-circle nav-link dropdown-toggle"></i></a>
				      <ul class="dropdown-menu">
				        <li class="nav-item"><a href="/member/list"  class="dropdown-item">회원 리스트</a></li>
				        <li class="nav-item"><a href="/member/detail?email=${ses.email }"  class="dropdown-item">내 프로필</a></li>
				        <li class="nav-item"><a href="/member/modify?email=${ses.email }&mno=${mvo.mno }"  class="dropdown-item">정보 수정</a></li>
				        <li class="nav-item"><a href="/member/modifyPwd?email=${mvo.email }"  class="dropdown-item">비밀번호 변경</a></li>
				        <li class="nav-item"><a href="/member/myboard?email=${ses.email }" class="dropdown-item">내가 쓴 글</a></li>
				        <li class="nav-item"><a href="/member/myorder?email=${ses.email }"  class="dropdown-item">결제 목록</a></li>
				        <li class="nav-item"><a class="dropdown-item" href="/member/logout">로그아웃</a></li>
				      </ul>
         				</li>
       				<li class="nav-item dropdown"><a class="nav-link dropdown-toggle p-0" href="">
       				<i class="fa fa-shopping-cart nav-link dropdown-toggle"></i></a>
         				</li>
       				</c:when>
       				<c:otherwise>
       				<li class="nav-item dropdown"><a class="nav-link dropdown-toggle p-0" href="/member/detail?email=${ses.email }">
       				<i class="fa fa-user-circle nav-link dropdown-toggle"></i></a>
				      <ul class="dropdown-menu">
				        <li class="nav-item"><a href="/member/detail?email=${ses.email }"  class="dropdown-item">내 프로필</a></li>
				        <li class="nav-item"><a href="/member/modify?email=${ses.email }&mno=${mvo.mno }"  class="dropdown-item">정보 수정</a></li>
				        <li class="nav-item"><a href="/member/detail?email=${ses.email }"  class="dropdown-item">비밀번호 변경</a></li>
				        <li class="nav-item"><a href="/member/myboard?email=${ses.email }"  class="dropdown-item">내가 쓴 글</a></li>
				        <li class="nav-item"><a href="/member/myorder?email=${ses.email }"  class="dropdown-item">결제 목록</a></li>
				        <li class="nav-item"><a class="dropdown-item" href="/member/logout">로그아웃</a></li>
				      </ul>
         				</li>
       				<li class="nav-item dropdown">
       				  <a class="nav-link dropdown-toggle p-0" href="/cart/list?email=${ses.email }"><i class="fa fa-shopping-cart nav-link dropdown-toggle"></i></a>
         				</li>
       				</c:otherwise>
       			</c:choose>
        	</c:when>
        	<c:otherwise>
        		<div class="text-end float-right">
          			<a href="/member/login"  class="btn btn-outline-light me-2 mt-10">로그인</a>
          			<a href="/member/register"  class="btn btn-warning mt-10">회원가입</a>
        		</div>
        	</c:otherwise>
          </c:choose>
		</ul>
		
      </div>
    </nav>
