package com.cyancloud.web.init;

import javax.servlet.ServletContextEvent;

import com.cyancloud.web.util.EnumConstUtil;

public class EnumConstInit implements IInitable {

	@Override
	public void doInit(ServletContextEvent event) {
		EnumConstUtil.reload();
	}

	@Override
	public int getSerno() {
		return 3;
	}

}
