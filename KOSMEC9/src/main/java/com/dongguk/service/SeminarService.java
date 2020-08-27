package com.dongguk.service;

import java.util.List;

import javax.sql.DataSource;

import com.dongguk.bean.SeminarBean;
import com.dongguk.dao.SeminarDao;

//인터페이스를 통해 로직, 트랜잭션 코드 분리
public interface SeminarService {
	public void setDataSource(DataSource dataSource);
	
	public void setSeminarDao(SeminarDao seminarDao);
	
    public List<SeminarBean> getList(String pageNum, int countSeminar, String search_title,
        	String search_field, String search_area);
   
    public int getCountSeminar(String search_title, String search_field, 
    		String search_area) throws ClassNotFoundException;
    
    public SeminarBean seminar_output(String num);
    
    public int seminar_input(String field, String area, String title,  
            String source, String start_date, String stop_date);
    
    public int seminar_delete(String seminarNum);
    
    public int seminar_update(String num, String title, String field, String area,
                            String source, String start_date, String stop_date);
}