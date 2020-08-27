<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*, java.util.*" %>
<% request.setCharacterEncoding("UTF-8"); %> <!-- 파라미터 인코딩 -->
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
        <title>한국 중소기업 대상 교육 세미나 정보 검색 시스템 KOSMEC</title>
    </head>
    <body>
        <h1>한국 중소기업 대상 교육 세미나 정보 검색 시스템 KOSMEC</h1>
        <h2>dongguk computer 정재환 2015211051</h2>
        
        <div class="w3-card-4">
		  <div class="w3-container w3-brown">
		    <h2>세미나 통합검색</h2>
		  </div>
		  <form class="w3-container" name=search action="list" method=post>
		    <p>      
		    	<label class="w3-text-brown"><b>제목</b></label>
		    	<input class="w3-input w3-border w3-sand" type= "text" name="search_title" value="" size="40" maxlength="100">
		    </p>
		    <p>      
		    	<label class="w3-text-brown"><b>분야</b></label>
		    	<input class="w3-input w3-border w3-sand" type="text" name="search_field" value="" maxlength="25">
		    </p>
		    <p>      
		    	<label class="w3-text-brown"><b>지역</b></label>
		    	<input class="w3-input w3-border w3-sand" type="text" name="search_area" value="" maxlength="25">
		    </p>
		    <p>
		    	<button class="w3-btn w3-brown"><input type="submit" name="search_field" value="검색"></button></p>
		  </form>
		</div>
    </body>
</html>