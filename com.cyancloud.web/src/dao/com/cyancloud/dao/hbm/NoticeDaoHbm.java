package com.cyancloud.dao.hbm;

import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.hibernate.HibernateException;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;

import com.cyancloud.commons.dao.hibernate.BaseDaoHibernate;
import com.cyancloud.dao.NoticeDao;
import com.cyancloud.model.notice.Notice;
import com.cyancloud.model.system.Account;
import com.cyancloud.service.model.NoticeBean;
import com.cyancloud.web.util.CommonUtils;

public class NoticeDaoHbm extends BaseDaoHibernate<Notice> implements NoticeDao{

	@SuppressWarnings("unchecked")
	@Override
	public int executeSql(final String sql,final Map<String,Object> map) throws Exception {
		return this.getHibernateTemplate().execute(new HibernateCallback() {
			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				SQLQuery query = session.createSQLQuery(sql);
				if(map!=null){
					Set<String> keys = map.keySet();
					for (Iterator it = keys.iterator(); it.hasNext();) {
						String key = (String) it.next();
						query.setParameter(key, map.get(key));
					}
				}
				return query.executeUpdate();
			}
		});		
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<NoticeBean> queryListByAccount(final Account account) {
		return this.getHibernateTemplate().execute(new HibernateCallback() {
			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				List<NoticeBean> listNotice = new ArrayList<NoticeBean>();
				SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				StringBuffer sql = new StringBuffer();
				sql.append("	SELECT															");
				sql.append("	n.TITLE,														");
				sql.append("	n.CONTENT,														");
				sql.append("	n.create_date,													");
				sql.append("	ac.uname														");
				sql.append("	FROM															");
				sql.append("		t_res_notice_employee ne									");
				sql.append("		INNER JOIN t_res_notice n ON n.id = ne.FK_NOTICE_ID			");
				sql.append("	INNER JOIN t_res_const cst ON cst.id = n.FLAG_ISPUBLISHED		");
				sql.append("	AND cst. CODE = '1'												");
				sql.append("	LEFT JOIN t_res_account ac ON ac.id = n.FK_ACCOUNT_PUBLISHER	");
				sql.append("	where ne.fk_employee_id =:employee								");
				SQLQuery query = session.createSQLQuery(sql.toString());
				query.setParameter("employee", account.getId());
				List<Object[]> rs = query.list();
				sql = new StringBuffer();
				sql.append("	select															");
				sql.append("		n.id,														");
				sql.append("		n.title,													");
				sql.append("		n.content,													");
				sql.append("		n.create_date,												");
				sql.append("		ac.uname													");
				sql.append("	from															");
				sql.append("		t_res_notice_unit nun										");
				sql.append("	inner join t_res_notice n on n.id = nun.fk_notice_id			");
				sql.append("	inner join t_res_unit unit on unit.id = nun.fk_unit_id			");
				sql.append("	inner join t_res_const cst on cst.id = n.flag_ispublished		");
				sql.append("	and cst. code = '1'												");
				sql.append("	left join t_res_account ac on ac.id = n.fk_account_publisher	");
				sql.append("	where unit.name ='"+account.getUcode()+"'						");
				query = session.createSQLQuery(sql.toString());
				rs = query.list();
				for (Iterator it = rs.iterator(); it.hasNext();) {
					Object[] data = (Object[]) it.next();
					NoticeBean bean = new NoticeBean();
					bean.setId(CommonUtils.fixnull(data[0]));
					bean.setTitle(CommonUtils.fixnull(data[1]));
					bean.setContent(CommonUtils.fixnull(data[2]));
					try {
						bean.setCreateDate(format.parse(CommonUtils.fixnull(data[3])));
					} catch (ParseException e) {						
						e.printStackTrace();
					}
					bean.setPublisherName(CommonUtils.fixnull(data[4]));
					listNotice.add(bean);
				}
				return listNotice;
			}
		});
		
		
	}

}
