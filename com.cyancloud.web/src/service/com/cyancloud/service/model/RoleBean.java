package com.cyancloud.service.model;

import com.cyancloud.model.system.Role;

public class RoleBean extends Role {
	private int userNumber = 0;
	private String roleType;
	
	public String getRoleType() {
		return roleType;
	}

	public void setRoleType(String roleType) {
		this.roleType = roleType;
	}

	public int getUserNumber() {
		return userNumber;
	}

	public void setUserNumber(int userNumber) {
		this.userNumber = userNumber;
	}
}
