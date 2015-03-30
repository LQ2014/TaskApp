package com.cyancloud.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cyancloud.commons.service.BaseService;
import com.cyancloud.dao.AccountDao;
import com.cyancloud.dao.SystemLogDao;
import com.cyancloud.model.system.SystemLog;
import com.cyancloud.service.SystemService;
import com.cyancloud.service.model.SystemLogBean;

@Service("systemLogService")
public class SystemServiceImpl extends BaseService implements
		SystemService {
	@Autowired
	protected SystemLogDao systemLogDao;
	
	@Autowired
	private AccountDao accountDao;
	
	@Override
	public void addLog(SystemLog opLog) {
		systemLogDao.save(opLog);
	}

	@Override
	public List<SystemLog> listLog(SystemLogBean logBean) {
		return systemLogDao.listLog(logBean);
		
	}	



}
	
