package com.cyancloud.dao.hbm;

import java.util.List;

import com.cyancloud.commons.dao.hibernate.BaseDaoHibernate;
import com.cyancloud.dao.SystemLogDao;
import com.cyancloud.model.system.SystemLog;
import com.cyancloud.service.model.SystemLogBean;


public class LogDaoHbm extends BaseDaoHibernate<SystemLog> implements SystemLogDao
{
	protected LogDaoHbm()
	{
		super(SystemLog.class);
	}
	
	@Override
	public List<SystemLog> listLog(SystemLogBean logBean) {
		StringBuilder sb = new StringBuilder("from SystemLog m where 1=1 ");
		if (logBean != null) {
			
		}
		List<SystemLog> list = (List<SystemLog>) super.queryList(sb.toString());
		return list;
	}
}
