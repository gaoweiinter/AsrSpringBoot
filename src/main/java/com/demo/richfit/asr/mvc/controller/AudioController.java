package com.demo.richfit.asr.mvc.controller;

import java.io.IOException;
import java.io.InputStream;
import java.util.Iterator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.demo.richfit.asr.bean.ApplyOrder;
import com.demo.richfit.asr.nls.SpeechTranscriberRichfit;
import com.demo.richfit.asr.service.ApplyOrderService;

@Controller
public class AudioController {

	@Value("${userName}")
	private String userName;

	@Value("${title}")
	private String title;
	
	@Value("${result}")
	private String result;
	
	@Autowired
	private ApplyOrderService service;

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
			String appKey = "UcfScK2hPeDBV3SN";
			String token = "de2d4de80f8147bb85cd5ed0e628fafd";

			SpeechTranscriberRichfit str = new SpeechTranscriberRichfit(appKey, token);
			InputStream ins = mf.getInputStream();
			if (null == ins) {
				System.err.println("open the audio file failed!");
			}
			str.process(ins);
			//str.shutdown();
			result = str.getText();			
			System.err.println("=======>Text is: "+result);
//			if ((result.contains("都") || result.contains("全")) && (result.contains("批"))) {
		    if (result.contains("可以")) {
				List<ApplyOrder> list = service.getAllApplyOrders();
				Iterator<ApplyOrder> applyOrderIter = list.iterator();
				while (applyOrderIter.hasNext()) {
					ApplyOrder applyorder = applyOrderIter.next();
					if (applyorder.getOrderstatus().contains("In Processing") ) {
						applyorder.setOrderstatus("Approved");
						service.updateByPrimaryKey(applyorder);
						//resultStatus = "申请已批准！";
						System.err.println("=======>Text is: 申请已批准");
					}
				 }
			}

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
