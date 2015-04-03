package com.cyancloud.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cyancloud.dao.EmployeeDao;
import com.cyancloud.dao.NoticeDao;
import com.cyancloud.dao.TaskApplayDao;
import com.cyancloud.dao.TaskConsultDao;
import com.cyancloud.dao.TaskCopyDao;
import com.cyancloud.dao.TaskEvaluationDao;
import com.cyancloud.dao.TaskForwardDao;
import com.cyancloud.dao.TaskInfoDao;
import com.cyancloud.dao.UnitDao;
import com.cyancloud.model.system.Employee;
import com.cyancloud.model.system.Unit;
import com.cyancloud.model.task.TaskCopy;
import com.cyancloud.model.task.TaskEvaluation;
import com.cyancloud.model.task.TaskForward;
import com.cyancloud.model.task.TaskInfo;
import com.cyancloud.service.TaskService;
import com.cyancloud.service.model.NoticeBean;
import com.cyancloud.service.model.UnitBean;
import com.cyancloud.web.util.CloudConstant;
import com.cyancloud.web.util.EnumConstUtil;

@Service("taskService")
public class TaskServiceImpl implements TaskService {
	
	private static final Logger logger = Logger.getLogger(TaskService.class);
	
	@Autowired
	private TaskInfoDao infoDao;
	
	@Autowired
	private TaskCopyDao copyDao;
	
	@Autowired
	private TaskApplayDao applayDao;
	
	@Autowired
	private TaskConsultDao consultDao;
	
	@Autowired
	private TaskEvaluationDao evaluationDao;
	
	@Autowired
	private TaskForwardDao forwardDao;
	
	@Autowired
	private EmployeeDao employeeDao;
	
	@Autowired
	private UnitDao unitDao;
	
	@Autowired
	private NoticeDao noticeDao;

	@Override
	public Map<String, Object> issued(TaskInfo taskInfo) {
		Map<String, Object> result = new HashMap<String, Object>();
		
		taskInfo.setEnumConstState(EnumConstUtil.getEnumConstByNamespaceAndCode("FLAG_TaskState", "0"));
		taskInfo.setEnumConstTaskType(EnumConstUtil.getEnumConstByNamespaceAndCode("FLAG_TaskType", taskInfo.getTaskType()));
		taskInfo.setEnumConstIsRemind(EnumConstUtil.getEnumConstByNamespaceAndCode("FLAG_IsRemind", taskInfo.getIsRemind()));
		taskInfo.setEnumConstIssuedType(EnumConstUtil.getEnumConstByNamespaceAndCode("FLAG_IssuedType", taskInfo.getIssuedType()));
		Employee employee = employeeDao.findById(taskInfo.getIssuedPeople());
		String creater = (null == employee) ? "" : employee.getName();
		taskInfo.setCreater(creater);
		taskInfo.setCreateTime(new Date());
		this.infoDao.save(taskInfo);
		
		result.put(CloudConstant.SUCCESS, true);
		result.put(CloudConstant.CODE, CloudConstant.CODE_SUCCESS);
		result.put(CloudConstant.MESSAGE, "任务：" + taskInfo.getName() + "，下发成功！");
		return result;
	}

	@Override
	public Map<String, Object> getIssuedTask(Long unitId, Long uid) {
		Map<String, Object> result = new HashMap<String, Object>();
		List<TaskInfo> tasks = this.infoDao.getIssuedTask(unitId, uid);
		result.put(CloudConstant.SUCCESS, true);
		result.put(CloudConstant.CODE, CloudConstant.CODE_SUCCESS);
		result.put("taskList", tasks);
		return result;
	}

	@Override
	public Map<String, Object> forward(TaskForward taskForward) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Map<String, Object> copy(TaskCopy taskCopy) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Map<String, Object> getCopyTask(Long uid) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Map<String, Object> feedback(TaskInfo backTaskInfo) {
		Map<String, Object> result = new HashMap<String, Object>();
		TaskInfo taskInfo = this.infoDao.findById(backTaskInfo.getId());
		if (null != taskInfo) {
			if ("0".equals(taskInfo.getEnumConstState().getCode())
					&& (null == taskInfo.getEnumConstIsBack() || "0".equals(taskInfo.getEnumConstIsBack().getCode()))) { // 未接收，未退回的任务
				taskInfo.setEnumConstIsBack(EnumConstUtil.getEnumConstByNamespaceAndCode("FLAG_IsBack", "1")); // 退回
				taskInfo.setBackInfo(backTaskInfo.getBackInfo());
				taskInfo.setBackEmployee(this.employeeDao.findById(backTaskInfo.getBackPeople()));
				taskInfo.setUpdateTime(new Date());
				
				this.infoDao.update(taskInfo);
				
				result.put(CloudConstant.SUCCESS, true);
				result.put(CloudConstant.CODE, CloudConstant.CODE_SUCCESS);
				result.put(CloudConstant.MESSAGE, "任务：" + taskInfo.getName() + "，退回成功！");
			} else {
				result.put(CloudConstant.SUCCESS, true);
				result.put(CloudConstant.CODE, CloudConstant.CODE_SUCCESS);
				result.put(CloudConstant.MESSAGE, "任务：" + taskInfo.getName() + "，正在进行或已被退回！");
			}
		} else {
			result.put(CloudConstant.SUCCESS, false);
			result.put(CloudConstant.CODE, CloudConstant.CODE_SUCCESS);
			result.put(CloudConstant.MESSAGE, "任务信息不存在！");
		}
		return result;
	}

	@Override
	public Map<String, Object> accept(Long taskId, Long uid) {
		Map<String, Object> result = new HashMap<String, Object>();
		TaskInfo taskInfo = this.infoDao.findById(uid);
		if (null != taskInfo) {
			if ("0".equals(taskInfo.getEnumConstState().getCode())
					&& (null == taskInfo.getEnumConstIsBack() || "0".equals(taskInfo.getEnumConstIsBack().getCode()))) { // 未接收，未退回的任务
				
				taskInfo.setAcceptEmployee(this.employeeDao.findById(uid));
				taskInfo.setEnumConstState(EnumConstUtil.getEnumConstByNamespaceAndCode("FLAG_TaskState", "5")); // 正在进行
				taskInfo.setUpdateTime(new Date());
				
				this.infoDao.update(taskInfo);
				
				result.put(CloudConstant.SUCCESS, true);
				result.put(CloudConstant.CODE, CloudConstant.CODE_SUCCESS);
				result.put(CloudConstant.MESSAGE, "任务：" + taskInfo.getName() + "，接收成功！");
			} else {
				result.put(CloudConstant.SUCCESS, true);
				result.put(CloudConstant.CODE, CloudConstant.CODE_SUCCESS);
				result.put(CloudConstant.MESSAGE, "任务：" + taskInfo.getName() + "，正在进行或已被退回！");
			}
		} else {
			result.put(CloudConstant.SUCCESS, false);
			result.put(CloudConstant.CODE, CloudConstant.CODE_SUCCESS);
			result.put(CloudConstant.MESSAGE, "任务信息不存在！");
		}
		return result;
	}

	@Override
	public Map<String, Object> onkeyRemind(Long uid) {
		Map<String, Object> result = new HashMap<String, Object>();
		
		remind(uid); // 查询数据，推送提醒信息
		
		result.put(CloudConstant.SUCCESS, true);
		result.put(CloudConstant.CODE, CloudConstant.CODE_SUCCESS);
		result.put(CloudConstant.MESSAGE, "一键提醒成功！");
		return result;
	}

	private void remind(Long uid) {
		
	}

	@Override
	public Map<String, Object> view(Long state) {
		Map<String, Object> result = new HashMap<String, Object>();
		
		String stateId = EnumConstUtil.getConstId("FLAG_TaskState", String.valueOf(state));
		List<TaskInfo> list = this.infoDao.getTaskInfoByState(stateId);
		
		result.put(CloudConstant.SUCCESS, true);
		result.put(CloudConstant.CODE, CloudConstant.CODE_SUCCESS);
		result.put("taskList", list);
		return result;
	}

	@Override
	public Map<String, Object> evaluate(TaskEvaluation evaluation) {
		Map<String, Object> result = new HashMap<String, Object>();
		evaluation.setTaskInfo(this.infoDao.findById(evaluation.getTaskId()));
		evaluation.setEvaluaEmployee(this.employeeDao.findById(evaluation.getEvaluaPeople()));
		if (null != evaluation.getTaskInfo()) {
			this.evaluationDao.save(evaluation);
			result.put(CloudConstant.SUCCESS, true);
			result.put(CloudConstant.CODE, CloudConstant.CODE_SUCCESS);
			result.put(CloudConstant.MESSAGE, "任务平价成功");
		} else {
			result.put(CloudConstant.SUCCESS, false);
			result.put(CloudConstant.CODE, CloudConstant.CODE_FAIL);
			result.put(CloudConstant.MESSAGE, "任务平价失败，可能没有找到任务信息！");
		}
		return result;
	}

	@Override
	public Map<String, Object> getContacts(Long unitId) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		Unit unit = this.unitDao.findById(unitId);
		UnitBean unitBean = (null == unit) ? null : getUnitBean(unit);
		if (null != unitBean) {
			getSubUnitBeans(unitBean);
			result.put(CloudConstant.SUCCESS, true);
			result.put(CloudConstant.CODE, CloudConstant.CODE_SUCCESS);
			result.put("contactsTree", unitBean);
		} else {
			result.put(CloudConstant.SUCCESS, false);
			result.put(CloudConstant.CODE, CloudConstant.CODE_FAIL);
			result.put("message", "部门信息不存在！");
		}
		return result;
	}
	
	private UnitBean getUnitBean(Unit unit) throws Exception {
		UnitBean bean = new UnitBean();
		BeanUtils.copyProperties(bean, unit);
		return bean;
	}
	
	private List<UnitBean> getSubUnitBeans(UnitBean unitBean) throws Exception {
		List<UnitBean> unitBeans = new ArrayList<UnitBean>();
		if (null != unitBean) {
			List<Unit> units = this.unitDao.getUnitByParentId(unitBean.getId());
			List<Employee> employees = this.employeeDao.searchEmployeeByUnit(unitBean);
			employees = (null == employees) ? new ArrayList<Employee>() : employees;
			unitBean.setEmployees(employees);
			for (int i = 0; units != null && i < units.size(); ++i) {
				unitBeans.add(getUnitBean(units.get(i)));
			}
			if (null != units && units.size() > 0) {
				unitBean.setChilds(unitBeans);
				unitBean.setIsLeaf("false");
				for (int i = 0; i < unitBeans.size(); ++i) {
					unitBeans.get(i).setChilds(getSubUnitBeans(unitBeans.get(i)));
				}
			} else {
				unitBean.setChilds(new ArrayList<UnitBean>());
				unitBean.setIsLeaf("true");
			}
		}
		return unitBeans;
	}

	@Override
	public Map<String, Object> sendback(Long taskId, Long backPeople, String backInfo) {
		Map<String, Object> result = new HashMap<String, Object>();
		TaskInfo taskInfo = this.infoDao.findById(taskId);
		if (null != taskInfo) {
			if ("9".equals(taskInfo.getEnumConstState().getCode())
					&& "0".equals(taskInfo.getEnumConstIsCheck().getCode())
					&& "0".equals(taskInfo.getEnumConstIsBack().getCode())) { // 已结束，未核实，未退回的任务
				taskInfo.setEnumConstIsCheck(EnumConstUtil.getEnumConstByNamespaceAndCode("FLAG_IsCheck", "1")); // 核实
				taskInfo.setEnumConstIsBack(EnumConstUtil.getEnumConstByNamespaceAndCode("FLAG_IsBack", "1")); // 退回
				taskInfo.setBackInfo(backInfo);
				taskInfo.setBackEmployee(this.employeeDao.findById(backPeople));
				taskInfo.setUpdateTime(new Date());
				
				this.infoDao.update(taskInfo);
				
				result.put(CloudConstant.SUCCESS, true);
				result.put(CloudConstant.CODE, CloudConstant.CODE_SUCCESS);
				result.put(CloudConstant.MESSAGE, "任务：" + taskInfo.getName() + "，退回修改成功！");
			} else if ("0".equals(taskInfo.getEnumConstIsCheck().getCode())
					&& "1".equals(taskInfo.getEnumConstIsBack().getCode())) {
				result.put(CloudConstant.SUCCESS, true);
				result.put(CloudConstant.CODE, CloudConstant.CODE_SUCCESS);
				result.put(CloudConstant.MESSAGE, "任务：" + taskInfo.getName() + "未接受，直接被退回！");
			}
		} else {
			result.put(CloudConstant.SUCCESS, false);
			result.put(CloudConstant.CODE, CloudConstant.CODE_SUCCESS);
			result.put(CloudConstant.MESSAGE, "任务信息不存在！");
		}
		return result;
	}

	@Override
	public Object forwardTask(TaskForward taskForward) {
		Map map = new HashMap();
		map.put(CloudConstant.SUCCESS, Boolean.valueOf(true));
		map.put(CloudConstant.MESSAGE, "转发成功");
		taskForward.setForwardTime(new Date());
		taskForward.setTaskInfo(this.infoDao.findById(taskForward.getTaskId()));
		this.forwardDao.save(taskForward);
		return map;
	}

	@Override
	public List<TaskForward> searchForwardTask(Long unitId,Long employeeId) {
		return this.forwardDao.searchForwardTask(unitId,employeeId);
	}

	@Override
	public void copyTask(TaskCopy taskCopy) {
		taskCopy.setCopyEmployee(this.employeeDao.findById(taskCopy.getCopyPeople()));
		taskCopy.setRemindEmployee(this.employeeDao.findById(taskCopy.getRemindPeople()));
		taskCopy.setEnumConstFlagIsRemind(EnumConstUtil.getEnumConstByNamespaceAndCode("FLAG_IsRemind", taskCopy.getIsRemind()));
		taskCopy.setCopyTime(new Date());
		this.copyDao.save(taskCopy);
	}

	@Override
	public List<TaskCopy> searchCopyTask(Long uid) {
		return this.copyDao.searchCopyTask(uid);
	}

	@Override
	public Map<String, Object> searchNotice(Long uid, Long departmentId) {
		Map map = new HashMap();
		map.put(CloudConstant.SUCCESS, Boolean.valueOf(true));
		map.put(CloudConstant.MESSAGE, "查询成功");
		List<NoticeBean> listNotice = null;
		try {
			listNotice = noticeDao.searchNotice(uid,departmentId);
		} catch (Exception e) {
			e.printStackTrace();
			map.put(CloudConstant.SUCCESS, Boolean.valueOf(false));
			map.put(CloudConstant.MESSAGE, "查询失败");
		}
		map.put("listNotice", listNotice);
		return map;
	}
}
