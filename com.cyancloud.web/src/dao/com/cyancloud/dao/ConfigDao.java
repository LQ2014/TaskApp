package com.cyancloud.dao;

import java.util.List;

import com.cyancloud.commons.dao.AbstractDao;
import com.cyancloud.model.system.Config;

public interface ConfigDao extends AbstractDao<Config> {
	
	public List<Config> searchConfig(Config config);
	
}
