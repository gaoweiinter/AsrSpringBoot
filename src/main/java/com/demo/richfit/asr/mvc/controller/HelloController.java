package com.demo.richfit.asr.mvc.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class HelloController {

	@Value("${userName}")
	private String userName;

	@Value("${title}")
	private String title;

	@RequestMapping(value = "/home/page")
	@ResponseBody
	public ModelAndView goHome() {
		System.out.println("go to the home page! " +userName);
		ModelAndView mode = new ModelAndView();
		mode.addObject("name", userName);
		mode.addObject("title", title);
		mode.setViewName("index");
		return mode;
	}

}
