package com.demo.richfit.asr.mvc.controller;

import java.io.IOException;
import java.io.InputStream;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.demo.richfit.asr.nls.SpeechTranscriberRichfit;

@Controller
public class AudioController {

	@Value("${userName}")
	private String userName;

	@Value("${title}")
	private String title;
	
	@Value("${result}")
	private String result;

	@RequestMapping(value = "/audio/saveRecord")
	@ResponseBody
	public ModelAndView saveRecord() {
		System.out.println("save Audio Record!");
		ModelAndView mode = new ModelAndView();
		mode.addObject("name", userName);
		mode.addObject("title", title);
		mode.setViewName("index");
		return mode;
	}

	@RequestMapping(value = "/audio/upload")
//	@ResponseBody
	public ModelAndView upload(@RequestParam("audioData") MultipartFile mf) {
		System.out.println("Upload Audio Record!" + mf.getName());
		try {
			String appKey = "QygVGKjy3t2cMlOD";
			String token = "66010a0fbe844e9a9d07a1871bfeb2eb";

			SpeechTranscriberRichfit str = new SpeechTranscriberRichfit(appKey, token);
			InputStream ins = mf.getInputStream();
			if (null == ins) {
				System.err.println("open the audio file failed!");
			}
			str.process(ins);
			//str.shutdown();
			result = str.getText();
			
			System.err.println("=======>Text is: "+result);

		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		ModelAndView mode = new ModelAndView();
		mode.addObject("name", userName);
		mode.addObject("title", title);
		mode.addObject("result", result);
		mode.setViewName("result");
		return mode;
	}

}
