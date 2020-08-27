package com.dongguk.service;

import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import com.dongguk.bean.SeminarBean;
import com.dongguk.dao.SeminarDao;

public class SeminarServiceTx implements SeminarService{
	private DataSource dataSource;
	private PlatformTransactionManager transactionManager;
	private SeminarDao dao;
	
	//외부(응용문맥)로부터 DataSource 객체를 DI방식으로 주입받음. 생성자.
	public void setDataSource(DataSource dataSource) {
		this.transactionManager = new DataSourceTransactionManager(dataSource);
		this.dataSource = dataSource;
	}
	
	public void setSeminarDao(SeminarDao seminarDao) {
		this.dao = seminarDao;
	}

    public List<SeminarBean> getList(String pageNum, int countSeminar, String search_title,
        	String search_field, String search_area) { 
    	//트랜잭션 시작점
    	TransactionStatus status = 
    	        this.transactionManager.getTransaction(new DefaultTransactionDefinition());
    	List<SeminarBean> list = new ArrayList();;
    	try {
    		list = dao.getList(pageNum, countSeminar, search_title, search_field, search_area);
    		this.transactionManager.commit(status); //트랜젝션 완료
        }catch(RuntimeException ex) { //하나의 트랜젝션(jdbcTemplate)에서 오루가 발생하면 롤백한다.
        	System.out.println("\n트랜잭션 오류...롤백 ...\n");
       	    this.transactionManager.rollback(status);
        } 
    	return list;
    }
   
    //dongguk 2015211051 정재환
    public int getCountSeminar(String search_title, String search_field, 
    		String search_area) throws ClassNotFoundException { //전체 데이터갯수를 반환. 페이징처리에 사용.
    	//트랜잭션 시작점
    	TransactionStatus status = 
    	        this.transactionManager.getTransaction(new DefaultTransactionDefinition());
    	int count = 0;
    	try {
    		count = dao.getCountSeminar(search_title, search_field, search_area);
    		this.transactionManager.commit(status); //트랜잭션 완료
        }catch(RuntimeException ex) { //하나의 트랜젝션(jdbcTemplate)에서 오루가 발생하면 롤백한다.
        	System.out.println("\n트랜잭션 오류...롤백 ...\n");
       	    this.transactionManager.rollback(status);
        } 
    	return count;
    }
    
    //해당 번호의 seminar 정보를 List객체에 담아서 반환한다.
    public SeminarBean seminar_output(String num) {
    	//트랜잭션 시작점
    	TransactionStatus status = 
    	        this.transactionManager.getTransaction(new DefaultTransactionDefinition());
    	SeminarBean sb = new SeminarBean();
    	try {
    		sb = dao.seminar_output(num);
    		this.transactionManager.commit(status); //트랜잭션 시작점
        }catch(RuntimeException ex) { //하나의 트랜젝션(jdbcTemplate)에서 오루가 발생하면 롤백한다.
       	    System.out.println("\n트랜잭션 오류...롤백 ...\n");
       	    this.transactionManager.rollback(status);
        } 
        return sb;
    }
    
    //사용자로부터 입력받은 값을 매개변수로 받아 DB에 insert한다
    public int seminar_input(String field, String area, String title,  
            String source, String start_date, String stop_date) {
    	//트랜잭션 시작점
    	TransactionStatus status = 
    	        this.transactionManager.getTransaction(new DefaultTransactionDefinition());
    	int n = 0;
    	try {
    		n = dao.seminar_input(field, area, title, source, start_date, stop_date);
    		this.transactionManager.commit(status); //트랜잭션 완료
        }catch(RuntimeException ex) { //하나의 트랜젝션(jdbcTemplate)에서 오루가 발생하면 롤백한다.
        	System.out.println("\n트랜잭션 오류...롤백 ...\n");
       	    this.transactionManager.rollback(status);
        } 
    	return n;
	}
    
    //해당 번호의 세미나 데이터를 DB에서 삭제한다
    public int seminar_delete(String seminarNum) {
    	//트랜잭션 시작점
    	TransactionStatus status = 
    	        this.transactionManager.getTransaction(new DefaultTransactionDefinition());
    	int n = 0;
    	try {
    		n = dao.seminar_delete(seminarNum);
    		this.transactionManager.commit(status); //트랜잭션 완료
        }catch(RuntimeException ex) { //하나의 트랜젝션(jdbcTemplate)에서 오루가 발생하면 롤백한다.
        	System.out.println("\n트랜잭션 오류...롤백 ...\n");
       	    this.transactionManager.rollback(status);
        } 
    	return n;
    }
    
    //사용자로부터 입력받은 값을 매개변수로 받아 해당 데이터 정보를 수정한다
    public int seminar_update(String num, String title, String field, String area,
                            String source, String start_date, String stop_date) {
    	//트랜잭션 시작점
    	TransactionStatus status = 
    	        this.transactionManager.getTransaction(new DefaultTransactionDefinition());
    	int n = 0;
    	try {
    		n = dao.seminar_update(num, title, field, area, source, start_date, stop_date);
    		this.transactionManager.commit(status); //트랜잭션 완료
        }catch(RuntimeException ex) { //하나의 트랜젝션(jdbcTemplate)에서 오루가 발생하면 롤백한다.
        	System.out.println("\n트랜잭션 오류...롤백 ...\n");
       	    this.transactionManager.rollback(status);
        } 
    	return n;
    }
}
