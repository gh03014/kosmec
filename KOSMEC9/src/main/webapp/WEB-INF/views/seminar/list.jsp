<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import = "java.sql.*, java.util.*" %>
<%@ page import = "com.dongguk.service.SeminarServiceTest"%>
<%@ page import = "com.dongguk.service.SeminarServiceTx"%>
<%@ page import = "com.dongguk.service.SeminarService"%>
<%@ page import = "com.dongguk.bean.SeminarBean"%>
<% request.setCharacterEncoding("utf-8"); %> <!-- 파라미터 인코딩 -->
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<!-- 초기 화면 확대 비율 설정 -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>한국 중소기업 대상 교육 세미나 정보 검색 시스템 KOSMEC</title>
	<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
	<link rel="stylesheet" href="../resources/css/list.css">
</head>
<body>
    <!-- Sidebar -->
	<div class="w3-sidebar w3-bar-block w3-border-right" style="display:none" id="mySidebar">
	  <button onclick="w3_close()" class="w3-bar-item w3-large">Close &times;</button>
	  <a href="list" class="w3-bar-item w3-button">목록으로</a>
	  <a href="find" class="w3-bar-item w3-button">통합검색</a>
	  <a href="add" class="w3-bar-item w3-button">세미나 등록</a>
	</div>
	
	<!-- Page Content -->
	<div class="w3-teal">
	  <button class="w3-button w3-teal w3-xlarge" onclick="w3_open()">메뉴탭</button>
	  <div class="w3-container">
	    <h1>한국 중소기업 대상 교육 세미나 정보 검색 시스템 KOSMEC</h1>
	    <h2>dongguk 정재환 2015211051</h2>
	  </div>
	</div>
	
    <hr>
    
    <div>
    <table id="data"> <!-- 박스 -->
        <tr> <!-- 가로단(행) -->
            <th class="num">번호</th> <!-- 세로단 -->
            <th class="field">분야</th>
            <th class="title">제목</th>
            <th class="startDate">시작일</th>
            <th class="readCount">조회수</th>
        </tr>

    <% 
    String pageNum = request.getParameter("pageNum"); //파라미터로 전달받은 변수
    String search_title = request.getParameter("search_title");
    String search_field = request.getParameter("search_field");
    String search_area = request.getParameter("search_area");
    if(search_title == null) search_title = "";
    //else search_title = java.net.URLDecoder.decode(search_title, "UTF-8");
    if(search_field == null) search_field = "";
    //else search_field = java.net.URLDecoder.decode(search_field, "UTF-8");
    if(search_area == null) search_area = "";
    //else search_area = java.net.URLDecoder.decode(search_area, "UTF-8");

    //응용문맥을 활용한 관심 분리 책임
    SeminarServiceTest serviceTest = new SeminarServiceTest();
    //응용문맥의 빈에 등록된 SeminarService 객체 선언
    SeminarService service = serviceTest.seminarServiceTx();
    SeminarBean sb = new SeminarBean();
    
    int countSeminar = service.getCountSeminar(search_title, search_field, search_area); //전체 데이터 갯수를 반환하는 DAO메소드
    List<SeminarBean> list = service.getList(pageNum, countSeminar, search_title, search_field, search_area); //파라미터 변수를 매개변수로 전달한다. 
    //SeminarDAO타입의 식별자 sd의 listSeminar()메소드 실행 값을
    //식별자 list에 주소 할당
    java.util.Iterator it = list.iterator();

    while (it.hasNext()) { //다음 행이 null값이 아닐 경우 계속 loop를 실행
        sb = (SeminarBean) it.next();
        int num = sb.getNum();
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

        <tr>
            <td class="num"><%=num%></td> <!-- 변수 값을 출력 -->
            <td class="field"><%=field%></td>
            <td class="title"><a href="view?num=<%=num%>"><%=title%></a></td>
            <td class="startDate"><%=startDate%></td>
            <td class="readCount"><%=readCount%></td>
        </tr>

        <%
    }
        %>
    </table>
	</div>
	
    <hr>
    
    <div class="w3-bar">
    <table> <!-- 페이징 처리 -->
        <%
        search_title = java.net.URLEncoder.encode(search_title, "UTF-8"); //한글 문자열을 get방식으로 보낼때는 반드시 인코딩 해야한다.
        search_field = java.net.URLEncoder.encode(search_field, "UTF-8");
        search_area = java.net.URLEncoder.encode(search_area, "UTF-8");

        int listSize = 20; //한 페이지당 출력할 갯수
        int currentPage = 1;
        if(pageNum != null) currentPage = Integer.parseInt(pageNum); //현재 페이지번호

        //한 페이지에 10개의 페이지 번호만 출력될수 있도록 핸다.
        int startPage = ((currentPage - 1) / 10) * 10 + 1; //하단에 출력될 첫 페이지번호
        int stopPage = startPage + 9; //하단에 출력될 마지막 페이지번호. 

        if(countSeminar > 0) { //전체 데이터 갯수
            //int setPage = 0;
            int beginPage = 1; //가장 첫 페이지
            int lastPage = 0; // 가장 마지막 페이지

            if( countSeminar % listSize == 0) lastPage = countSeminar / listSize;
            else lastPage = countSeminar / listSize + 1;

            //현제 페이지가 1이 아닌 경우 beginPage로 이동할 버특 출력
            if(currentPage != 1) {
         %>
               <a href="list?pageNum=<%=beginPage%>&search_title=<%=search_title%>&search_field=<%=search_field%>&search_area=<%=search_area%>" class="w3-button">[<<]</a>
         <% 
            }

            // 현재 startPage가 1이 아닌 경우 이전 startPage로 이동할 페이지 버튼 출력
            if(startPage != 1) { 
        %>
                <a href="list?pageNum=<%=stopPage-10%>&search_title=<%=search_title%>&search_field=<%=search_field%>&search_area=<%=search_area%>" class="w3-button">[<]</a>
        <%
            }

            //startPage부터 stopPage까지 출력
            for(int i = startPage; i < stopPage + 1; i++) {
                if(i == currentPage) { //현재 페이지임을 표시
        %>
                   <a href="list?pageNum=<%=i%>&search_title=<%=search_title%>&search_field=<%=search_field%>&search_area=<%=search_area%> " class="w3-button w3-green">(<%=i%>)</a>
        <%
                }
                else if(i > lastPage)
                {
                        break; //가장 마지막 페이지가 나타나면 멈춘다.
                }
                else {
        %>
                   <a href="list?pageNum=<%=i%>&search_title=<%=search_title%>&search_field=<%=search_field%>&search_area=<%=search_area%>" class="w3-button">[<%=i%>]</a>
        <%
                }
            }

            //stopPage가 가장 마지막 페이지 보다 작을 경우 가장 마지막 페이지로 이동할 버튼 출력
            if(lastPage > stopPage) { 
        %>
                <a href="list?pageNum=<%=startPage+10%>&search_title=<%=search_title%>&search_field=<%=search_field%>&search_area=<%=search_area%>" class="w3-button">[>]</a>
        <%
            }

            //현재 페이지가 가장 마지막 페이지가 아닐 경우 가장 마지막 페이지로 이동할 버튼 출력
            if(currentPage != lastPage) {
        %>
                <a href="list?pageNum=<%=lastPage%>&search_title=<%=search_title%>&search_field=<%=search_field%>&search_area=<%=search_area%>" class="w3-button">[>>]</a>
        <%
            }
        }
        %>
    </table>
    </div>
    
    <script> //특정 태그를 클릭했을 때 상태 확인, 변경 수행
		function w3_open() {
		  document.getElementById("mySidebar").style.display = "block";
		}
		
		function w3_close() {
		  document.getElementById("mySidebar").style.display = "none";
		}
	</script>
</body>
</html>