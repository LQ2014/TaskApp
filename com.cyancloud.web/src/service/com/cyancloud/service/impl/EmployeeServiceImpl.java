package com.cyancloud.service.impl;

import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.commons.beanutils.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cyancloud.dao.EmployeeDao;
import com.cyancloud.dao.UnitDao;
import com.cyancloud.model.system.Employee;
import com.cyancloud.model.system.Unit;
import com.cyancloud.service.EmployeeService;
import com.cyancloud.service.model.EmployeeBean;
@Service("employeeService")
public class EmployeeServiceImpl implements EmployeeService {
	@Autowired
	private EmployeeDao EmployeeDao;
	
	@Autowired
	private UnitDao unitDao;
	
	@SuppressWarnings("rawtypes")
	@Override
	public List<EmployeeBean> searchEmployee() throws Exception {
		List<Employee> listEmployee = EmployeeDao.getAll();
		List<EmployeeBean> result = new ArrayList<EmployeeBean>();
		List<Unit> listUnit = unitDao.getAll();
		Map<Long,String>unitMap = new HashMap<Long,String>();
		for (Iterator it = listUnit.iterator(); it.hasNext();) {
			Unit unit = (Unit) it.next();
			unitMap.put(unit.getId(), unit.getName());
		}
		for (Iterator ite = listEmployee.iterator(); ite.hasNext();) {
			Employee employee = (Employee) ite.next();
			EmployeeBean temp = new EmployeeBean();
			BeanUtils.copyProperties(temp, employee);
			temp.setUnitName(unitMap.get(employee.getUnitId()));
			result.add(temp);
		}
		return result;
	}

}
