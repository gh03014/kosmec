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
        <title>한국 중소기업 대상 교육 세미나 정보 검색 시스템_2015211051정재환</title>
    </head>
    <body>
        <%
        String field = request.getParameter("field");
        String area = request.getParameter("area");
        String title = request.getParameter("title");
        String source = request.getParameter("source");
        String start_date = request.getParameter("start_date");
        String stop_date = request.getParameter("stop_date");

        //응용문맥 활용환 관심, 책임 분리 적용
        SeminarServiceTest serviceTest = new SeminarServiceTest();
        //응용문맥의 빈에 등록된 SeminarService 객체 선언
        SeminarService service = serviceTest.seminarServiceTx();
        int n = service.seminar_input(field, area, title, source, start_date, stop_date); 
        //파라미터 변수를 매개변수로 전달한다.

        if(n == 1) { //입력한 데이터가 DB에 저장되었을 경우
        %>
            <table>
                <tr>
                    <h3>세미나 등록을 완료하였습니다.</h3>
                    <h4><button><a href="list">목록으로</a></button></h4>
                </tr>
            </table>
            <hr>
        <%
            //가장 최근에 저장한 데이터가 값이 가장 크기 때문에 공백을 매개변수로 전달하여 얻은 결과와 같다
        	int num = service.getCountSeminar("", "", "");	
            SeminarBean sb = new SeminarBean();
            //추가된 데이터의 정보를 얻는다
        	sb = service.seminar_output(Integer.toString(num));
      
        	int seminarNum = sb.getNum();
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
        <table> <!--dongguk 정재환 2015211051-->
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
                    <h3>세미나 등록에 실패하엿습니다 error.</h3>
                    <h4><button><a href="list">목록으로</a></button></h4>
                </tr>
            </table>
        <%
        }
        %>  
    </body>
</html>