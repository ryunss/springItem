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
<html lang="ko">
 
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta
      name="viewport"
      content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1"
    />
    <!-- Link Swiper's CSS -->
    <link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/swiper/swiper-bundle.min.css"
    />

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
 
 	<script src="https://kit.fontawesome.com/51772bd9bd.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <link href="/css/itemList.css" rel="stylesheet">

    <title>목록</title>
</head>
 
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	
	<div class="swiper mySwiper">
      <div class="swiper-wrapper">
        <div class="swiper-slide">
          <img src="${pageContext.request.contextPath }/upload/1.jpg"
          />
        </div>
        <div class="swiper-slide">
          <img
            src="${pageContext.request.contextPath }/upload/2.jpg"
          />
        </div>
        <div class="swiper-slide">
          <img
            src="${pageContext.request.contextPath }/upload/3.jpg"
          />
        </div>
        <div class="swiper-slide">
          <img
            src="${pageContext.request.contextPath }/upload/1.jpg"
          />
        </div>
        <div class="swiper-slide">
          <img
            src="${pageContext.request.contextPath }/upload/2.jpg"
          />
        </div>
        <div class="swiper-slide">
          <img
            src="${pageContext.request.contextPath }/upload/3.jpg"
          />
        </div>
        <div class="swiper-slide">
          <img
            src="${pageContext.request.contextPath }/upload/1.jpg"
          />
        </div>
        <div class="swiper-slide">
          <img
            src="${pageContext.request.contextPath }/upload/2.jpg"
          />
        </div>
        <div class="swiper-slide">
          <img
            src="${pageContext.request.contextPath }/upload/3.jpg"
          />
        </div>
      </div>
      <div class="swiper-button-next"></div>
      <div class="swiper-button-prev"></div>
      <div class="swiper-scrollbar"></div>
      <div class="swiper-pagination"></div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/swiper/swiper-bundle.min.js"></script>
	<script src="/js/mainItemList.js"></script>
	
	<c:forEach var="category" items="${categoryList }">
		<p>${category.name }</p>
		
	</c:forEach>
	
	<c:forEach var="tag" items="${tagList }">
			<p>${tag.name }</p>
	</c:forEach>
	<hr>
	<c:forEach var="tags" items="${tagList }">
	
		<img
            src="${pageContext.request.contextPath }/upload/${tags.items[0].itemfiles[0].file }"
            alt="..."
          />
		<p>${tags.items[0].name }</p>
		<p>${tags.items[0].price }</p>
	</c:forEach>

</body>
</html>
 

