package com.cyancloud.dao.hbm;

import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.hibernate.HibernateException;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate3.HibernateCallback;

import com.cyancloud.commons.dao.hibernate.BaseDaoHibernate;
import com.cyancloud.dao.Account2UnitDao;
import com.cyancloud.dao.EmployeeDao;
import com.cyancloud.dao.UnitDao;
import com.cyancloud.model.system.Account2Unit;
import com.cyancloud.model.system.Employee;
import com.cyancloud.model.system.Unit;
import com.cyancloud.web.util.CommonUtils;

public class Account2UnitDaoHbm extends BaseDaoHibernate<Account2Unit> implements
	Account2UnitDao {
	
	@Autowired
	private UnitDao unitDao;
	
	@Autowired
	private EmployeeDao employeeDao;

	@Override
	public List<Account2Unit> getAccountByUnitId(Long id) {
		return (List<Account2Unit>)this.queryList(" from Account2Unit o where o.unitId ='"+id+"' ");
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public List<Employee> searchAccountByUnitId(final Long id) {
		return (List<Employee>)this.getHibernateTemplate().executeFind(new HibernateCallback() {
			@Override
			public Object doInHibernate(Session session)throws HibernateException, SQLException {
				StringBuffer sql = new StringBuffer();				
				sql.append("	SELECT							");
				sql.append("		ac.id,						");
				sql.append("		ac.code,					");
				sql.append("		ac.name,					");
				sql.append("		ac.phone,					");
				sql.append("		ac.unit_ou,					");
				sql.append("		ac.email					");
				sql.append("	FROM							");
				sql.append("		t_res_employee	ac,			");
				sql.append("		t_res_employee2unit a2u		");
				sql.append("	WHERE							");
				sql.append("		a2u.KF_EMPLOYEE_ID = ac.id	");
				sql.append("	and	a2u.UNIT_ID = :unitId		");
				SQLQuery query = session.createSQLQuery(sql.toString());
				query.setParameter("unitId", id);
				List<Object[]> rs = query.list();
				List<Employee> listAccount = new ArrayList<Employee>();
				for (Object[] data : rs) {
					Employee account = new Employee();
					account.setId(Long.parseLong(CommonUtils.fixnull(data[0])));
					account.setCode(String.valueOf(CommonUtils.fixnull(data[1])));
					account.setName(String.valueOf(CommonUtils.fixnull(data[2])));
					account.setPhone(String.valueOf(CommonUtils.fixnull(data[3])));
					account.setUnitOu(String.valueOf(CommonUtils.fixnull(data[4])));
					account.setEmail(String.valueOf(CommonUtils.fixnull(data[5])));
					listAccount.add(account);
				}
				return listAccount;
			}
			
		});
			
	}

	@Override
	public void deleteAccountFromUnit(Long accountId, Long unitId) {
		this.executeHql("delete from Account2Unit o where o.employeeId = ? and o.unitId=?", new Object[]{accountId,unitId});
		
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public List<Employee> queryAccountOutUnit(final Long unitId) {
		return (List<Employee>)this.getHibernateTemplate().executeFind(new HibernateCallback() {
			@Override
			public Object doInHibernate(Session session)throws HibernateException, SQLException {
				StringBuffer sql = new StringBuffer();				
				sql.append("	SELECT								");
				sql.append("		ac.id,							");
				sql.append("		ac.code,						");
				sql.append("		ac.name,						");
				sql.append("		ac.phone,						");
				sql.append("		ac.unit_ou,						");
				sql.append("		ac.email						");
				sql.append("	FROM								");
				sql.append("		t_res_employee	ac where			");
				sql.append("	NOT EXISTS (							");
				sql.append("		SELECT								");
				sql.append("			*								");
				sql.append("		FROM								");
				sql.append("			t_res_employee2unit a2u			");
				sql.append("		WHERE								");
				sql.append("			a2u.KF_EMPLOYEE_ID = ac.id		");
				sql.append("		AND a2u.unit_id = :unitId			");
				sql.append("	)										");
				SQLQuery query = session.createSQLQuery(sql.toString());
				query.setParameter("unitId", unitId);
				List<Object[]> rs = query.list();
				List<Employee> listAccount = new ArrayList<Employee>();
				for (Object[] data : rs) {
					Employee account = new Employee();
					account.setId(Long.parseLong(CommonUtils.fixnull(data[0])));
					account.setCode(String.valueOf(CommonUtils.fixnull(data[1])));
					account.setName(String.valueOf(CommonUtils.fixnull(data[2])));
					account.setPhone(String.valueOf(CommonUtils.fixnull(data[3])));
					account.setUnitOu(String.valueOf(CommonUtils.fixnull(data[4])));
					account.setEmail(String.valueOf(CommonUtils.fixnull(data[5])));
					listAccount.add(account);
				}
				return listAccount;
			}
			
		});
	}

	@Override
	public void addAcount2Unit(Long unitId, Long[] accountIds) throws Exception {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		String createDate = format.format(new Date());
		String sql = "insert into t_res_employee2unit(ID,UNIT_ID,KF_EMPLOYEE_ID,CREATE_DATE)values";
		for(int i=0;i<accountIds.length;i++){
			sql+="('"+UUID.randomUUID().toString().replace("-", "")+"','"+unitId+"','"+accountIds[i]+"','"+createDate+"'),";
		}		
		sql = sql.substring(0,sql.lastIndexOf(","));		
		this.executeSqlUpdate(sql);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Employee> searchLeaderOutUnit(final Long unitId) {
		return (List<Employee>)this.getHibernateTemplate().executeFind(new HibernateCallback() {
			@Override
			public Object doInHibernate(Session session)throws HibernateException, SQLException {
				StringBuffer sql = new StringBuffer();				
				sql.append("	SELECT								");
				sql.append("		ac.id,							");
				sql.append("		ac.code,						");
				sql.append("		ac.name,						");
				sql.append("		ac.phone,						");
				sql.append("		ac.unit_ou,						");
				sql.append("		ac.email						");
				sql.append("	FROM								");
				sql.append("		t_res_employee	ac where		");
				sql.append("	NOT EXISTS (						");
				sql.append("		SELECT							");
				sql.append("			*							");
				sql.append("		FROM							");
				sql.append("			t_res_unit unit				");
				sql.append("		WHERE							");
				sql.append("			unit.fk_account_id = ac.id	");
				sql.append("		AND unit.id = :unitId			");
				sql.append("	)									");
				SQLQuery query = session.createSQLQuery(sql.toString());
				query.setParameter("unitId", unitId);
				List<Object[]> rs = query.list();
				List<Employee> listAccount = new ArrayList<Employee>();
				for (Object[] data : rs) {
					Employee account = new Employee();
					account.setId(Long.parseLong(CommonUtils.fixnull(data[0])));
					account.setCode(String.valueOf(CommonUtils.fixnull(data[1])));
					account.setName(String.valueOf(CommonUtils.fixnull(data[2])));
					account.setPhone(String.valueOf(CommonUtils.fixnull(data[3])));
					account.setUnitOu(String.valueOf(CommonUtils.fixnull(data[4])));
					account.setEmail(String.valueOf(CommonUtils.fixnull(data[5])));
					listAccount.add(account);
				}
				return listAccount;
			}
			
		});
	}

	@Override
	public void allocationLeader2Unit(Long unitId, Long leaderId)
			throws Exception {
		Employee leader = this.employeeDao.findById(leaderId);
		System.out.println("=================="+leader.getName());
		Unit unit = this.unitDao.findById(unitId);
		unit.setLeader(leader);
		this.unitDao.update(unit);
		
	}	
	
}
