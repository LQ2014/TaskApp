package com.cyancloud.dao;

import java.util.List;

import com.cyancloud.commons.dao.AbstractDao;
import com.cyancloud.model.system.SystemLog;
import com.cyancloud.service.model.SystemLogBean;

public interface SystemLogDao extends AbstractDao<SystemLog> {
	public List<SystemLog> listLog(SystemLogBean logBean);
}
