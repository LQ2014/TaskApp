package com.cyancloud.dao;

import java.util.List;

import com.cyancloud.commons.dao.AbstractDao;
import com.cyancloud.model.system.Role2Right;

public interface Role2RightDao extends AbstractDao<Role2Right>{
	
	public List<Role2Right> getR2RByRoleId(Long roleId);
	
	public List<Role2Right> getR2RByRigthId(Long rightId);
	
	public Boolean checkAuthAlloStatus(Long roleId,Long rightId);

}
