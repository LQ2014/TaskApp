package com.cyancloud.service;

import java.util.List;
import java.util.Map;

import com.cyancloud.model.task.TaskCopy;
import com.cyancloud.model.task.TaskEvaluation;
import com.cyancloud.model.task.TaskForward;
import com.cyancloud.model.task.TaskInfo;

public interface TaskService {
	
	/**
	 * 下发业务逻辑
	 * @param taskInfo
	 * @return
	 */
	Map<String, Object> issued(TaskInfo taskInfo);
	
	/**
	 * 拉取下发至部门和个人的任务信息
	 * @param unitId -部门ID
	 * @param uid -用户ID
	 * @return
	 */
	Map<String, Object> getIssuedTask(Long unitId, Long uid);
	
	/**
	 * 转发业务逻辑
	 * @param taskForward
	 * @return
	 */
	Map<String, Object> forward(TaskForward taskForward);
	
	/**
	 * 抄送业务逻辑
	 * @param taskCopy
	 * @return
	 */
	Map<String, Object> copy(TaskCopy taskCopy);
	
	/**
	 * 拉取抄送任务信息
	 * @param uid -用户ID
	 * @return
	 */
	Map<String, Object> getCopyTask(Long uid);
	
	/**
	 * 任务退回业务逻辑
	 * @param taskInfo
	 * @return
	 */
	Map<String, Object> feedback(TaskInfo taskInfo);
	
	/**
	 * 任务接收业务逻辑
	 * @param taskId -任务ID
	 * @param uid -用户ID
	 * @return
	 */
	Map<String, Object> accept(Long taskId, Long uid);
	
	/**
	 * 一键提醒业务逻辑
	 * @param uid -用户ID
	 * @return
	 */
	Map<String, Object> onkeyRemind(Long uid);
	
	/**
	 * 任务查看业务逻辑
	 * @param state -任务状态
	 * @return
	 */
	Map<String, Object> view(Long state);
	
	/**
	 * 任务评价业务逻辑
	 * @param evaluation
	 * @return
	 */
	Map<String, Object> evaluate(TaskEvaluation evaluation);
	
	/**
	 * 公司通讯录业务逻辑
	 * @param unitId -部门ID
	 * @return
	 * @throws Exception 
	 */
	Map<String, Object> getContacts(Long unitId) throws Exception;
	
	/**
	 * 返回修正业务逻辑
	 * @param taskId -任务ID
	 * @param backPeople -退回人
	 * @param backInfo -退回信息
	 * @return
	 */
	Map<String, Object> sendback(Long taskId, Long backPeople, String backInfo);

	public Object forwardTask(TaskForward taskForward);

	public List<TaskForward> searchForwardTask(Long unitId,Long employeeId);

	public void copyTask(TaskCopy taskCopy);

	public List<TaskCopy> searchCopyTask(Long uid);

	public Map<String, Object> searchNotice(Long uid, Long departmentId);

	public Map<String, Object> publishNotice(Map<String, String> map) throws Exception;
}
