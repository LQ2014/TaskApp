package com.cyancloud.dao.hbm;

import java.util.List;

import com.cyancloud.commons.dao.hibernate.BaseDaoHibernate;
import com.cyancloud.dao.RoleDao;
import com.cyancloud.model.system.Account2Role;
import com.cyancloud.model.system.Role;

public class RoleDaoHbm  extends BaseDaoHibernate<Role> implements
		RoleDao {
	public RoleDaoHbm() {
		super(Role.class);
	}

	@Override
	public Role getById(Long id) {
		return super.findById(id);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Role> listRole() {
		String hql = "from Role order by name";
		return (List<Role>)super.queryList(hql);
	}

	@Override
	public List<Role> getRoleByAccountId(Long uid) {
		String hql ="from Role r where r.id in (select roleId from Account2Role where accountId="+uid+")";
		
		return ( List<Role>)super.queryList(hql);
	}
	
	@Override
	public List<Role> getRoleByType(String type) {
		String hql ="from Role r where r.type = '"+type+"'";
		return ( List<Role>)super.queryList(hql);
	}
	
}