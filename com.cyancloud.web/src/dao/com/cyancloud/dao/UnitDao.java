package com.cyancloud.dao;

import java.util.Date;
import java.util.List;

import com.cyancloud.commons.dao.AbstractDao;
import com.cyancloud.model.system.Unit;

public interface UnitDao extends AbstractDao<Unit> {

	public Unit findById(Long id);

	public Date getLastSyncUnitTime();
	
	public List<Unit> getUnitByParentId(Long parentId);

}
