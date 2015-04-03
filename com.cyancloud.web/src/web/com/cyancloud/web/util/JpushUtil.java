package com.cyancloud.web.util;

import cn.jpush.api.JPushClient;
import cn.jpush.api.common.resp.APIConnectionException;
import cn.jpush.api.common.resp.APIRequestException;
import cn.jpush.api.push.PushResult;

public class JpushUtil {
	private static final String APP_KEY="94e97dc069fa57c12ca291af";
	private static final String MASTER_SECRET="29912565fb8c6cd3eba30575";
	

	@SuppressWarnings("unused")
	public static String sendMsg(String title,String content,String alias){
		JPushClient jpush = new JPushClient(APP_KEY, MASTER_SECRET);
		String code = "";
		try {
			jpush.sendAndroidMessageWithAlias("极光推送测试", "有错误联系我", "jjj");
			
		} catch (APIConnectionException e) {
			e.printStackTrace();
		} catch (APIRequestException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public static void main(String args[]){
		sendMsg(null,null,null);
	}

}
