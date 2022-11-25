<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%-- 로그인한 사용자 정보 Authentication 객체의 필요한 property 들을 변수에 담아 사용 가능  --%>
<sec:authentication property="name" var="username"/>  
<sec:authentication property="authorities" var="authorities"/> 
<sec:authentication property="principal" var="userdetails"/> 

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<link href="/css/itemDetail.css" rel="stylesheet">
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<jsp:include page="/WEB-INF/views/common/header2.jsp" />

	<c:forEach var="item" items="${itemList }">
		이름 <p>${item.name }</p>
		내용 <p>${item.content }</p>
		할인율 <p>${item.discount }</p>
		할인된가격 <p>${item.price*(100-i.discount)/100}</p>
		원가 <p>${item.price}</p>
		색깔 <p>${item.colors[0].color }</p>
		<!-- 색깔 갯수 for 돌려야함 -->
		리뷰갯수 <p>${item.reviewcnt }</p>
		사이즈 <p>${item.sizes[0].name }</p>
		<!-- 사이즈 갯수 for 돌려야함 -->

	</c:forEach>
<div id="wrap">
	<div id="wrap_left">	
		<div id="demo" class="carousel slide w-30" data-bs-ride="carousel">
			<div class="carousel-inner w-30">
				<c:forEach var="contentfile" items="${contentFileList }">
				<div class="carousel-item active">
						<img id="big_imgSize" src="${pageContext.request.contextPath }/upload/${contentfile.file}" alt=".." class="d-block">
				</div>
				</c:forEach>	
			</div>
			<button class="carousel-control-prev" type="button"
				data-bs-target="#demo" data-bs-slide="prev">
				<span class="carousel-control-prev-icon"></span>
			</button>
			<button class="carousel-control-next" type="button"
				data-bs-target="#demo" data-bs-slide="next">
				<span class="carousel-control-next-icon"></span>
			</button>
		</div>
		
		<div>
			<c:forEach var="contentfile" items="${contentFileList }">
			<div>
				<img id="small_imgSize"src="${pageContext.request.contextPath }/upload/${contentfile.file}"
						alt="Chicago" class="d-block">
			</div>
			</c:forEach>
		</div>
	</div>

<!-- 정보페이지 -->	
<div class="container" style="width: 800px; height: hidden; margin-right: 0;">
    <div class="row align-items-md-stretch">
      <div class="col-lg-12">
        <div class="h-100 p-5 rounded-3">
          <div class="box-2">
            <div class="box-inner-2">
                <div>
                    <h2 class="fw-bold">${itemList[0].name }</h2>
                </div>
                <br>
                <form name="getReserve" action="reservOk" method="post">
                	<span style="text-decoration : line-through;">${itemList[0].price }원</span><br>
                	<span style="font-size:1.5rem; margin-right:1rem; color: hotpink;">${itemList[0].discount }<span style="font-size: 1rem;">%</span></span> 
                	<span style="font-size:1.5rem; font-weight: bold; font-weight: bold;">${itemList[0].price*(100-itemList[0].discount)/100}<span style="font-size: 1rem; font-weight: bold;">원</span></span>
                	<hr>
                	<fieldset class="form-group">
				    <div class="row">
				      <p class="col-form-label col-sm-2 pt-0">색상</p>
				      <div class="col-sm-10">
				        <div class="form-check">
				          <input class="form-check-input" type="radio" name="gridRadios" id="gridRadios1" value="option1" checked>
				          <label class="form-check-label" for="gridRadios1">
				            blue
				          </label>
				        </div>
				        <div class="form-check">
				          <input class="form-check-input" type="radio" name="gridRadios" id="gridRadios2" value="option2">
				          <label class="form-check-label" for="gridRadios2">
				            red
				          </label>
				        </div>
				      </div>
				    </div>
				  </fieldset>
				  <hr>
				  <fieldset class="form-group">
				    <div class="row">
				      <p class="col-form-label col-sm-2 pt-0">사이즈</p>
				      <div class="col-sm-10">
				        <div class="form-check">
				          <input class="form-check-input" type="radio" name="gridRadios" id="gridRadios1" value="option1" checked>
				          <label class="form-check-label" for="gridRadios1">
				            M
				          </label>
				        </div>
				        <div class="form-check">
				          <input class="form-check-input" type="radio" name="gridRadios" id="gridRadios2" value="option2">
				          <label class="form-check-label" for="gridRadios2">
				            L
				          </label>
				        </div>
				      </div>
				    </div>
				  </fieldset>
                  <hr>
                  <br>
                  <p style="border:1px solid black;"></p>
                  <h4>총 결제금액</h4> <p>0원</p>
                  
                  <div>
                  <div>장바구니</div>
                  
                  <div>구매하기</div>
                  </div>  
                </form>
               </div>
            </div>
        </div>
        </div>
      </div>
  </div>
</div>		
	<br><br><br><br><br><br><br><br><br>
	


</body>
</html>