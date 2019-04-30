package com.demo.richfit.asr.mvc.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.demo.richfit.asr.bean.ApplyOrder;
import com.demo.richfit.asr.service.ApplyOrderService;

@Controller
public class HelloController {

	@Value("${userName}")
	private String userName;

	@Value("${title}")
	private String title;
	
	@Autowired
	private ApplyOrderService service;

	//@RequestMapping(value = "/home/page")
	@RequestMapping(value = "/")
	@ResponseBody
	public ModelAndView goHome() {
		System.out.println("go to the home page! " +userName);
		List<ApplyOrder> resultList = service.getAllApplyOrders();
       
        
		ModelAndView mode = new ModelAndView();
		mode.addObject("name", userName);
		mode.addObject("title", title);
		
		mode.addObject("orders", resultList);
		 
		mode.setViewName("index");
		return mode;
	}

}
