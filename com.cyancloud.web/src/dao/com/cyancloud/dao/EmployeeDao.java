package com.cyancloud.dao;

import java.util.List;

import com.cyancloud.commons.dao.AbstractDao;
import com.cyancloud.model.system.Employee;
import com.cyancloud.service.model.UnitBean;

public interface EmployeeDao extends AbstractDao<Employee> {

	public List<Employee> searchEmployee(Employee employee);

	public List<Employee> searchEmployeeByUnit(UnitBean ub);
	
}
