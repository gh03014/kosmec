<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*, java.util.*" %>
<%@ page import = "com.dongguk.service.SeminarServiceTest"%>
<%@ page import = "com.dongguk.service.SeminarServiceTx"%>
<%@ page import = "com.dongguk.service.SeminarService"%>
<%@ page import = "com.dongguk.bean.SeminarBean"%>
<% request.setCharacterEncoding("UTF-8"); %> <!-- 파라미터 인코딩 -->
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
        <title>한국 중소기업 대상 교육 세미나 정보 검색 시스템 KOSMEC</title>
        <SCRIPT language="JavaScript">
            function Check() <!--버튼을 클맀했을 때 실행되는 자바스크립트 함수-->
            {
                <!--공백이 입력되었을 경우 알림창을 나타내고 다시 입력하도록 한다-->
                if (modify.title.value.length < 1) {
                    alert("제목을 입력하세요.");
                    modify.title.focus();
                    return false;
                }

                if (modify.field.value.length < 1) {
                    alert("분야를 입력하세요.");
                    modify.field.focus();
                    return false;
                }
                
                if (modify.area.value.length < 1) {
                    alert("지역을 입력하세요.");
                    modify.area.focus();
                    return false;
                }
                
                if (modify.source.value.length < 1) {
                    alert("출처를 입력하세요.");
                    modify.source.focus();
                    return false;
                }
                
                if (modify.start_date.value.length < 1) {
                    alert("시작일을 입력하세요.");
                    modify.start_date.focus();
                    return false;
                }
                
                if (modify.stop_date.value.length < 1) {
                    alert("종료일을 입력하세요.");
                    modify.stop_date.focus();
                    return false;
                }
                <!--시작날짜가 종료날짜 보다 늦을 경우-->
                if(modify.start_date.value > modify.stop_date.value) {
                    alert("시작일과 종료일을 구분하세요");
                    modify.start_date.focus();
                    return false;
                }
            }
        </SCRIPT>
    </head>
    <body>
        <%
        //dongguk 정재환 2015211051
        String num = request.getParameter("num"); //파라미터로 전달받은 변수
        
        //응용문맥을 활용환 관심 책임 분리 적용
        SeminarServiceTest serviceTest = new SeminarServiceTest();
        //응용문맥의 빈에 등록된 SeminarService 객체 선언
        SeminarService service = serviceTest.seminarServiceTx();
        SeminarBean sb = new SeminarBean();
        
        sb = service.seminar_output(num); //해당 번호의 데이터를 가져와서 반환
       
        int  seminarNum = sb.getNum();
        String field = sb.getField();
        String area = sb.getArea();
        String title = sb.getTitle();
        String source = sb.getSource();
        String startDate = sb.getStartDate();
        String stopDate = sb.getStopDate();
        String registerDate = sb.getRegisterDate();
        %>
        
        <h1>한국 중소기업 대상 세미나 정보 검색 시스템 KOSMEC</h1>
        <h2>dongguk computer 정재환 2015211051</h2>
        <hr>
        
        <div class="w3-card-4">
		  <div class="w3-container w3-brown">
		    <h2>세미나 수정</h2>
		  </div>
		  <form class="w3-container" name=modify action="modify_input" method=post OnSubmit='return Check()'>
		   <p>      
		    <label class="w3-text-brown"><b>번호</b></label>
		    <input class="w3-input w3-border w3-sand" type="text" name="num" value="<%=seminarNum%>" readonly>
		    </p> 
		   <p>      
		    <label class="w3-text-brown"><b>제목</b></label>
		    <input class="w3-input w3-border w3-sand" type= "text" name="title" value="<%=title%>" maxlength="100">
		    </p>
		    <p>      
		    <label class="w3-text-brown"><b>분야</b></label>
		    <input class="w3-input w3-border w3-sand" type="text" style="IME-MODE: active" name="field" value="<%=field%>" maxlength="25">
		    </p>
		    <p>      
		    <label class="w3-text-brown"><b>지역</b></label>
		    <input class="w3-input w3-border w3-sand" type="text" style="IME-MODE: active" name="area" value="<%=area%>" maxlength="25">
		    </p>
		    <p>      
		    <label class="w3-text-brown"><b>출처</b></label>
		    <input class="w3-input w3-border w3-sand" type="text" name="source" value="<%=source%>" maxlength="25">
		    </p>
		    <p>      
		    <label class="w3-text-brown"><b>시작일</b></label>
		    <input class="w3-input w3-border w3-sand" type="date" name="start_date" value="<%=startDate%>" min="2010-01-01" max="2036-12-30">
		    </p>
		    <p>      
		    <label class="w3-text-brown"><b>종료일</b></label>
		    <input class="w3-input w3-border w3-sand" type="date" name="stop_date" value="<%=stopDate%>" min="2010-01-01" max="2036-12-30">
		    </p>
		    <p>      
		    <label class="w3-text-brown"><b>등록 날짜</b></label>
		    <input class="w3-input w3-border w3-sand" type="text" name="register_date" value="<%=registerDate%>" disabled>
		    </p>
		    <p>
		    <button class="w3-btn w3-brown"><input type="submit" name="update_button" value="저장"></button></p>
		  </form>
		</div>
    </body>
</html>