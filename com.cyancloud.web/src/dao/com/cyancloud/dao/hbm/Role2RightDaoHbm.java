package com.cyancloud.dao.hbm;

import java.util.List;

import com.cyancloud.commons.dao.hibernate.BaseDaoHibernate;
import com.cyancloud.dao.Role2RightDao;
import com.cyancloud.model.system.Role2Right;

public class Role2RightDaoHbm  extends BaseDaoHibernate<Role2Right> implements
	Role2RightDao {
	
	@Override
	public List<Role2Right> getR2RByRoleId(Long roleId) {
		String hql="from Role2Right r2r where r2r.roleId = "+roleId;
		List<Role2Right> list = (List<Role2Right>)super.queryList(hql);
		return list;
	}

	@Override
	public List<Role2Right> getR2RByRigthId(Long rightId) {
		String hql="from Role2Right r2r where r2r.rightId = "+rightId;
		List<Role2Right> list = (List<Role2Right>)super.queryList(hql);
		return list;
	}
	
	@Override
	public Boolean checkAuthAlloStatus(Long roleId,Long rightId) {
		Boolean flag = false;
		String hql="from Role2Right r2r where r2r.roleId = "+roleId+" and r2r.rightId = "+rightId;
		List<Role2Right> list = (List<Role2Right>)super.queryList(hql);
		if(list != null && list.size() > 0) {
			flag = true;
		}
		return flag;
	}

}
