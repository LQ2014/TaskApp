package com.cyancloud.web.model;

public class ConnectSetModel {
	public String host;
	public String port;
	public String user;
	public String password;
	public String basedn;
	public String rootdn;
	public String type;
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
	public String getBasedn() {
		return basedn;
	}
	public void setBasedn(String basedn) {
		this.basedn = basedn;
	}
	public String getRootdn() {
		return rootdn;
	}
	public void setRootdn(String rootdn) {
		this.rootdn = rootdn;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
}
