package com.cyancloud.dao;

import java.util.List;

import com.cyancloud.commons.dao.AbstractDao;
import com.cyancloud.model.system.Account;
import com.cyancloud.model.system.Account2Unit;
import com.cyancloud.model.system.Employee;

public interface Account2UnitDao extends AbstractDao<Account2Unit>{

	public List<Account2Unit> getAccountByUnitId(Long id);

	public List<Employee> searchAccountByUnitId(Long id);

	public void deleteAccountFromUnit(Long accountId, Long unitId);

	public List<Employee> queryAccountOutUnit(Long unitId);

	public void addAcount2Unit(Long unitId, Long[] accountIds)throws Exception;

	public List<Employee> searchLeaderOutUnit(Long unitId);

	public void allocationLeader2Unit(Long unitId, Long leaderId)throws Exception;
}
