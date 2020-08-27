package com.dongguk.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Handles requests for the application home page.
 */
@Controller
public class SeminarController {
	@RequestMapping("/seminar/list")
	public String list() {
		return "seminar/list";
	}
	
	@RequestMapping("/seminar/view")
	public String view() {
		return "seminar/view";
	}
	
	@RequestMapping("/seminar/find")
	public String find() {
		return "seminar/find";
	}
	
	@RequestMapping("/seminar/add")
	public String add() {
		return "seminar/add";
	}
	
	@RequestMapping("/seminar/add_input")
	public String add_input() {
		return "seminar/add_input";
	}
	
	@RequestMapping("/seminar/delete")
	public String delete() {
		return "seminar/delete";
	}
	
	@RequestMapping("/seminar/modify")
	public String modify() {
		return "seminar/modify";
	}
	
	@RequestMapping("/seminar/modify_input")
	public String modify_input() {
		return "seminar/modify_input";
	}
}

