package com.demo.richfit.asr.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.demo.richfit.asr.bean.ApplyOrder;

@Mapper
public interface ApplyOrderMapper {
	int deleteByPrimaryKey(String id);

    int insert(ApplyOrder record);   

    ApplyOrder selectByPrimaryKey(String id);
    List<ApplyOrder> selectAll();

    int updateByPrimaryKey(ApplyOrder record);    

    List<ApplyOrder> getApplyOrderById(String id);
    
    //int updateByPrimaryKeySelective(ApplyOrder record);
 // int insertSelective(ApplyOrder record);
}
