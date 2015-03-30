package com.cyancloud.dao.hbm;

import java.util.List;

import com.cyancloud.commons.dao.hibernate.BaseDaoHibernate;
import com.cyancloud.dao.ConfigDao;
import com.cyancloud.model.system.Config;

public class ConfigDaoHbm extends BaseDaoHibernate<Config> implements ConfigDao {

	@SuppressWarnings("unchecked")
	@Override
	public List<Config> searchConfig(Config config) {
		String hql="from Config a where 1=1";
		if(config!=null){
			if(config.getKey()!=null)
				hql+=" and a.key like '%"+config.getKey()+"%'";
			if(config.getValue()!=null)
				hql+=" and a.value like '%"+config.getValue()+"%'";
		}
			
		hql+=" order by a.key";
		
		return (List<Config>)super.queryList(hql);
	}
	
}
