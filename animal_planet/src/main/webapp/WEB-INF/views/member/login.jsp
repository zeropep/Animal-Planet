<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
      <link rel="shortcut icon" href="/resources/style/images/favicon.png">
  <title>Missio</title>
 
 <link rel="stylesheet" type="text/css" href="/resources/style/css/bootstrap.min.css">
  <link rel="stylesheet" type="text/css" href="/resources/style/css/plugins.css">
  <link rel="stylesheet" type="text/css" href="/resources/style/revolution/css/settings.css">
  <link rel="stylesheet" type="text/css" href="/resources/style/revolution/css/layers.css">
  <link rel="stylesheet" type="text/css" href="/resources/style/revolution/css/navigation.css">
  <link rel="stylesheet" type="text/css" href="/resources/style/type/icons.css">
  <link rel="stylesheet" type="text/css" href="/resources/style/style.css">
  <link rel="stylesheet" type="text/css" href="/resources/style/css/color/lavender.css">
    


 
  </head>
  <body>
  
  <div class="wrapper" style="background-color:#f2f2f2;height:100vh">
      <div class="container inner">
        <div class="row">
          <div class="col-lg-3 mx-auto shadow p-4 mt-40" style="background-color:#fff;border-radius:10px;">
            <h2 class="section-title mb-40 text-center">로그인</h2>
            <form action="/member/login" method="post" class=mx-auto>
              <div class="form-group">
                <label for="exampleInputName1">이메일</label>
                <input type="text" class="form-control" name="email" id="email" placeholder="example@example.com">
              </div>
              <!-- /.form-group -->
              <div class="form-group mb-30">
                <label for="exampleInputEmail1">비밀번호</label>
                <input type="password" class="form-control" name="pwd" id="pwd" placeholder="비밀번호를 입력하세요">
              </div>
           
              <!-- /.form-group -->
              <div class="form-group text-center">
              <button type="submit" class="btn w-100 m-0">로그인</button>
              </div>
              
              <div class="form-group text-center">
               <a href="/member/findPwd">비밀번호 찾기 &rarr;</a>
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
