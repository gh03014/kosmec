package com.dongguk.dao;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertThat;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.dao.DataAccessException;
//import org.springframework.dao.DataAccessResourceFailureException;
//import org.springframework.dao.DataIntegrityViolationException;
//import org.springframework.dao.DuplicateKeyException;
import org.springframework.jdbc.BadSqlGrammarException;
import org.springframework.jdbc.UncategorizedSQLException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.ResultSetExtractor;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.jdbc.support.SQLErrorCodeSQLExceptionTranslator;
import org.springframework.jdbc.support.SQLExceptionTranslator;

import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import com.dongguk.bean.SeminarBean;
//import com.zaxxer.hikari.HikariDataSource;

import javax.sql.DataSource;

//인터페이스를 이용해 로직, jdbc코드 분리
public interface SeminarDao {
	public void setDataSource(DataSource dataSource);
	
    public List<SeminarBean> getList(String pageNum, int countSeminar, String search_title,
        	String search_field, String search_area);
   
    public int getCountSeminar(String search_title, String search_field, 
    		String search_area);
    
    public SeminarBean seminar_output(String num);
    
    public int seminar_input(String field, String area, String title,  
            String source, String start_date, String stop_date);
    
    public int seminar_delete(String seminarNum);
    
    public int seminar_update(String num, String title, String field, String area,
                            String source, String start_date, String stop_date);
}