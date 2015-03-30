package com.cyancloud.model.system;

import java.io.Serializable;


public class SystemParam implements Serializable{	
	private static final long serialVersionUID = 1L;
	
	public static String TYPE_ACCOUNT="account";
	public static String TYPE_ROLETYPE="roletype";
	public static String TYPE_SERVICE="service";
	public static String TYPE_SYSTEM="system";
	
	public static String SYSTEM_VM_AD_HOST="system.vm.ad.host";
	public static String SYSTEM_VM_AD_USER="system.vm.ad.user";
	public static String SYSTEM_VM_AD_PASSWORD="system.vm.ad.password";
	public static String SYSTEM_VM_AD_ROOTDN="system.vm.ad.rootdn";
	public static String SYSTEM_VM_AD_BASEDN="system.vm.ad.basedn";
	public static String SYSTEM_VM_AD_LOGIN="system.vm.ad.login";//是否启用ad登陆，默认为true
	
	public static String SYSTEM_VM_VCENTER_HOST="system.vm.vcenter.host";
	public static String SYSTEM_VM_VCENTER_PORT="system.vm.vcenter.port";
	public static String SYSTEM_VM_VCENTER_USER="system.vm.vcenter.user";
	public static String SYSTEM_VM_VCENTER_PASSWORD="system.vm.vcenter.password";
	
	public static String SYSTEM_VM_MANAGER_HOST="system.vm.manager.host";
	public static String SYSTEM_VM_MANAGER_PORT="system.vm.manager.port";

	public static String SYSTEM_VM_HVADAPTER_HOST="system.vm.hvadapter.host";
	public static String SYSTEM_VM_HVADAPTER_PORT="system.vm.hvadapter.port";
	
	public static String SYSTEM_VM_HV_HOST="system.vm.hv.host";//view 连接服务器，可能跟adapter不在一起
	public static String SYSTEM_VM_HV_PORT="system.vm.hv.port";
	
	public static String SYSTEM_MAIL_HOST="system.mail.host";
	public static String SYSTEM_MAIL_PORT="system.mail.port";
	public static String SYSTEM_MAIL_USER="system.mail.user";
	public static String SYSTEM_MAIL_PASSWORD="system.mail.password";	
	
	private String type;

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	
	
}
