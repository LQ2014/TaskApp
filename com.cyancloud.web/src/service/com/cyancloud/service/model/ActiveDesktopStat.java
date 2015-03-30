package com.cyancloud.service.model;

import java.util.Date;

public class ActiveDesktopStat {
	
	private Date sample;

	private String time;
	
	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}

	private Integer count;

	public Date getSample() {
		return sample;
	}

	public void setSample(Date sample) {
		this.sample = sample;
	}

	public Integer getCount() {
		return count;
	}

	public void setCount(Integer count) {
		this.count = count;
	}
	
	

}
