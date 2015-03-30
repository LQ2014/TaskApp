package com.cyancloud.web.model;

import com.cyancloud.commons.entity.BaseEntity;

public class AccountModel extends BaseEntity {
	private String ucode;
	private String password;
	private String mcode;
	private String uname;
	private String dcode;
	private Long ustate;

	public String getUcode() {
		return ucode;
	}

	public void setUcode(String ucode) {
		this.ucode = ucode;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public Long getUstate() {
		return ustate;
	}

	public void setUstate(Long ustate) {
		this.ustate = ustate;
	}

	public String getUname() {
		return uname;
	}

	public void setUname(String uname) {
		this.uname = uname;
	}

	public String getDcode() {
		return dcode;
	}

	public void setDcode(String dcode) {
		this.dcode = dcode;
	}

	public String getMcode() {
		return mcode;
	}

	public void setMcode(String mcode) {
		this.mcode = mcode;
	}

	@Override
	public String toString() {
		StringBuilder sb = new StringBuilder();
		sb.append("mcode:").append(mcode);
		sb.append("uname:").append(uname);
		sb.append("dcode:").append(dcode);
		sb.append("ustate:").append(ustate);
		return sb.toString();
	}

	@Override
	public Object objId() {
		// TODO Auto-generated method stub
		return null;
	}

}
