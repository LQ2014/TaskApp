package com.cyancloud.dao;

import java.util.List;

import com.cyancloud.commons.dao.AbstractDao;
import com.cyancloud.model.system.Account2Role;

public interface Account2RoleDao extends AbstractDao<Account2Role>
{
	public List<Account2Role> getAccount2Role(Long roleId);
	
	public Boolean checkUserAlloStatus(Long roleId,Long accountId);
	
	public List<Account2Role> getAccount2RoleByAccountId(Long accountId);
	
	public List<Account2Role> getAccount2Role(Long accountId,Long roleId);
	
}
