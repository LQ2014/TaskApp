package com.cyancloud.dao.hbm;

import java.util.List;

import org.hibernate.Hibernate;
import org.hibernate.Session;

import com.cyancloud.commons.dao.hibernate.BaseDaoHibernate;
import com.cyancloud.dao.RightDao;
import com.cyancloud.model.system.Right;
import com.cyancloud.model.system.Unit;

public class RightDaoHbm extends BaseDaoHibernate<Right> implements RightDao{
	
	public RightDaoHbm(){
		super(Right.class);
	}
	@Override
	public void addRight(Right right) {
		super.save(right);
	}

	@Override
	public void editRight(Right right) {
		super.update(right);
	}
	@Override
	public Long getNextId() {
		Long id=1L;
		String hql = "select max(id) from Right";
		@SuppressWarnings("unchecked")
		List<Long> ids = (List<Long>)super.queryList(hql);
		if(ids!=null && ids.size()>0){
			Long temp = ids.get(0);
			if(temp!=null){
				id +=temp;
			}
		}
		return id;
		
	}

	@Override
	public List<Right> listAuth(Long parentId) {
		String hql = "from Right r where 1=1";
		if(parentId != null) {
			hql += " and r.parentId="+parentId;
		} else {
			hql += " and (r.parentId is null or r.parentId = '' or r.parentId = 0)";
		}
		return (List<Right>)super.queryList(hql);
		
		
	}
	@Override
	public List<Right> getFirstMenu(Long accountId) {
		String hql ="";
		if(accountId!=null){
			hql = "select distinct r from Right r,Role2Right rr,Account2Role ar where r.isMenu=1 and r.parentId is null and r.id=rr.rightId and rr.roleId=ar.roleId and ar.accountId="+accountId;	
		}
		else{
			hql = "select r from Right r where r.isMenu=1 and r.parentId is null ";
		}
		hql+=" order by r.list";
		return (List<Right>)super.queryList(hql);
	}
	@Override
	public List<Right> getMenu(Long accountId) {
		
		String hql ="";
		if(accountId!=null){
			hql = "select distinct r from Right r,Role2Right rr,Account2Role ar where r.isMenu=1 " +
			"and r.id=rr.rightId and rr.roleId=ar.roleId and ar.accountId="+accountId;	
		}
		else{
			hql = "select r from Right r where r.isMenu=1";
		}
		
		hql+=" order by r.parentId,r.list";
		
		return (List<Right>)super.queryList(hql);
	}
	
}
