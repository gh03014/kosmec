<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*, java.util.*" %>
<%@ page import = "com.dongguk.service.SeminarServiceTest"%>
<%@ page import = "com.dongguk.service.SeminarServiceTx"%>
<%@ page import = "com.dongguk.service.SeminarService"%>
<% request.setCharacterEncoding("UTF-8"); %> <!-- 파라미터 인코딩 -->
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>국내 중소기업 대상 교육 세미나 정보 검색 시스템</title>
    </head>
    <body>
        <%
        String num = request.getParameter("num"); //파라미터 변수 get
        
        //응용문맥을 활용환 관심 책임 분리 적용
        SeminarServiceTest serviceTest = new SeminarServiceTest();
        //응용문맥의 빈에 등록된 SeminarService 객체 선언
        SeminarService service = serviceTest.seminarServiceTx();
        
        int n = service.seminar_delete(num); //해당 번호의 데이터 삭제 수행

        if(n == 1) { //해당 번호의 데이터 삭제가 완료되었을 경우
        %>
        <h3>삭제를 완료하였습니다.</h3>
        <%
        }
        else {
        %>
        <h3>삭제 실패하였습니다</h3>
        <%
        }
        %>
        <table>
            <tr>
                <h4><button><a href="list">목록으로</a></button></h4>
            </tr>
        </table>
    </body>
</html>
