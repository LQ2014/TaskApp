package com.cyancloud.web.util;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import com.cyancloud.model.system.Config;
import com.cyancloud.service.ConfigService;

public final class ConfigUtil {
	 
	private static final Logger logger = Logger.getLogger(ConfigUtil.class);
	
	private static final Map<String, String> PROPERTIES = new HashMap<String, String>();
	
	private static final Map<String, Map<String, String>> ALL_PROPERTIES = new HashMap<String, Map<String,String>>();
	
	private ConfigUtil() {}
	
	public static void add(Config cfg) {
		if (PROPERTIES.containsKey(cfg.getKey())) {
			logger.warn("Config key: " + cfg.getKey() + " is already exists, overide with: " + cfg.getValue());
		}
		PROPERTIES.put(cfg.getKey(), cfg.getValue());
		PROPERTIES.put(cfg.getKey() + "@" + cfg.getValue(), cfg.getDesc());
		
		if (ALL_PROPERTIES.containsKey(cfg.getKey())) {
			ALL_PROPERTIES.get(cfg.getKey()).put(cfg.getValue(), cfg.getDesc());
		} else {
			Map<String, String> map = new HashMap<String, String>();
			map.put(cfg.getValue(), cfg.getDesc());
			ALL_PROPERTIES.put(cfg.getKey(), map);
		}
	}
	
	public static String getCfg(String key) {
		return PROPERTIES.get(key);
	}
	
	public static String getDesc(String key, String value) {
		return PROPERTIES.get(key + "@" + value);
	}
	
	public static Map<String, String> getValDesc(String key) {
		return ALL_PROPERTIES.get(key);
	}
	
	public static boolean isEmpty() {
		return PROPERTIES.size() == 0;
	}
	
	public static void reload() {
		List<Config> list = WebContextUtil.get(ConfigService.class).getAll();
		if (null != list && list.size() > 0) {
			PROPERTIES.clear();
			for (Config cfg : list) {
				add(cfg);
			}
		}
		logger.info("reload config successful.");
	}
}
