package com.cyancloud.service.model;

import java.util.List;

import com.cyancloud.model.system.Right;

public class RightBean extends Right {

	private static final long serialVersionUID = 8260354147916734547L;

	private String parentName;
	
	private String isLeaf;
	
	private List<RightBean> childs;

	
	public List<RightBean> getChilds() {
		return childs;
	}

	public void setChilds(List<RightBean> childs) {
		this.childs = childs;
	}

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
	
}
