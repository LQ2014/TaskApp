package com.cyancloud.dao;

import java.util.List;

import com.cyancloud.commons.dao.AbstractDao;
import com.cyancloud.model.task.TaskInfo;

public interface TaskInfoDao extends AbstractDao<TaskInfo> {

	List<TaskInfo> getIssuedTask(Long unitId, Long uid);

	List<TaskInfo> getTaskInfoByState(String stateId);	
		
}