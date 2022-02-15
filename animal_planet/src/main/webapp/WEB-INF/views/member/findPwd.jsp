<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/nav.jsp" />


 <div class="wrapper light-wrapper h-100">
      <div class="container inner">
        <div class="row">
          <div class="col-lg-10 offset-lg-1 col-xl-8 offset-xl-2">
            <h2 class="section-title mb-40 text-center">비밀번호 찾기</h2>
            <form action="/member/findPwd" name="findPwd" method="post" >
              <div class="form-group">
                <label for="email">이메일</label>
                <input type="text" id="email" name="email" value=""  class="form-control" placeholder="이메일을 입력해주세요." required >
              </div>
              <!-- /.form-group -->
              <div class="form-group">
                <label for="phoneNumber">연락처</label>
                <input type="text" id="phoneNumber" name="phoneNumber" value=""  class="form-control" placeholder="-없이 입력해주세요." required >
              </div>
           
              <!-- /.form-group -->
              <div class="form-group text-center">
              <button class="w-100 btn btn-lg btn-primary" type="submit">비밀번호 찾기</button>
              </div>
              
            </form>
            <!-- /form -->
          </div>
          <!-- /column -->
        </div>
        <!-- /.row -->
      </div>
      <!-- /.container -->
    </div>
  


    
  </body>

</html>