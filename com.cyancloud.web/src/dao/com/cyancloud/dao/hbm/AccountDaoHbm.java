package com.cyancloud.dao.hbm;

import java.io.Serializable;
import java.sql.SQLException;
import java.util.Date;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;

import com.cyancloud.commons.dao.hibernate.BaseDaoHibernate;
import com.cyancloud.dao.AccountDao;
import com.cyancloud.model.system.Account;
import com.cyancloud.service.model.AccountBean;
import com.cyancloud.service.model.UnitBean;

public class AccountDaoHbm extends BaseDaoHibernate<Account> implements
		AccountDao {
	public AccountDaoHbm() {
		super(Account.class);
	}
	
	@Override
	public Serializable save(Account account) {
		if(account.getDomain()==null || account.getDomain().length()==0){
			account.setDomain(this.getDomain(account.getUnitOu()));
		}
		return super.save(account);
	}
	
	@Override
	public void update(Account account) {
		if(account.getDomain()==null || account.getDomain().length()==0){
			account.setDomain(this.getDomain(account.getUnitOu()));
		}
		super.update(account);
	}
	private String getDomain(String ou){
		String dc = "";
		if(ou!=null && ou.length()>0){
			String[] dcs = ou.split(",");
			for(int i=0;i<dcs.length;i++){
				if(dcs[i].indexOf("DC=")>-1){
					dc+=dcs[i].substring(3);
					if(i<dcs.length-1 && dcs[i+1].indexOf("DC=")>-1)
						dc+=".";
				}
			}
		}
		return dc;
	}
	
	public static void main(String[] args){
		String dc = "";
		String cn ="";
		if(cn!=null && cn.length()>0){
			String[] dcs = cn.split(",");
			for(int i=0;i<dcs.length;i++){
				if(dcs[i].indexOf("DC=")>-1){
					dc+=dcs[i].substring(3);
					if(i<dcs.length-1 && dcs[i+1].indexOf("DC=")>-1)
						dc+=".";
				}
			}
		}
		System.out.print("dc is:"+dc);
	}

	@SuppressWarnings("unchecked")
	@Override
	public Account findByUcode(final String ucode) {
		return this.getHibernateTemplate().execute(new HibernateCallback() {
			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				Query query = session.createQuery("from Account where ucode=:ucode");
				query.setParameter("ucode", ucode);				
				return query.uniqueResult();
			}
		});
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Account> searchAccount(Account account) {
		String hql="from Account a where 1=1";
		if(account!=null){
			if(account.getUname()!=null)
				hql+=" and a.uname like '%"+account.getUname()+"%'";
			if(account.getUname()!=null)
				hql+=" and a.loginname like '%"+account.getUcode()+"%'";
		}
			
		hql+=" order by a.uname";
		
		return (List<Account>)super.queryList(hql);
		
	}
	
	public List<Account> searchAccountByUnit(UnitBean ub) {
		String hql="from Account a where 1=1";
		if(ub!=null){
			if(ub.getId()!=null)
				hql+=" and a.unitId = "+ub.getId();
			if(ub.getOu()!=null && ub.getOu().length()>0)
				hql+=" and a.unitOu = '"+ub.getOu()+"'";
		}
			
		hql+=" order by a.uname";
		
		return (List<Account>)super.queryList(hql);
	}

	@Override
	public List<Account> listAccount(AccountBean accountBean) {
		return super.getAll();
	}

	@Override
	public Date getLastSyncTime() {
		String hql = "select max(updateDate) from Account";
		List<Date> list = (List<Date>)super.queryList(hql);
		if(list!=null && list.size()>0){
			return list.get(0);
		}else
			return null;
	}
	
	public List<Account> getAccountByGroupId(Long groupId) {
		String hql ="from Account a where a.id in (select userId from DesktopGroupAdmin dga where dga.groupId="+groupId+")";
		return (List<Account>)super.queryList(hql);
	}

}
