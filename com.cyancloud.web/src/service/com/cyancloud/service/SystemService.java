package com.cyancloud.service;

import java.util.List;

import com.cyancloud.model.system.SystemLog;
import com.cyancloud.service.model.SystemLogBean;

public interface SystemService {
	
	public void addLog(SystemLog opLog);

	public List<SystemLog> listLog(SystemLogBean logBean);	

}


