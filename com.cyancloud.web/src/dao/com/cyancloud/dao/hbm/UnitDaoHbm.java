package com.cyancloud.dao.hbm;

import java.util.Date;
import java.util.List;

import com.cyancloud.commons.dao.hibernate.BaseDaoHibernate;
import com.cyancloud.dao.UnitDao;
import com.cyancloud.model.system.Account;
import com.cyancloud.model.system.Unit;

public class UnitDaoHbm extends BaseDaoHibernate<Unit> implements UnitDao {
	public UnitDaoHbm() {
		super(Unit.class);
	}

	@Override
	public Unit findById(Long id) {
		return super.findById(id);
	}

	@SuppressWarnings("unchecked")
	@Override
	public Date getLastSyncUnitTime() {
		String hql = "select max(updateDate) from Unit";
		List<Date> list = (List<Date>)super.queryList(hql);
		if(list!=null && list.size()>0){
			return list.get(0);
		}else
			return null;
	}
	
	@Override
	public List<Unit> getUnitByParentId(Long parentId) {
		String hql ="from Unit u where 1=1 ";
		if(parentId == null) {
			hql += "and (u.parentId is null or u.parentId = '' or u.parentId = 0) ";
		} else {
			hql += "and u.parentId = "+parentId;
		}
		return (List<Unit>)super.queryList(hql);
	}
}