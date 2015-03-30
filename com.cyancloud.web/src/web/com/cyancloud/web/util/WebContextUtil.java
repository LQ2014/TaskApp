package com.cyancloud.web.util;

import org.springframework.web.context.WebApplicationContext;

public class WebContextUtil {
	
	private static WebApplicationContext webApplicationContext;

	@SuppressWarnings("unchecked")
	public static <T> T get(Class<T> clazz, String beanId) {
		return (T) webApplicationContext.getBean(beanId);
	}
	
	public static <T> T get(Class<T> clazz) {
		return webApplicationContext.getBean(clazz);
	}

	public static WebApplicationContext getContext() {
		return webApplicationContext;
	}

	public static WebApplicationContext getWebapplicationcontext() {
		return webApplicationContext;
	}

	public static WebApplicationContext getWebApplicationContext() {
		return webApplicationContext;
	}

	public static void setWebApplicationContext(WebApplicationContext webApplicationContext) {
		WebContextUtil.webApplicationContext = webApplicationContext;
	}
}
