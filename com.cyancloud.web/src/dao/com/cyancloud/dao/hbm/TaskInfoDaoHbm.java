package com.cyancloud.dao.hbm;

import java.sql.SQLException;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;

import com.cyancloud.commons.dao.hibernate.BaseDaoHibernate;
import com.cyancloud.dao.TaskInfoDao;
import com.cyancloud.model.task.TaskInfo;

public class TaskInfoDaoHbm extends BaseDaoHibernate<TaskInfo> implements TaskInfoDao {
	
	@Override
	public List<TaskInfo> getIssuedTask(final Long unitId, final Long uid) {
		return this.getHibernateTemplate().execute(new HibernateCallback<List<TaskInfo>>() {
			@SuppressWarnings("unchecked")
			@Override
			public List<TaskInfo> doInHibernate(Session session) throws HibernateException, SQLException {
				Query query = session.createQuery("from TaskInfo where acceptUnit = :unitId or acceptPeople = :uid order by createTime desc");
				query.setParameter("unitId", unitId);
				query.setParameter("uid", uid);
				return query.list();
			}
		});
	}

	@Override
	public List<TaskInfo> getTaskInfoByState(final String stateId) {
		return this.getHibernateTemplate().execute(new HibernateCallback<List<TaskInfo>>() {
			@SuppressWarnings("unchecked")
			@Override
			public List<TaskInfo> doInHibernate(Session session) throws HibernateException, SQLException {
				Query query = session.createQuery("from TaskInfo where state = :state");
				query.setParameter("state", stateId);
				return query.list();
			}
		});
	}
	
}