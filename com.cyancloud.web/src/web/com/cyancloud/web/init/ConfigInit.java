package com.cyancloud.web.init;

import javax.servlet.ServletContextEvent;

import com.cyancloud.web.util.ConfigUtil;

public class ConfigInit implements IInitable {

	@Override
	public void doInit(ServletContextEvent event) {
		ConfigUtil.reload();
	}

	@Override
	public int getSerno() {
		return 2;
	}

}
