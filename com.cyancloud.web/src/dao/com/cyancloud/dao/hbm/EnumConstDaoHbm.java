package com.cyancloud.dao.hbm;

import java.sql.SQLException;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;

import com.cyancloud.commons.dao.hibernate.BaseDaoHibernate;
import com.cyancloud.dao.EnumConstDao;
import com.cyancloud.model.system.EnumConst;

public class EnumConstDaoHbm extends BaseDaoHibernate<EnumConst> implements EnumConstDao{

	@SuppressWarnings("unchecked")
	@Override
	public List<EnumConst> searchEnumConstByNamespace(String namespace) {
		return (List<EnumConst>)this.queryList("from EnumConst where namespace='"+namespace+"'");
	}

	@SuppressWarnings("unchecked")
	@Override
	public EnumConst getEnumConstByNamespaceAndCode(final String namespace,
			final String code) {			
		return this.getHibernateTemplate().execute(new HibernateCallback() {
			@Override
			public EnumConst doInHibernate(Session session)
					throws HibernateException, SQLException {
				Query query = session.createQuery("from EnumConst o where o.code=:code and o.namespace=:namespace");
				query.setString("code", code);
				query.setString("namespace", namespace);
				return (EnumConst)query.uniqueResult();
			}
		});
	}

}
