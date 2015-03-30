package com.cyancloud.service.model;

import com.cyancloud.model.system.Account;

public class AccountBean extends Account {
	private String deptName;
	private String dcode;
	private int pageNo;
	private int pageSize = 20;
	
	private String typeName;

	public int getPageNo() {
		return pageNo;
	}

	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public AccountBean() {
	}

	public AccountBean(Account account) {
		super.setId(account.getId());
		super.setUcode(account.getUcode());
		super.setUname(account.getUname());
		super.setPhone(account.getPhone());
		super.setEmail(account.getEmail());
		super.setState(account.getState());
		super.setPassword(account.getPassword());
		super.setCtime(account.getCtime());
		super.setDateline(account.getDateline());
	}

	public String getDeptName() {
		return deptName;
	}

	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}

	public String getTypeName() {
		return typeName;
	}

	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}

	public String toString() {
		StringBuilder sb = new StringBuilder("");
		sb.append("dcode").append( dcode);
		sb.append("deptName").append( deptName);
		return sb.toString();
	}

	public String getDcode() {
		return dcode;
	}

	public void setDcode(String dcode) {
		this.dcode = dcode;
	}

}
