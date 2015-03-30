package com.cyancloud.dao.hbm;

import java.util.List;

import com.cyancloud.commons.dao.hibernate.BaseDaoHibernate;
import com.cyancloud.dao.Account2RoleDao;
import com.cyancloud.model.system.Account2Role;

public class Account2RoleDaoHbm extends BaseDaoHibernate<Account2Role> implements
		Account2RoleDao {
	public List<Account2Role> getAccount2Role(Long roleId) {
		String hql="from Account2Role a2r where a2r.roleId = "+roleId;
		return (List<Account2Role>)super.queryList(hql);
	}
	
	public Boolean checkUserAlloStatus(Long roleId,Long accountId) {
		Boolean flag = false;
		String hql="from Account2Role a2r where a2r.roleId = "+roleId+" and a2r.accountId = "+accountId;
		List<Account2Role> list = (List<Account2Role>)super.queryList(hql);
		if(list != null && list.size() > 0) {
			flag = true;
		}
		return flag;
		
	}
	
	public List<Account2Role> getAccount2RoleByAccountId(Long accountId) {
		String hql="from Account2Role a2r where a2r.accountId = "+accountId;
		return (List<Account2Role>)super.queryList(hql);
	}
	
	public List<Account2Role> getAccount2Role(Long accountId,Long roleId) {
		String hql="from Account2Role a2r where a2r.accountId = "+accountId+" and a2r.roleId = "+roleId;
		List<Account2Role> list = (List<Account2Role>) super.queryList(hql);
		return list;
	}
}
