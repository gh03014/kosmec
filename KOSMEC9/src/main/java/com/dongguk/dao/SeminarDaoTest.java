package com.dongguk.dao;

import org.springframework.context.annotation.AnnotationConfigApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;
import org.springframework.context.ApplicationContext;
import org.springframework.dao.DataAccessException;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.UncategorizedSQLException;
import org.springframework.jdbc.support.SQLErrorCodeSQLExceptionTranslator;
import org.springframework.jdbc.support.SQLExceptionTranslator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.dongguk.bean.SeminarBean;
import com.dongguk.dao.SeminarDao;
import com.dongguk.factory.SeminarFactory;

import oracle.net.ns.NetException;

import static org.hamcrest.CoreMatchers.instanceOf;
import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertThat;

import java.sql.SQLException;
import java.util.List;
import java.util.NoSuchElementException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.JUnitCore;
import org.junit.runner.RunWith;

@RunWith(SpringJUnit4ClassRunner.class)
//@ContextConfiguration(locations="/applicationContext.xml")
@ContextConfiguration(classes= SeminarFactory.class)
//@ContextConfiguration(locations= "file:src/main/webapp/META-INF/context.xml")
public class SeminarDaoTest {
	@Autowired
	ApplicationContext context;
	private SeminarDao dao;
	private DataSource dataSource;
	
	@Before
	public void setUp() throws NamingException {
		
		
		this.context = new AnnotationConfigApplicationContext(SeminarFactory.class);
		this.dao = this.context.getBean("seminarDao", SeminarDao.class);
		
		//this.dataSource = (DataSource) this.context.getBean("hikariDataSource");
		
		//Context context = new InitialContext();
		//this.dataSource = (DataSource) context.lookup("java:comp/env/jdbc/KOSMEC1");
		//this.dao.setDataSource(dataSource);
	}

	@Test 
	public void getCountAndGerList() throws ClassNotFoundException {
		SeminarBean sb = new SeminarBean();
		String title = "";
		String field = "";
		String area = "";
		
		try {
			int count = dao.getCountSeminar(title, field, area);
			
			String pageNum = null;
			
			List list = dao.getList(pageNum, count, title, field, area);
			java.util.Iterator it = list.iterator();

		    while (it.hasNext()) { //다음 행이 null값이 아닐 경우 계속 loop를 실행
		        sb = (SeminarBean) it.next();
		        System.out.printf("번호:" + sb.getNum());
		        System.out.printf(" 분야:" + sb.getField());
		        System.out.println(" 제목:" + sb.getTitle());
		    }
		}catch(DataAccessException ex) { //jdbcTempalte내부에서는 DataAccessException으로 예회 전환하여 던진다.
       	    System.out.println("오류: " + ex);
       	    //SQLException sqlEx = (SQLException)ex.getCause();
			//SQLExceptionTranslator set = new SQLErrorCodeSQLExceptionTranslator(this.dataSource);			
			//DataAccessException transEx = set.translate(null, null, sqlEx);
			//assertThat(transEx, is(instanceOf(UncategorizedSQLException.class)));
		}
	}
	
	
	/*
	@Test(expected=NoSuchElementException.class)
	public void getView() throws ClassNotFoundException {
		String num = "5000";
		
		SeminarBean sb = new SeminarBean();
		sb = dao.seminar_output(num);
		System.out.printf("번호:" + sb.getNum());
        System.out.printf(" 분야:" + sb.getField());
        System.out.println(" 제목:" + sb.getTitle());
        
        int  seminarNum = sb.getNum();
		
		assertThat(seminarNum, is(Integer.parseInt(num)));
	}
	*/
	/*
	@Test
	public void insertTest() throws ClassNotFoundException {
		SeminarBean sb = new SeminarBean();
		
		String title = "dbcp 커넥션 풀";
		String field = "인력";
		String area = "경남";
		String source = "동국대학고";
		String start_date = "2020-06-01";
		String stop_date = "2020-06-02";
		
		int n = dao.seminar_input(field, area, title, source, start_date, stop_date);
		assertThat(n, is(1));
		System.out.println("세미나 추가 완료");
	}
	*/
	/*
	@Test
	public void deleteTest() throws ClassNotFoundException {
		SeminarBean sb = new SeminarBean();
		
		String seminarNum = "1164";
		
		int n = dao.seminar_delete(seminarNum);
		assertThat(n, is(1));
		System.out.println("세미나 삭제 완료");
	}
	*/
	/*
	@Test 
	public void updateTest() throws ClassNotFoundException {
		SeminarBean sb = new SeminarBean();
		
		String num = "312";
		String title = "세미나 변경작업 테스트";
		String field = "인력";
		String area = "부산";
		String source = "정재환";
		String start_date = "2020-07-13";
		String stop_date = "2020-07-14";
		
		int n = dao.seminar_update(num, title, field, area, source, start_date, stop_date);
		assertThat(n, is(1));
		System.out.println("세미나 수정 완료");
	}
	*/
	public SeminarDao seminarDao() throws NetException {
		//GenericXmlApplicationContext context 
		//= new GenericXmlApplicationContext("applicationContext.xml");
		//SeminarDao dao = (SeminarDao) context.getBean("seminarDao", "applicationContext.xml");
		
		//AnnotationConfigApplicationContext context 
		//= new AnnotationConfigApplicationContext(SeminarDaoFactory.class);
		//SeminarDao dao = context.getBean("seminarDao", SeminarDao.class);
		
		this.context = new AnnotationConfigApplicationContext(SeminarFactory.class);
		this.dao = this.context.getBean("seminarDao", SeminarDao.class);
		return dao;
	}
}

