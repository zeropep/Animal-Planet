<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/nav.jsp" />

<div class="container">
  <main>
    <div class="py-5 text-center">
      <h2>회원가입</h2>
    </div>

  
      
<!-- 회원등록란 시작 -->
      <div class="col-md-7 col-lg-8 m-auto">
        <p><i class="fa fa-paw fa-lg mr-15"></i>회원님의 정보를 입력해주세요</p>
        <form action="/member/register" method="post">
          <div class="row g-3">

            <div class="col-12">
              <label for="email" class="form-label">이메일</label>
              <div class="form-group row">
                <div class="col-sm-9">
                  <input type="email" class="form-control" name="email"
                  id="email" placeholder="사용하는 이메일을 입력해주세요. 비밀번호 찾기 및 변경 시 사용됩니다."  required>
                </div>
                <div class="col-sm-3 text-right">
                  <button type="button" class="btn btn-success" id="dupleCheck">중복확인</button>              
                </div>
              </div>
            </div>

            
            
            <div class="col-sm-6">
              <label for="pwd" class="form-label">비밀번호</label>
              <input type="password" class="form-control" name="pwd" pattern=".{4,12}"
               id="pwd" placeholder="4자리이상 입력해주세요." required>              
            </div>

            <div class="col-sm-6">
              <label for="rpwd" class="form-label">비밀번호 확인</label>
              <input type="password" class="form-control" pattern=".{4,12}"
              id="rpwd" placeholder="" value="" required>
            </div>

			<div class="col-12">
              <label for="name" class="form-label">이름</label>
              <input type="text" class="form-control" name="name"
               id="name" placeholder="Name" required>              
            </div>
            
            <div class="col-12">
              <label for="nickName" class="form-label">닉네임</label>
              <input type="text" class="form-control" name="nickName"
               id="nickName" placeholder="nickName" required>              
            </div>
            
            <div class="col-sm-12">
              <label for="phoneNumber" class="form-label">전화번호</label>
              <input type="text" class="form-control" name="phoneNumber"
               id="phoneNumber" placeholder="연락처는 '-'표시를 제외하고 입력해주세요. 예)01012345678" value="" required>              
            </div>
            
            
             <div class="col-sm-6">
              <label for="address" class="form-label">도로명/지번주소</label>
              <input type="text" class="form-control" name="address"
               id="address" placeholder="도로명/지번주소를 입력하세요" value="" required>              
            </div>

            <div class="col-sm-6">
              <label for="address_detail" class="form-label">상세주소</label>
              <input type="text" class="form-control" name="addressDetail"
              id="addressDetail" placeholder="상세주소를 입력하세요" value="" required>
            </div>
            </div>

          <button class="w-100 btn btn-primary btn-lg my-5" type="submit">회원가입 하기</button>
        </form>
      </div>
    </div>
  </main>
</div>

<script src="/resources/js/member/member.register.js"></script>
<jsp:include page="../common/footer.jsp" />