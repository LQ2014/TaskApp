package com.cyancloud.service.model;



public class MailBean{
	public MailBean(){};
	public MailBean(String host,String port,String user,String password){
		this.host=host;
		this.port=port;
		this.user=user;
		this.password=password;
	}
	private String host;//服务器
	private String port;//服务器端口
	private String user;//发件人
	private String password;//发件人密码
	
	private String userM;//测试收件人
	private String titleM;//测试邮件主题
	private String contentM;//测试邮件内容
	
	public String getUserM() {
		return userM;
	}
	public void setUserM(String userM) {
		this.userM = userM;
	}
	public String getTitleM() {
		return titleM;
	}
	public void setTitleM(String titleM) {
		this.titleM = titleM;
	}
	public String getContentM() {
		return contentM;
	}
	public void setContentM(String contentM) {
		this.contentM = contentM;
	}
	
	public String getHost() {
		return host;
	}
	public void setHost(String host) {
		this.host = host;
	}
	public String getPort() {
		return port;
	}
	public void setPort(String port) {
		this.port = port;
	}
	public String getUser() {
		return user;
	}
	public void setUser(String user) {
		this.user = user;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	
	public boolean valid(){
		boolean valid = false;
		if(this.host!=null && this.host.length()>0 && this.port!=null && this.port.length()>0 && this.user!=null && this.user.length()>0&& this.password!=null && this.password.length()>0)
			valid = true;
		return valid;
	}
	
}
