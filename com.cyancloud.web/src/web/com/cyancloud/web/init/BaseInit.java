package com.cyancloud.web.init;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.apache.log4j.Logger;

public class BaseInit implements ServletContextListener {

	private static final Logger logger = Logger.getLogger(BaseInit.class);
	
	public static final Map<Integer, IInitable> initMap = new HashMap<Integer, IInitable>();
	
	static {
		WebContextInit webContextInit = new WebContextInit();
		ConfigInit configInit = new ConfigInit();
		EnumConstInit constInit = new EnumConstInit();
		initMap.put(webContextInit.getSerno(), webContextInit);
		initMap.put(configInit.getSerno(), configInit);
		initMap.put(constInit.getSerno(), constInit);
	}
	
	@Override
	public void contextDestroyed(ServletContextEvent event) {
		
	}

	@Override
	public void contextInitialized(ServletContextEvent event) {
		try {
			IInitable init = null;
			for (int i = 0; i < initMap.size(); ++i) {
				init = initMap.get(i + 1);
				logger.debug("执行初始化资源类：" + init.getClass().getName());
				init.doInit(event);
			}
		} catch (Exception e) {
			logger.error("初始化资源异常，系统启动失败...", e);
			System.exit(0);
		}
	}
}
