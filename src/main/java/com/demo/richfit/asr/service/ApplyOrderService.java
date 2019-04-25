package com.demo.richfit.asr.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.demo.richfit.asr.bean.ApplyOrder;
import com.demo.richfit.asr.mapper.ApplyOrderMapper;

@Service
public class ApplyOrderService {

	@Autowired
    private ApplyOrderMapper mapper;
	
    public List<ApplyOrder> getApplyOrder(){
        List<ApplyOrder> list = new ArrayList<ApplyOrder>();
        list.add(mapper.selectByPrimaryKey("xtt"));
        //list = mapper.selectAll();
        return list;
   }
    
   public List<ApplyOrder> getAllApplyOrders(){
        List<ApplyOrder> list = new ArrayList<ApplyOrder>();
        list = mapper.selectAll();
        return list;
   }
   
   public int addApplyOrder(ApplyOrder applyorder) {
       return mapper.insert(applyorder);
   }
   
   public List<ApplyOrder> getApplyOrderById(String id) {
       return mapper.getApplyOrderById(id);
   }
 
   public int delApplyOrder(String id) {
       return mapper.deleteByPrimaryKey(id);
   }   
	
}
