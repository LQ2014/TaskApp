package com.cyancloud.web.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


import org.apache.log4j.Logger;

import com.cyancloud.model.system.EnumConst;
import com.cyancloud.service.EnumConstService;

public final class EnumConstUtil {
	 
	private static final Logger logger = Logger.getLogger(EnumConstUtil.class);
	
	private static final Map<String, List<EnumConst>> NAMESPACE_GROUP = new HashMap<String, List<EnumConst>>();
	
	private static final Map<String, Map<String, EnumConst>> NAMESPACE_AND_CODE_GROUP = new HashMap<String, Map<String,EnumConst>>();
	
	private EnumConstUtil() {}
	
	private static void add(EnumConst enumConst) {
		if (NAMESPACE_GROUP.containsKey(enumConst.getNamespace())) {
			NAMESPACE_GROUP.get(enumConst.getNamespace()).add(enumConst);
		} else {
			List<EnumConst> list = new ArrayList<EnumConst>();
			list.add(enumConst);
			NAMESPACE_GROUP.put(enumConst.getNamespace(), list);
		}
		
		if (NAMESPACE_AND_CODE_GROUP.containsKey(enumConst.getNamespace())) {
			NAMESPACE_AND_CODE_GROUP.get(enumConst.getNamespace()).put(enumConst.getCode(), enumConst);
		} else {
			Map<String, EnumConst> map = new HashMap<String, EnumConst>();
			map.put(enumConst.getCode(), enumConst);
			NAMESPACE_AND_CODE_GROUP.put(enumConst.getNamespace(), map);
		}
	}
	
	public static List<EnumConst> getEnumConstsByNamespace(String namespace) {
		return NAMESPACE_GROUP.get(namespace);
	}
	
	public static EnumConst getEnumConstByNamespaceAndCode(String namespace, String code) {
		try {
			return NAMESPACE_AND_CODE_GROUP.get(namespace).get(code);
		} catch (Exception e) { }
		return null;
	}
	
	public static void reload() {
		List<EnumConst> list = WebContextUtil.get(EnumConstService.class).getAllEnumConsts();
		if (null != list && list.size() > 0) {
			NAMESPACE_GROUP.clear();
			NAMESPACE_AND_CODE_GROUP.clear();
			for (EnumConst enumConst : list) {
				add(enumConst);
			}
		}
		logger.info("reload enumconst successful.");
	}
	
	public static String getConstId(String namespace, String code) {
		EnumConst enumConst = getEnumConstByNamespaceAndCode(namespace, code);
		return (null == enumConst) ? null  : enumConst.getId();
	}
}
