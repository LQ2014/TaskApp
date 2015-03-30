package com.cyancloud.service.model;

import java.util.List;

import org.codehaus.jackson.map.annotate.JsonSerialize;

import com.cyancloud.model.system.Employee;
import com.cyancloud.model.system.Unit;

@JsonSerialize(include=JsonSerialize.Inclusion.NON_NULL)
public class UnitBean extends Unit {

	private static final long serialVersionUID = 4683738442006471998L;

	private String parentName;
	
	private String isLeaf;
	
	private List<UnitBean> childs;
	
	private List<Employee> employees;

	public String getParentName() {
		return parentName;
	}

	public void setParentName(String parentName) {
		this.parentName = parentName;
	}

	public String getIsLeaf() {
		return isLeaf;
	}

	public void setIsLeaf(String isLeaf) {
		this.isLeaf = isLeaf;
	}

	public List<UnitBean> getChilds() {
		return childs;
	}

	public void setChilds(List<UnitBean> childs) {
		this.childs = childs;
	}

	public List<Employee> getEmployees() {
		return employees;
	}

	public void setEmployees(List<Employee> employees) {
		this.employees = employees;
	}
	
}
