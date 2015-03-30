package com.cyancloud.dao;

import java.util.List;

import com.cyancloud.commons.dao.AbstractDao;
import com.cyancloud.model.system.Right;

public interface RightDao extends AbstractDao<Right>{
	
	public void addRight(Right right);
	
	public void editRight(Right right);
	
	public List<Right> listAuth(Long parentId);

	public List<Right> getFirstMenu(Long accountId);
	
	public List<Right> getMenu(Long accountId);

	public Long getNextId();
	
}
