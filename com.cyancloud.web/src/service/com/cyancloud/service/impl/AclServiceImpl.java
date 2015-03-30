package com.cyancloud.service.impl;

import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.commons.beanutils.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cyancloud.dao.Account2RoleDao;
import com.cyancloud.dao.Account2UnitDao;
import com.cyancloud.dao.AccountDao;
import com.cyancloud.dao.ConfigDao;
import com.cyancloud.dao.ContactsDao;
import com.cyancloud.dao.EmployeeDao;
import com.cyancloud.dao.RightDao;
import com.cyancloud.dao.Role2RightDao;
import com.cyancloud.dao.RoleDao;
import com.cyancloud.dao.UnitDao;
import com.cyancloud.model.system.Account;
import com.cyancloud.model.system.Account2Role;
import com.cyancloud.model.system.Account2Unit;
import com.cyancloud.model.system.Config;
import com.cyancloud.model.system.Contacts;
import com.cyancloud.model.system.Employee;
import com.cyancloud.model.system.Right;
import com.cyancloud.model.system.Role;
import com.cyancloud.model.system.Role2Right;
import com.cyancloud.model.system.Unit;
import com.cyancloud.service.AclService;
import com.cyancloud.service.model.AccountBean;
import com.cyancloud.service.model.EmployeeBean;
import com.cyancloud.service.model.RoleBean;
import com.cyancloud.service.model.UnitBean;
import com.cyancloud.web.model.AccountModel;
import com.cyancloud.web.util.CloudConstant;
import com.cyancloud.web.util.ConfigUtil;

@Service("aclService")
public class AclServiceImpl implements AclService {
	@Autowired
	AccountDao accountDao;
	@Autowired
	UnitDao unitDao;
	@Autowired
	RoleDao roleDao;
	@Autowired
	Account2RoleDao a2rDao;
	@Autowired
	private Role2RightDao r2rDao;
	@Autowired
	RightDao rightDao;
	
	@Autowired
	private Account2UnitDao account2UnitDao;
	
	@Autowired
	private ContactsDao contactsDao;
	
	@Autowired
	private EmployeeDao employeeDao;
	
	@Autowired
	private ConfigDao configDao;
	
	@Override
	public boolean login(AccountModel model) {
		return true;
	}

	@Override
	public Account getAccountById(Long id) {
		return this.accountDao.findById(id);
	}
	
	@Override
	public Account getAccountByUcode(String ucode) {

		return this.accountDao.findByUcode(ucode);

	}

	@Override
	public void editAccount(Account account) {
		this.accountDao.update(account);
	}

	@Override
	public void deleteAccount(Long id) {
		Account account = this.getAccountById(id);
		if(account!=null)
			this.accountDao.delete(account);
	}

	@Override
	public List<AccountBean> searchAccount(AccountBean bean) {
		List<AccountBean> result = new ArrayList<AccountBean>();
		List<Account> list =  this.accountDao.searchAccount(bean);
		Map<Long, Unit> unitMap = new HashMap<Long, Unit>();// 构建unitmap
		List<Unit> poList = this.unitDao.getAll();// 得到所有unit po
		for (Unit u : poList) {
			unitMap.put(u.getId(), u);
		}
		
		for(Account a:list){
			AccountBean temp = new AccountBean();
			try {
				BeanUtils.copyProperties(temp, a);
				Unit u = unitMap.get(temp.getUnitId());
				if(u!=null) {
					String deptName = u.getName();
					Unit parentUnit = unitMap.get(u.getParentId());
					if (parentUnit != null) {
						deptName += "（" + parentUnit.getName() + "）";
					}
					temp.setDeptName(deptName);
				}
				temp.setTypeName(ConfigUtil.getDesc("account-type", String.valueOf(a.getType())));
				result.add(temp);
			} catch (IllegalAccessException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (InvocationTargetException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}
		return result;
	}

	@Override
	public Unit getUnitById(Long id) {
		return this.unitDao.findById(id);
	}

	@Override
	public void editUnit(Unit unit)throws Exception {
		Unit baseUnit = this.getUnitById(unit.getId());
		if(unit.getParentId()!=null && unit.getId().intValue()==unit.getParentId().intValue()){
			unit.setParentId(baseUnit.getParentId());
		}
		baseUnit.setName(unit.getName());
		baseUnit.setNote(unit.getNote());
		baseUnit.setParentId(unit.getParentId());
		this.unitDao.update(baseUnit);
	}

	@Override
	public void deleteUnit(Long id) {
		Unit unit = this.getUnitById(id);
		if(unit!=null)
			this.unitDao.delete(unit);
	}

	@Override
	public Role getRoleById(Long id) {
		return this.roleDao.getById(id);
	}

	@Override
	public List<RoleBean> listRole() {
		List<RoleBean> list = new ArrayList();
		List<Role> roleList = this.roleDao.listRole();
		if(roleList != null && roleList.size() > 0) {
			for(int i=0;i<roleList.size();i++) {
				Role role = roleList.get(i);
				RoleBean rb = new RoleBean();
				try {
					BeanUtils.copyProperties(rb, role);
				} catch (Exception e) {
					e.printStackTrace();
				}
				List<Account2Role> a2rList = this.a2rDao.getAccount2Role(role.getId());
				//SystemParam p = new SystemParam();
				//p.setValue(role.getType());
				//List<SystemParam> spList = this.systemParamDao.getSysParam(p);
				//if(spList != null && spList.size() > 0) {
					//SystemParam sp = spList.get(0);
					//rb.setRoleType(sp.getDescription());
				//}
				if(a2rList != null && a2rList.size() > 0) {
					int userNumber = a2rList.size();
					rb.setUserNumber(userNumber);
				}
				list.add(rb);
			}
		}
		return list;
	}

	@Override
	public List<UnitBean> listUnit() {
		List<UnitBean> result = new ArrayList<UnitBean>();
		HashMap<Long, String> map = new HashMap<Long, String>();
		List<Unit> list = this.unitDao.getAll();
		for (Unit u : list) {
			map.put(u.getId(), u.getName());
		}
		for (Unit u : list) {
			UnitBean ub = new UnitBean();
			try {
				BeanUtils.copyProperties(ub, u);
				if (ub.getParentId() != null)
					ub.setParentName(map.get(ub.getParentId()));
				result.add(ub);
			} catch (IllegalAccessException e) {
				e.printStackTrace();
			} catch (InvocationTargetException e) {
				e.printStackTrace();
			}
		}
		return result;
	}
	@Override
	public List<UnitBean> listUnitTree() {
		List<UnitBean> result = new ArrayList<UnitBean>();
		
		List<Unit> units = this.unitDao.getAllInOrder("name");
		for(Unit u:units){
			if(u.getParentId()==null){
				UnitBean bean = new UnitBean();
				try {
					BeanUtils.copyProperties(bean, u);
					this.cascadeOuTree(bean,units);
					result.add(bean);
				} catch (IllegalAccessException e) {
					// TODO Auto-generated catch block
//					e.printStackTrace();
				} catch (InvocationTargetException e) {
					// TODO Auto-generated catch block
//					e.printStackTrace();
				}
				
			}
		}
		
		return result;
	}
	
	private void cascadeOuTree(UnitBean bean, List<Unit> units) throws IllegalAccessException, InvocationTargetException {
		List<UnitBean> childs = new ArrayList<UnitBean>();
		for(Unit u:units){
			if(u.getParentId()!=null && u.getParentId().intValue()==bean.getId().intValue()){
				UnitBean cb = new UnitBean();
				BeanUtils.copyProperties(cb, u);
				childs.add(cb);
				this.cascadeOuTree(cb, units);
			}
		}
		bean.setChilds(childs);
	}

	public void addRole(Role role) {
		this.roleDao.save(role);
	}
	public void editRole(Role role) {
		this.roleDao.update(role);
	}	

	@Override
	public Date getLastSyncUnitTime() {
		return this.unitDao.getLastSyncUnitTime();
	}
	
	@Override
	public Date getLastSyncAccountTime() {
		return this.accountDao.getLastSyncTime();
	}

	@Override
	public void deleteRole(Long id) {
		Role role = this.getRoleById(id);
		if(role!=null)
			this.roleDao.delete(role);
	}

	@Override
	public String getRoleType(Long uid) {
		String type="user";
		String types="";
		List<Role> roles = this.roleDao.getRoleByAccountId(uid);
		for (Iterator iterator = roles.iterator(); iterator.hasNext();) {
			Role role = (Role) iterator.next();
			System.out.println("****************************"+role.getName());
		}
		if(roles!=null && roles.size()>0){
			for(Role role:roles){
				types+=role.getType()+",";
			}
		}
		if(types.indexOf(CloudConstant.ROLE_TYPE_SYSTEMADMIN)>=0)
			return CloudConstant.ROLE_TYPE_SYSTEMADMIN;
		if(types.indexOf(CloudConstant.ROLE_TYPE_DESKTOPADMIN)>=0)
			return CloudConstant.ROLE_TYPE_DESKTOPADMIN;
		if(types.indexOf(CloudConstant.ROLE_TYPE_COMPANY)>=0){
			return CloudConstant.ROLE_TYPE_COMPANY;
		}
		if(types.length()==0){
			Role role = this.roleDao.findByProperty("type", CloudConstant.ROLE_TYPE_USER);
			if(role!=null){
				Account2Role ar = new Account2Role(uid,role.getId());
				this.a2rDao.save(ar);
			}
			
		}
		return type;
	}
	
	@Override
	public List<Account> searchAccountByUnit(UnitBean ub) {
		List<Account> list =  this.accountDao.searchAccountByUnit(ub);
		return list;
	}
	
	@Override
	public void delAccount2Role(Long roleId) {
		List<Account2Role> a2rs = this.a2rDao.getAccount2Role(roleId);
		if(a2rs != null && a2rs.size() > 0) {
			this.a2rDao.deleteAll(a2rs);
		}
	}
	
	@Override
	public void alloUser(Long roleId,List<String> userIdList) {
		Role role = getRoleById(roleId);
		if(role != null) {
			for(int i=0;i<userIdList.size();i++) {
				String uId = userIdList.get(i);
				uId = uId.substring(uId.indexOf("_")+1,uId.length());
				Account account = this.getAccountById(Long.valueOf(uId));
				if(account != null) {
					Account2Role a2r = new Account2Role();
					a2r.setRoleId(role.getId());
					a2r.setAccountId(account.getId());
					this.a2rDao.save(a2r);
				}
			}
		}
		
	}
	
	@Override
	public Boolean checkUserAlloStatus(Long roleId,Long accountId) {
		return this.a2rDao.checkUserAlloStatus(roleId, accountId);
	}

	@Override
	public Unit getUnitByOu(String unitOu) {
		return this.unitDao.findByProperty("ou", unitOu);
	}
	
	@Override
	public void delRole2Right(Long roleId) {
		List<Role2Right> r2rs = this.r2rDao.getR2RByRoleId(roleId);
		if(r2rs != null && r2rs.size() > 0) {
			this.r2rDao.deleteAll(r2rs);
		}
	}
	
	@Override
	public void alloAuth(Long roleId,String[] authIds) {
		Role role = getRoleById(roleId);
		if(role != null) {
			for(int i=0;i<authIds.length;i++) {
				String id = authIds[i];
				Right r = this.rightDao.findById(Long.valueOf(id));
				if(r != null) {
					Role2Right r2r = new Role2Right();
					r2r.setRoleId(role.getId());
					r2r.setRightId(r.getId());
					this.r2rDao.save(r2r);
					//判断并分配父目录权限
					this.checkAndAlloParentAuth(role,r,authIds);
					
				}
			}
		}
	}
	
	private void checkAndAlloParentAuth(Role role,Right r,String[] authIds) {
		if(r.getParentId() != null) {
			String pId = r.getParentId().toString();
			if(!pId.equals("")) {
				boolean flag = false;
				// 转换为list
		        List<String> tempList = Arrays.asList(authIds);
		        if(tempList.contains(r.getParentId())){
		        	flag = true;
		        }
				if(!flag) {
					Boolean isExits = this.r2rDao.checkAuthAlloStatus(role.getId(), r.getParentId());
					if(!isExits) {
						Role2Right r2r = new Role2Right();
						r2r.setRoleId(role.getId());
						r2r.setRightId(r.getParentId());
						this.r2rDao.save(r2r);
					}
				}
			}
		}
		
	}

	@Override
	public Boolean checkAuthAlloStatus(Long roleId,Long rightId) {
		return this.r2rDao.checkAuthAlloStatus(roleId, rightId);
	}
	
	@Override
	public List<Account2Role> getAccount2RoleByAccountId(Long accountId) {
		return this.a2rDao.getAccount2RoleByAccountId(accountId);
	}

	@Override
	public List<Right> getFirstMenu(String ucode) {
		if(ucode.equals(CloudConstant.SUPER_ADMIN)){
			return this.rightDao.getFirstMenu(null);
		}
		List<Right> result = new ArrayList<Right>();
		Account account = this.accountDao.findByUcode(ucode);
		if(account!=null){
			result = this.rightDao.getFirstMenu(account.getId());
		}
		return result;
	}

	@Override
	public List<Right> getMenubyOrder(String ucode) {
		if(ucode.equals(CloudConstant.SUPER_ADMIN)){
			return this.rightDao.getMenu(null);
		}
		List<Right> result = new ArrayList<Right>();
		Account account = this.accountDao.findByUcode(ucode);
		if(account!=null){
			result = this.rightDao.getMenu(account.getId());
		}
		return result;
	}
	
	@Override
	public List<Role> getRoleByType(String type) {
		return this.roleDao.getRoleByType(type);
	}
	
	public List<Account2Role> getAccount2Role(Long accountId,Long roleId) {
		return this.a2rDao.getAccount2Role(accountId, roleId);
	}

	@Override
	public void addUnit(Unit unit) throws Exception{
		if(unit.getParentId()==null){
			Account account = new Account();
			account.setUcode(unit.getName());
			account.setUname(unit.getName());
			account.setPassword("123456");
			accountDao.save(account);
		}
		this.unitDao.save(unit);
		
	}

	@Override
	public List<Account2Unit> getAccountByUnitId(Long id) {
		List<Account2Unit> result = this.account2UnitDao.getAccountByUnitId(id);
		return result;
	}

	@Override
	public List<Employee> searchAccountByUnitId(Long id) {		
		return (List<Employee>)this.account2UnitDao.searchAccountByUnitId(id);
	}

	@Override
	public void addUser(Account account) throws Exception {
		this.accountDao.save(account);
	}

	@Override
	public void addContacts(Contacts contacts) throws Exception {
		this.contactsDao.save(contacts);
	}

	@Override
	public void editContacts(Contacts contacts) throws Exception {
		this.contactsDao.saveOrUpdate(contacts);
	}

	@Override
	public void delContacts(Long id) throws Exception {
		Contacts contacts = this.contactsDao.findById(id);
		this.contactsDao.delete(contacts);
	}

	@Override
	public Contacts getContactsByAccId(Long id) {
		return this.contactsDao.findById(id);
	}

	@Override
	public void deleteAccountFromUnit(Long accountId, Long unitId) {
		this.account2UnitDao.deleteAccountFromUnit(accountId,unitId);
		
	}

	@Override
	public List<Employee> queryAccountOutUnit(Long unitId) {
		return (List<Employee>)this.account2UnitDao.queryAccountOutUnit(unitId);
	}

	@Override
	public void addAcount2Unit(Long unitId, Long[] accountIds) throws Exception {
		if(unitId==null || accountIds==null){
			throw new Exception();
		}
		this.account2UnitDao.addAcount2Unit(unitId,accountIds);
	}

	@Override
	public List<Employee> searchLeaderOutUnit(Long unitId) {
		return (List<Employee>)this.account2UnitDao.searchLeaderOutUnit(unitId);
	}

	@Override
	public void doAllocationLeader2Unit(Long unitId, Long leaderId) throws Exception{
		if(unitId==null || leaderId==null){
			throw new Exception();
		}
		this.account2UnitDao.allocationLeader2Unit(unitId,leaderId);
	}

	@Override
	public void addEmployee(Employee employee) throws Exception {
		this.employeeDao.save(employee);
	}

	@Override
	public void editEmployee(Employee employee) throws Exception {
		this.employeeDao.update(employee);
	}

	@Override
	public void delteEmployee(Long id) throws Exception {
		Employee employee = this.employeeDao.findById(id);
		if (null != employee) {
			this.employeeDao.delete(employee);
		}
	}
	
	@Override
	public Employee getEmployeeById(Long id) {
		return this.employeeDao.findById(id);
	}

	@Override
	public List<EmployeeBean> searchEmployee(EmployeeBean employeeBean) {
		List<EmployeeBean> result = new ArrayList<EmployeeBean>();
		List<Employee> list =  this.employeeDao.searchEmployee(employeeBean);
		Map<Long, Unit> unitMap = new HashMap<Long, Unit>();// 构建unitmap
		List<Unit> poList = this.unitDao.getAll();// 得到所有unit po
		for (Unit u : poList) {
			unitMap.put(u.getId(), u);
		}
		
		for(Employee emp:list){
			EmployeeBean temp = new EmployeeBean();
			try {
				BeanUtils.copyProperties(temp, emp);
				Unit u = unitMap.get(temp.getUnitId());
				if(u!=null) {
					String deptName = u.getName();
					Unit parentUnit = unitMap.get(u.getParentId());
					if (parentUnit != null) {
						deptName += "（" + parentUnit.getName() + "）";
					}
					temp.setDeptName(deptName);
				}
				result.add(temp);
			} catch (IllegalAccessException e) {
				e.printStackTrace();
			} catch (InvocationTargetException e) {
				e.printStackTrace();
			}
			
		}
		return result;
	}

	@Override
	public void addConfig(Config config) throws Exception {
		this.configDao.save(config);
	}

	@Override
	public void editConfig(Config config) throws Exception {
		this.configDao.update(config);
	}

	@Override
	public void deleteConfig(Long id) throws Exception {
		Config config = this.configDao.findById(id);
		this.configDao.delete(config);
	}

	@Override
	public List<Config> searchConfig(Config config) {
		return this.configDao.searchConfig(config);
	}
	
	@Override
	public Config getConfigById(Long id) {
		return this.configDao.findById(id);
	}
}
