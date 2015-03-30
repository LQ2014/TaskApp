package com.cyancloud.web.init;

import javax.servlet.ServletContextEvent;

public interface IInitable {
	
	/**
	 * 执行初始化方法，Web项目启动时会调用实现该接口的类
	 * @param event
	 */
	void doInit(ServletContextEvent event);
	
	/**
	 * 执行初始化方法的顺序号，不能重复。顺序号从1开始向后执行
	 * @return
	 */
	int getSerno();
}
