package com.cyancloud.dao.hbm;

import java.sql.SQLException;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;

import com.cyancloud.commons.dao.hibernate.BaseDaoHibernate;
import com.cyancloud.dao.TaskForwardDao;
import com.cyancloud.model.task.TaskForward;

public class TaskForwardDaoHbm extends BaseDaoHibernate<TaskForward> implements TaskForwardDao {

	@SuppressWarnings("unchecked")
	@Override
	public List<TaskForward> searchForwardTask(final Long unitId,final Long employeeId) {
		return this.getHibernateTemplate().execute(new HibernateCallback() {
			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				Query query = session.createQuery("from TaskForward o where o.toUnit=:unitId or o.toPeople=:employeeId");
				query.setParameter("unitId", unitId);
				query.setParameter("employeeId", employeeId);
				return query.list();
			}
		});
	}
	
}