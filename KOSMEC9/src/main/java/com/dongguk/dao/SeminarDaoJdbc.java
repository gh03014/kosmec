package com.dongguk.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import com.dongguk.bean.SeminarBean;
//인터페이스 메소드로 jdbc, 콜백 구현
public class SeminarDaoJdbc implements SeminarDao{
	private DataSource dataSource;
	private JdbcTemplate jdbcTemplate;
	
	//외부(응용문맥)로부터 DataSource 객체를 DI방식으로 주입받음. 생성자.
	public void setDataSource(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
		this.dataSource = dataSource;
	}
	
	//jdbcTemplate를 실행할 때 마다 RowMapper를 구현하는 중복코드를 제거하기 위해 사용
	private RowMapper<SeminarBean> seminarMapper = 
		new RowMapper<SeminarBean>() {
			public SeminarBean mapRow(ResultSet rs, int rowNum) throws SQLException {
				SeminarBean sb = new SeminarBean();
				sb.setNum(rs.getInt("num"));
		        sb.setField(rs.getString("field"));
		        sb.setArea(rs.getString("area"));
		        sb.setTitle(rs.getString("title"));
		        sb.setSource(rs.getString("source"));
		        sb.setStartDate(rs.getString("start_date"));
		        sb.setStopDate(rs.getString("stop_date"));
		        sb.setRegisterDate(rs.getString("register_date"));
		        sb.setUpdateDate(rs.getString("update_date"));
		        sb.setReadCount(rs.getInt("read_count"));
				return sb;
		   }
	   };
	
    //매개변수로 받은 파리미터 변수를 이용해 해당 범위의 데이터만 select한다.
    public List<SeminarBean> getList(String pageNum, int countSeminar, String search_title,
        	String search_field, String search_area) { 

    	String sql = "";
        if (pageNum == null) { // 전달받은 파라미터 변수가 null값일 때
            pageNum = "1";
        }
        int listSize = 20;  // 한 페이지당 출력할 데이터 갯수
        int currentPage = Integer.parseInt(pageNum);
        // 마지막 열 번호 - (리스트 사이즈 * (현재 페이지 - 1)
        int startRow = countSeminar - (listSize * (currentPage - 1)); 
        int endRow = startRow - listSize; // 시작 열 - 리스트 사이즈
            
        // 전제 데이터 갯수가 한 페이지당 출력할 갯수보다 작을 경우 
        if (endRow <= 0) endRow = 1;
        //페이지 갯수 계산
        int lastPage = countSeminar / listSize;
        if(countSeminar % 10 != 0) lastPage = lastPage + 1;

        //마지막 페이지에서 데이터가 1개 누락되는 오류 방지
        if(currentPage == lastPage) endRow = endRow - 1;  
            
        if (countSeminar > 0) { //데이터가 존재할 경우
            if(search_title == null) search_title = "";
            if(search_field == null) search_field = "";
            if(search_area == null) search_area = "";
            String search = " where title like '%" + search_title + "%' and field like '%" 
                          + search_field + "%' and area like '%" + search_area + "%'";
                
            //서브쿼리로 2개의 rownum을 적용해 시작행과 마지막 행을 모두 지정한다.
            sql = "select a.* from (select rownum rn, b.* from (select * from seminar" + search 
                + " order by num) b where rownum <= " + startRow + ") a where rn > " + endRow 
                + " order by num desc"; 
        }
        List<SeminarBean> list = new ArrayList();
        
        try {
        	//복수 행의 데이터를 반환하기 위해 query()메소드 사용
        	list = this.jdbcTemplate.query(sql, this.seminarMapper);
        }catch(DataAccessException ex) { //jdbcTempalte내부에서는 DataAccessException으로 예회 전환하여 던진다.
       	    System.out.println("오류: " + ex);
       	    throw ex;
        }
        return list;
    }
   
    //사용자로부터 입력받은 데이터를 매개변수로 받아 해당 범위의 데이터의 전체갯수 반환.
    public int getCountSeminar(String search_title, String search_field, 
    		String search_area) { //전체 데이터갯수를 반환. 페이징처리에 사용.
    	String sql = "select count(*) from seminar";
        if(search_title == null || search_title.equals("") == true) {
            sql = sql + " where title like '%'";
        }
        else{
            sql = sql + " where title like '%" + search_title + "%'";
        }

        if(search_field == null || search_field.equals("") == true) {
            sql = sql + " and field like '%'";
        }
        else{
            sql = sql + " and field like '%" + search_field + "%'";
        }

        if(search_area == null || search_area.equals("") == true) {
            sql = sql + " and area like '%'";
        }
        else{
            sql = sql + " and area like '%" + search_area + "%'";
        }
        
    	int num = 0;
    	try {
    		//숫자형 데이터 1개를 반환하기 위해 queryForInt()메소드 사용
    		num = this.jdbcTemplate.queryForInt(sql);
    	}catch(DataAccessException ex) { //jdbcTempalte내부에서는 DataAccessException으로 예회 전환하여 던진다.
       	    System.out.println("오류: " + ex);
       	    throw ex;
    	}
    	return num;
    }
    
    //해당 번호의 seminar 데이터 정보를 List객체에 담아서 반환한다.
    public SeminarBean seminar_output(String num) {
        SeminarBean sb = new SeminarBean();
        
	    try {
        String sql = "select * from seminar where num = ?";
        //한 행의 데이터만 반환하기 위해 queryForObject()메소드 사용
	    sb = this.jdbcTemplate.queryForObject(sql, new Object[] {num}, this.seminarMapper);
	            
	    sql = "update seminar set read_count = read_count+1 where num=?";
	    //데이터를 수정하기 위해 update()메소드 사용
	    this.jdbcTemplate.update(sql, Integer.parseInt(num));
	    } catch(DataAccessException ex) {
	    	System.out.println("오류: " + ex);
       	    throw ex;
	    }
         return sb;
    }
    
    //사용자로부터 입력받은 값을 매개변수로 받아 DB에 insert한다
    public int seminar_input(String field, String area, String title,  
            String source, String start_date, String stop_date) {
	    int n = 0;
	    try {
		    String sql = "select max(num) from seminar";
		    int num = this.jdbcTemplate.queryForInt(sql) + 1;
		        
		    sql = "insert into seminar(num, field, area, title, source, "
		    	+ "start_date, stop_date, register_date, update_date, read_count)"
		    	+ " values(?, ?, ?, ?, ?, ?, ?, sysdate, sysdate, 0)";
		    //데이터를 수정하기 위해 update()메소드 사용
		    this.jdbcTemplate.update(sql, num, field, area, title, source, start_date, stop_date);
		    n = 1;
	    }catch(DataAccessException ex) { //jdbcTempalte내부에서는 DataAccessException으로 예회 전환하여 던진다.
       	    System.out.println("오류: " + ex);
       	    throw ex;
        }
	    return n;
	}
    
    //해당 번호의 세미나 데이터를 DB에서 삭제한다
    public int seminar_delete(String seminarNum) {
        int n = 0;
        try {
	        int num = Integer.parseInt(seminarNum);
	        String sql = "delete from seminar where num = ?";
	        
	        //데이터를 수정하기 위해 update()메소드 사용
	        this.jdbcTemplate.update(sql, num);
	        
	        //데이터가 삭제된 이후 해당 데이터의 번호가 공백으로 되는 현상을 해결한다
	        sql = "update seminar set num = num-1 where num > ?";
	        this.jdbcTemplate.update(sql, num);
	        n = 1;
        }catch(DataAccessException ex) { //jdbcTempalte내부에서는 DataAccessException으로 예회 전환하여 던진다.
       	    System.out.println("오류: " + ex);
       	    throw ex;
        }
        return n;
    }
    
    //사용자로부터 입력받은 값을 매개변수로 받아 해당 데이터 정보를 수정한다
    public int seminar_update(String num, String title, String field, String area,
                            String source, String start_date, String stop_date) {
        int n = 0;
        try {
	        String sql = "update seminar set title=?, field=?, area=?, source=?, "
	                   + "start_date=?, stop_date=?, update_date=sysdate where num = ?";
	
	        //데이터를 수정하기 위해 update()메소드 사용
	        this.jdbcTemplate.update(sql, title, field, area, source, start_date, 
	        	                   stop_date, Integer.parseInt(num));
	        n = 1;
        }catch(DataAccessException ex) { //jdbcTempalte내부에서는 DataAccessException으로 예회 전환하여 던진다.
       	    System.out.println("오류: " + ex);
       	    throw ex;
        }
        return n;
    }
}
