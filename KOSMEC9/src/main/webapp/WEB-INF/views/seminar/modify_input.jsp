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
        <title>국내 중소기업 대상 교육 세미나 정보 검색 시스템_2015211051정재환</title>
    </head>
    <body>
        <%
        String num = request.getParameter("num"); //전달받은 파라미터 변수
        String field = request.getParameter("field");
        String area = request.getParameter("area");
        String title = request.getParameter("title");
        String source = request.getParameter("source");
        String start_date = request.getParameter("start_date");
        String stop_date = request.getParameter("stop_date");

        //응용문맥을 활용환 관심 책임 분리 적용
        SeminarServiceTest serviceTest = new SeminarServiceTest();
        //응용문맥의 빈에 등록된 SeminarService 객체 선언
        SeminarService service = serviceTest.seminarServiceTx();
        
        int n = service.seminar_update(num, title, field, area, source,
                   start_date, stop_date); //파라미터 변수를 매개변수로 전달한다.

        if(n == 1) { //해당 번호의 데이터를 DB에서 가져왔을 경우
        %>
            <table>
                <tr>
                    <h3>세미나 수정을 완료하였습니다.</h3>
                    <h4><button><a href="list">목록으로</a></button></h4>
                </tr>
            </table>
            <hr>
        <%
	        SeminarBean sb = new SeminarBean();
	        sb = service.seminar_output(num); //해당 번호의 데이터들을 반환
	    
	        int  seminarNum = sb.getNum();
	        field = sb.getField();
	        area = sb.getArea();
	        title = sb.getTitle();
	        source = sb.getSource();
	        String startDate = sb.getStartDate();
	        String stopDate = sb.getStopDate();
	        String registerDate = sb.getRegisterDate();
	        String updateDate = sb.getUpdateDate();
	        int readCount = sb.getReadCount();
     	%>
     	<table> <!--데이터 변수를 웹에 출력-->
            <tr>
                <td>등록 번호: <%=seminarNum%></td>
                <td>등록 날짜: <%=registerDate%></td>
            </tr>
            <tr>
                <td>시작일: <%=startDate%></td>
                <td>종료일: <%=stopDate%></td>
            </tr>
            <tr>
                <td>분야: <%=field%></td>
            </tr>
            <tr>
                <td>제목: <%=title%></td>
            </tr>
            <tr>
                <td>개최 지역: <%=area%></td>
            </tr>
            <tr>
                <td>출처: <%=source%></td>
            </tr>
            <tr>
            	<td>최근 변경날짜: <%=updateDate%></td>
            </tr>
            <tr>
            	<td>조회수: <%=readCount%></td>
            </tr>
        </table>
        <%
        }
        else {
        %>
            <table>
                <tr>
                    <h3>세미나 수정에 실패하엿습니다 error.</h3>
                    <h4><button><a href="list">목록으로</a></button></h4>
                </tr>
            </table>
        <%
        }
        %>  
    </body>
</html>