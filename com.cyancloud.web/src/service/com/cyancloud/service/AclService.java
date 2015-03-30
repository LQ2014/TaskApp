package com.cyancloud.service;

import java.util.Date;
import java.util.List;

import com.cyancloud.model.system.Account;
import com.cyancloud.model.system.Account2Role;
import com.cyancloud.model.system.Account2Unit;
import com.cyancloud.model.system.Config;
import com.cyancloud.model.system.Contacts;
import com.cyancloud.model.system.Employee;
import com.cyancloud.model.system.Right;
import com.cyancloud.model.system.Role;
import com.cyancloud.model.system.Unit;
import com.cyancloud.service.model.AccountBean;
import com.cyancloud.service.model.EmployeeBean;
import com.cyancloud.service.model.RoleBean;
import com.cyancloud.service.model.UnitBean;
import com.cyancloud.web.model.AccountModel;

public interface AclService {
	
	public boolean login(AccountModel model);
	
	public Account getAccountById(Long id);

	public void editAccount(Account account);
	
	public void deleteAccount(Long id);
	
	public List<AccountBean> searchAccount(AccountBean bean);
	
	public Unit getUnitById(Long id);

	public void editUnit(Unit Unit)throws Exception;
	
	public void deleteUnit(Long id);
	
	public List<UnitBean> listUnit();
	
	public List<UnitBean> listUnitTree();
	
	public Role getRoleById(Long id);
	
	public List<RoleBean> listRole();
	
	public void addRole(Role role);
	
	public void editRole(Role role);
	
	public void deleteRole(Long id);		

	public Date getLastSyncUnitTime();

	Date getLastSyncAccountTime();
	
	public Account getAccountByUcode(String ucode);
	
	public String getRoleType(Long uid);
	
	public List<Account> searchAccountByUnit(UnitBean ub);
	
	public void delAccount2Role(Long roleId);
	
	public void alloUser(Long roleId,List<String> userIdList);
	
	public Boolean checkUserAlloStatus(Long roleId,Long accountId);

	public Unit getUnitByOu(String unitOu);
	
	public void delRole2Right(Long roleId);
	
	public void alloAuth(Long roleId,String[] authIds);
	
	public Boolean checkAuthAlloStatus(Long roleId,Long rightId);
	
	public List<Account2Role> getAccount2RoleByAccountId(Long accountId);
	
	public List<Right> getFirstMenu(String ucode);
	
	public List<Right> getMenubyOrder(String ucode);
	
	public List<Role> getRoleByType(String type);
	
	public List<Account2Role> getAccount2Role(Long accountId,Long roleId);

	public void addUnit(Unit unit) throws Exception;

	public List<Account2Unit> getAccountByUnitId(Long id);

	public List<Employee> searchAccountByUnitId(Long id);

	public void deleteAccountFromUnit(Long accountId, Long unitId);

	public List<Employee> queryAccountOutUnit(Long unitId);

	public void addAcount2Unit(Long unitId, Long[] accountIds)throws Exception;	

	public List<Employee> searchLeaderOutUnit(Long unitId);

	public void doAllocationLeader2Unit(Long unitId, Long leaderId)throws Exception;
	public void addUser(Account account) throws Exception;
	
	
	public void addContacts(Contacts contacts) throws Exception;
	
	public void editContacts(Contacts contacts) throws Exception;
	public void delContacts(Long id) throws Exception;
	public Contacts getContactsByAccId(Long id);
	
	public void addEmployee(Employee employee) throws Exception;
	
	public void editEmployee(Employee employee) throws Exception;
	
	public void delteEmployee(Long id) throws Exception;
	
	public List<EmployeeBean> searchEmployee(EmployeeBean employeeBean);
	
	public Employee getEmployeeById(Long id);
	
	public void addConfig(Config config) throws Exception;
	
	public void editConfig(Config config) throws Exception;
	
	public void deleteConfig(Long id) throws Exception;
	
	public List<Config> searchConfig(Config config);

	public Config getConfigById(Long id);
}
