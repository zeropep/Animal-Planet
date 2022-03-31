<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


    <footer class="dark-wrapper inverse-text">
        <div class="container inner pt-30 pb-30 text-center">
          <c:set var="today" value="<%=new java.util.Date()%>" />
          <c:set var="date"><fmt:formatDate value="${today}" pattern="yyyy" /></c:set>
          <p class="text-center mb-0">©${date } Animal Planet. All rights reserved.</p>
        </div>
        <!-- /.container -->
      </footer>
  </div>
  <!-- /.content-wrapper -->

</body>
</html>