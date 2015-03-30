package com.cyancloud.dao.hbm;

import java.util.List;

import com.cyancloud.commons.dao.hibernate.BaseDaoHibernate;
import com.cyancloud.dao.EmployeeDao;
import com.cyancloud.model.system.Account;
import com.cyancloud.model.system.Employee;
import com.cyancloud.service.model.UnitBean;

public class EmployeeDaoHbm extends BaseDaoHibernate<Employee> implements EmployeeDao {

	@SuppressWarnings("unchecked")
	@Override
	public List<Employee> searchEmployee(Employee employee) {
		String hql="from Employee a where 1=1";
		if(employee!=null){
			if(employee.getName()!=null)
				hql+=" and a.name like '%"+employee.getName()+"%'";
			if(employee.getNickname()!=null)
				hql+=" and a.nickname like '%"+employee.getNickname()+"%'";
		}
			
		hql+=" order by a.name";
		
		return (List<Employee>)super.queryList(hql);
		
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<Employee> searchEmployeeByUnit(UnitBean ub) {
		String hql="from Employee a where 1=1";
		if(ub!=null){
			if(ub.getId()!=null)
				hql+=" and a.unitId = "+ub.getId();
			if(ub.getOu()!=null && ub.getOu().length()>0)
				hql+=" and a.unitOu = '"+ub.getOu()+"'";
		}
			
		hql+=" order by a.name";
		
		return (List<Employee>)super.queryList(hql);
	}
	
}
