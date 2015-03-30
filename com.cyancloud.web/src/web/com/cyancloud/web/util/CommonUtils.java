/*****************************************************************************
 * CESM - CyanWay Enterprise Storage Manager
 * (C) Copyright CyanWay Information Technology (China) Co., Ltd. 2008, 2009
 * All rights reserved. 
 ******************************************************************************/
package com.cyancloud.web.util;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.text.DecimalFormat;
import java.util.Date;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import com.cyancloud.commons.web.SessionAttributeNames;
import com.cyancloud.model.system.SystemLog;

public class CommonUtils {
	public static String getFormatValue(Double value) {
		if(value != null) {
			DecimalFormat fmtOfNumber= new  DecimalFormat("#####0.00");
			return fmtOfNumber.format(value);
		} else {
			return "";
		}
	}

	public static String getLocalIP() {
		String ip = "";
		try {
			InetAddress addr = InetAddress.getLocalHost();
			ip = addr.getHostAddress().toString();//获得本机IP
		} catch (UnknownHostException e) {
			e.getCause();
		}
		return ip;
	}
	
	public static String getAccessPath(HttpServletRequest request) {
		String url = request.getScheme()+"://";   
        url+=request.getHeader("host");   
        url+=request.getRequestURI();   
        if(request.getQueryString()!=null)   
              url+="?"+request.getQueryString();   
//           System. out.println(url);
		return url;
	}
	public static SystemLog getSystemLog(HttpServletRequest request,String mCode,String desc,Long result) {
		SystemLog log = new SystemLog();
		log.setIp(getLocalIP());
		log.setInpath(getAccessPath(request));
		log.setMcode(mCode);
		log.setDescription(desc);
		log.setOptime(new Date());
		log.setUcode(SessionAttributeNames.getSessionAttribute(request, "ucode"));
		log.setUid(SessionAttributeNames.getSessionAttribute(request, "uid"));
		log.setDeptname(SessionAttributeNames.getDcode(request));
		log.setResult(result);
		return log;
	}
	
	public static String fixnull(Object obj){
		return obj == null ? "" : String.valueOf(obj);
	}
	
	public static String getUUID(){
		return UUID.randomUUID().toString().replace("-", "");
	}
	
}
