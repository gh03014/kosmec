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
        <link rel="stylesheet" href="../resources/css/view.css">
        <title>한국 중소기업 대상 교육 세미나 정보 검색 시스템 KOSMEC</title>
    </head>
    <body>
        <h1>한국 중소기업 대상 교육 세미나 정보 검색 시스템</h1>
        <h2>dongguk computer 정재환 2015211051</h2>
        <hr>
        
        <%
        String pageNum = request.getParameter("pageNum"); //파라미터로 전달받은 변수
        String num = request.getParameter("num");
        
        //응용문맥를 활용한 관심 문리 책임
        SeminarServiceTest serviceTest = new SeminarServiceTest();
        //응용문맥의 빈에 등록된 SeminarService객체 선언
        SeminarService service = serviceTest.seminarServiceTx();
        SeminarBean sb = new SeminarBean();
        
        sb = service.seminar_output(num); //해당 번호의 데이터를 반환

        int  seminarNum = sb.getNum();
        String field = sb.getField();
        String area = sb.getArea();
        String title = sb.getTitle();
        String source = sb.getSource();
        String startDate = sb.getStartDate();
        String stopDate = sb.getStopDate();
        String registerDate = sb.getRegisterDate();
        String updateDate = sb.getUpdateDate();
        int readCount = sb.getReadCount();
        %>
        <div>
		  <h2>세미나 상세정보</h2>
		  <p>
		  <label>제목</label>
		  <input type="text" value="<%=title%>" size="80" disabled>
		  </p>
		  
		  <p>
		  <label>분야</label>
		  <input  type="text" value="<%=field%>" size="15" disabled>
		  </p>
		  
		  <p>
		    <label>세미나 번호</label>
		    <input type="text" value="<%=seminarNum%>" size="12" disabled>
		    <label class="right">등록 날짜</label>
		    <input type="text" value="<%=registerDate%>" disabled>	  
		  </p>
		
		  <p>
		    <label>시작일</label>
		    <input type="text" value="<%=startDate%>" disabled>
		    <label class="right2">종료일</label>
		    <input type="text" value="<%=stopDate%>" disabled>
		  </p>
	
		  <p>
		  <label>개최 지역</label>
		  <input  type="text" value="<%=area%>" size="15" disabled>
		  <label class="right3">출처</label>
		  <input  type="text" value="<%=source%>" size="15" disabled>
		  </p>
		  
		  <p>
		  <label>최근 변경일</label>
		  <input  type="text" value="<%=updateDate%>" disabled>
		  <label class="right4">조회수</label>
		  <input  type="text" value="<%=readCount%>" size="15" disabled>
		  </p>
		  
		  <hr>
		  
		  <p>
		    <button><a href="delete?num=<%=seminarNum%>">삭제하기</a></button>
		    <button><a href="modify?num=<%=seminarNum%>">수정하기</a></button>
		  </p>
		</div>  
    </body>
</html>