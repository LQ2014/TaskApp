package com.cyancloud.service.model;

import com.cyancloud.model.system.Employee;

public class EmployeeBean extends Employee {

	private static final long serialVersionUID = 1261708289012535404L;

	private String deptName;
	private String dcode;
	private int pageNo;
	private int pageSize = 20;
	private String unitName;
	
	
	public EmployeeBean(Employee employee) {
		super.setId(employee.getId());
		super.setCode(employee.getCode());
		super.setName(employee.getName());
		super.setUnitId(employee.getUnitId());
		super.setCtime(employee.getCtime());
		super.setUpdateDate(employee.getUpdateDate());
		
		super.setIcon(employee.getIcon());
		super.setNickname(employee.getNickname());
		super.setPhone(employee.getPhone());
		super.setAddress(employee.getAddress());
		super.setWeixin(employee.getWeixin());
		super.setQq(employee.getQq());
		super.setEmail(employee.getEmail());
		super.setResume(employee.getResume());
		
		super.setScore(employee.getScore());
		super.setIsShowScore(employee.getIsShowScore());
		super.setState(employee.getState());
	}

	public EmployeeBean() {
	}

	public String getDeptName() {
		return deptName;
	}

	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}

	public String getDcode() {
		return dcode;
	}

	public void setDcode(String dcode) {
		this.dcode = dcode;
	}

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
	
	public String toString() {
		StringBuilder sb = new StringBuilder("");
		sb.append("dcode").append( dcode);
		sb.append("deptName").append( deptName);
		return sb.toString();
	}
	
	public String getUnitName() {
		return unitName;
	}
	public void setUnitName(String unitName) {
		this.unitName = unitName;
	}

}
