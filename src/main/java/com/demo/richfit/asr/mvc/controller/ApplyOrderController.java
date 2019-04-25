package com.demo.richfit.asr.mvc.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.demo.richfit.asr.bean.ApplyOrder;
import com.demo.richfit.asr.service.ApplyOrderService;

@RestController
@RequestMapping("/applyorder")
public class ApplyOrderController {

	@Autowired
	private ApplyOrderService service;
	
    @RequestMapping("/getAll")
    public List<ApplyOrder> getAllApplyOrders(){
        System.out.println("get all aplly orders!");
        
        List<ApplyOrder> resultList = service.getAllApplyOrders();
        System.out.println(resultList.toString());
		return resultList;
	
    }
    
    @RequestMapping("/getByID")
    public List<ApplyOrder> getApplyOrderById(@RequestParam("id") String id){
        List<ApplyOrder> list = service.getApplyOrderById(id);
        return list;
    }
    
    @RequestMapping(value = "/add",method = RequestMethod.POST)
    public int addApplyOrder(@RequestBody ApplyOrder applyOrder){
        return service.addApplyOrder(applyOrder);
    }
    
    @RequestMapping(value="/delOrderById",method=RequestMethod.POST)
    public int delApplyOrderById(@RequestParam("id") String id){
            return service.delApplyOrder(id);
    }
}
