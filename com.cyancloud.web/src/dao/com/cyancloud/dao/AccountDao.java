package com.cyancloud.dao;

import java.util.Date;
import java.util.List;

import com.cyancloud.commons.dao.AbstractDao;
import com.cyancloud.model.system.Account;
import com.cyancloud.service.model.AccountBean;
import com.cyancloud.service.model.UnitBean;

public interface AccountDao extends AbstractDao<Account>
{

	public Account findByUcode(String ucode);

	public List<Account> searchAccount(Account account);

	public List<Account> listAccount(AccountBean accountBean);

	public Date getLastSyncTime();
	
	public List<Account> searchAccountByUnit(UnitBean ub);
	
	public List<Account> getAccountByGroupId(Long groupId);

	
}
