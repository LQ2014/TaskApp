package com.cyancloud.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cyancloud.dao.ConfigDao;
import com.cyancloud.model.system.Config;
import com.cyancloud.service.ConfigService;

@Service("configService")
public class ConfigServiceImpl implements ConfigService {
	
	@Autowired
	private ConfigDao configDao;
	
	@Override
	public List<Config> getAll() {
		return this.configDao.getAll();
	}
}
