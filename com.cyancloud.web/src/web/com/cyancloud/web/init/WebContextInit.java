package com.cyancloud.web.init;

import javax.servlet.ServletContextEvent;

import org.springframework.web.context.support.WebApplicationContextUtils;

import com.cyancloud.web.util.WebContextUtil;

public class WebContextInit implements IInitable {

	@Override
	public void doInit(ServletContextEvent event) {
		WebContextUtil.setWebApplicationContext(WebApplicationContextUtils.getWebApplicationContext(event.getServletContext()));
	}

	@Override
	public int getSerno() {
		return 1;
	}

}
