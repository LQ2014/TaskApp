package com.cyancloud.dao;

import java.util.List;

import com.cyancloud.commons.dao.AbstractDao;
import com.cyancloud.model.task.TaskForward;

public interface TaskForwardDao extends AbstractDao<TaskForward> {

	public List<TaskForward> searchForwardTask(Long unitId,Long employeeId);	
		
}