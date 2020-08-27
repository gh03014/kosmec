package com.dongguk.factory;

import javax.sql.DataSource;
import javax.naming.NamingException;
import javax.naming.InitialContext;

//import java.sql.Connection;
import java.sql.SQLException;

import javax.naming.Context;

//import org.junit.runner.RunWith;
//import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Component;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.datasource.SimpleDriverDataSource;
//import org.springframework.test.context.ContextConfiguration;
import org.springframework.transaction.PlatformTransactionManager;

import com.dongguk.dao.SeminarDao;
import com.dongguk.dao.SeminarDaoJdbc;
import com.dongguk.service.SeminarService;
import com.dongguk.service.SeminarServiceTx;

@Configuration
public class SeminarFactory { //객체 생성 관리 클래스	
	/*
	@Bean //일반적인 DB연결
	public DataSource dataSource() throws NamingException {
		SimpleDriverDataSource dataSource = new SimpleDriverDataSource ();
		dataSource.setDriverClass(oracle.jdbc.OracleDriver.class);
		dataSource.setUrl("jdbc:oracle:thin:@localhost:1521:orcl");
		dataSource.setUsername("scott");
		dataSource.setPassword("c4iuser03");
		//dataSource.setUrl("jdbc:oracle:thin:@dalma.dongguk.ac.kr:1521:stud1");
		//dataSource.setUsername("asdf150");
		//dataSource.setPassword("c4iuser04");
		return dataSource;
	}
	*/
	
	@Bean //객체 생성관리 메소드
	public Context context() throws NamingException {
		Context context = new InitialContext();
		return context;
	}
	
	@Bean //JNDI, 커넥션 풀을 적용한 DB연결
	public DataSource dbcpDataSource() throws NamingException, SQLException {
		DataSource dataSource 
		= (DataSource) context().lookup("java:comp/env/jdbc/KOSMEC1");
		return dataSource;
	}
	
	@Bean
	public SeminarDao seminarDao() throws NamingException, SQLException {
		SeminarDao dao = new SeminarDaoJdbc();
		dao.setDataSource(dbcpDataSource());
		return dao;
	}
	
	@Bean
	public SeminarService seminarServiceTx() throws NamingException, SQLException {
		SeminarService service = new SeminarServiceTx();
		service.setDataSource(dbcpDataSource());
		service.setSeminarDao(seminarDao());
		return service;
	}
}
