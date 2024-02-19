package kr.or.ddit.admin.manage.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value = "/admin/manage")
public class AdminTotalChart {
	
	@GetMapping("/chart")
	public String Chart() {
		System.out.println("감촤~~~~~~~~~~트");
		
		
		return "admin/management/chart";
		
	}


}
