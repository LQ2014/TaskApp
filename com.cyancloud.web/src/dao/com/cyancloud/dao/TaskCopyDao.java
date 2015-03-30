package com.cyancloud.dao;

import java.util.List;

import com.cyancloud.commons.dao.AbstractDao;
import com.cyancloud.model.task.TaskCopy;

public interface TaskCopyDao extends AbstractDao<TaskCopy> {

	public List<TaskCopy> searchCopyTask(Long uid);	
		
}