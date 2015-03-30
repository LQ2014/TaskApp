package com.cyancloud.dao;

import java.util.List;

import com.cyancloud.commons.dao.AbstractDao;
import com.cyancloud.model.system.Account2Role;
import com.cyancloud.model.system.Role;

public interface RoleDao extends AbstractDao<Role> {
	
	public Role getById(Long id);

	public List<Role> listRole();
	
	public List<Role> getRoleByAccountId(Long uid);
	
	public List<Role> getRoleByType(String type);
	
}
