package com.demo.richfit.asr.bean;

import java.util.Date;

public class ApplyOrder {
	private String id;

	private String message;
	
	private Date createdate;
	private Date lastchangedate;
	
	private String orderstatus;
	
	private String creator;
	private String processor;
	private String lastchangeby;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id == null ? null : id.trim();
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message == null ? null : message.trim();
	}

	public Date getCreatedate() {
		return createdate;
	}

	public void setCreatedate(Date createdate) {
		this.createdate = createdate;
	}

	public Date getLastchangedate() {
		return lastchangedate;
	}

	public void setLastchangedate(Date lastchangedate) {
		this.lastchangedate = lastchangedate;
	}

	public String getOrderstatus() {
		return orderstatus;
	}

	public void setOrderstatus(String orderstatus) {
		this.orderstatus = orderstatus;
	}

	public String getCreator() {
		return creator;
	}

	public void setCreator(String creator) {
		this.creator = creator;
	}

	public String getProcessor() {
		return processor;
	}

	public void setProcessor(String processor) {
		this.processor = processor;
	}

	public String getLastchangeby() {
		return lastchangeby;
	}

	public void setLastchangeby(String lastchangeby) {
		this.lastchangeby = lastchangeby;
	}
}
