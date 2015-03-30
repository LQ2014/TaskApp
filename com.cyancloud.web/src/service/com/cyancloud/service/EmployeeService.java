package com.cyancloud.service;

import java.util.List;

import com.cyancloud.service.model.EmployeeBean;

public interface EmployeeService {

	public List<EmployeeBean> searchEmployee()throws Exception;

}
