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
        <title>한국 중소기업 대상 교육 세미나 정보 검색 시스템_KOSMEC</title>
        
        <SCRIPT language="JavaScript">
            function Check()
            {
                <!-- 공백이 입력되었을 경우 알림창을 나타내고 다시 입력하도록 한다-->
                if (add.title.value.length < 1) {
                    alert("제목을 입력하세요.");
                    add.title.focus();
                    return false;
                }

                if (add.field.value.length < 1) {
                    alert("분야를 입력하세요.");
                    add.field.focus();
                    return false;
                }
                
                if (add.area.value.length < 1) {
                    alert("지역을 입력하세요.");
                    add.area.focus();
                    return false;
                }
                
                if (add.source.value.length < 1) {
                    alert("출처를 입력하세요.");
                    add.source.focus();
                    return false;
                }
                
                if (add.start_date.value.length < 1) {
                    alert("시작일을 입력하세요.");
                    add.start_date.focus();
                    return false;
                }
                
                if (add.stop_date.value.length < 1) {
                    alert("종료일을 입력하세요.");
                    add.stop_date.focus();
                    return false;
                }
                <!--종료날짜가 시작날짜 보다 빠를 경우-->
                if(add.start_date.value > add.stop_date.value) {
                    alert("시작일과 종료일을 구분하세요");
                    add.start_date.focus();
                    return false;
                }
            }

        </SCRIPT>
    </head>
    
    <body>
        <h1>한국 중소기업 대상 세미나 정보 검색 시스템 KOSMEC</h1>
        <h2>dongguk computer 정재환 2015211051</h2>
        <hr>
        
        <div class="w3-card-4">
		  <div class="w3-container w3-brown">
		    <h2>세미나 등록</h2>
		  </div>
		  <form class="w3-container" name=add action="add_input" method=post OnSubmit='return Check()'>
		    <p>      
		 	   <label class="w3-text-brown"><b>제목</b></label>
		   	   <input class="w3-input w3-border w3-sand" type= "text" name="title" value="" size="80" maxlength="100">
		    </p>
		    <p>      
		    	<label class="w3-text-brown"><b>분야</b></label>
		    	<input class="w3-input w3-border w3-sand" type="text" style="IME-MODE: active" name="field" value="" maxlength="25">
		    </p>
		    <p>      
		    	<label class="w3-text-brown"><b>지역</b></label>
		    	<input class="w3-input w3-border w3-sand" type="text" style="IME-MODE: active" name="area" value="" maxlength="25">
		    </p>
		    <p>      
		    	<label class="w3-text-brown"><b>출처</b></label>
		    	<input class="w3-input w3-border w3-sand" type="text" name="source" value="" maxlength="25">
		    </p>
		    <p>      
		    	<label class="w3-text-brown"><b>시작일</b></label>
		    	<input class="w3-input w3-border w3-sand" type="date" name="start_date" min="2010-01-01" max="2036-12-30">
		    </p>
		    <p>      
		    	<label class="w3-text-brown"><b>종료일</b></label>
		    	<input class="w3-input w3-border w3-sand" type="date" name="stop_date" min="2010-01-01" max="2036-12-30">
		    </p>
		    <p>
		    	<button class="w3-btn w3-brown"><input type="submit" name="search_field" value="등록"></button></p>
		  </form>
		</div>
    </body>
</html>