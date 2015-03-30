package com.cyancloud.dao.hbm;

import java.sql.SQLException;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;

import com.cyancloud.commons.dao.hibernate.BaseDaoHibernate;
import com.cyancloud.dao.TaskCopyDao;
import com.cyancloud.model.task.TaskCopy;
import com.hp.hpl.sparta.xpath.ThisNodeTest;

public class TaskCopyDaoHbm extends BaseDaoHibernate<TaskCopy> implements TaskCopyDao {

	@SuppressWarnings("unchecked")
	@Override
	public List<TaskCopy> searchCopyTask(final Long uid) {
		return this.getHibernateTemplate().execute(new HibernateCallback() {
			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				Query query = session.createQuery("from TaskCopy o where o.remindEmployee.id = :remindId");
				query.setParameter("remindId", uid);
				return query.list();
			}
		});
	}
	
}