package com.cyancloud.web.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cyancloud.commons.web.BaseAbstractController;
import com.cyancloud.commons.web.SessionAttributeNames;
import com.cyancloud.model.system.Account;
import com.cyancloud.model.task.TaskCopy;
import com.cyancloud.model.task.TaskEvaluation;
import com.cyancloud.model.task.TaskForward;
import com.cyancloud.model.task.TaskInfo;
import com.cyancloud.service.AclService;
import com.cyancloud.service.TaskService;
import com.cyancloud.web.model.AccountModel;
import com.cyancloud.web.util.CloudConstant;

@Controller
@RequestMapping("/task")
public class TaskController extends BaseAbstractController {
	@Autowired
	private AclService aclService;
	
	@Autowired
	private TaskService taskService;
	
	@RequestMapping("/login.do")
	@ResponseBody
	public Object login(@ModelAttribute AccountModel accountModel,
			HttpServletRequest request, HttpServletResponse response) {
		Map map = new HashMap();
		map.put("success", Boolean.valueOf(false));
		if (StringUtils.isEmpty(accountModel.getUcode())) {
			map.put("message", "登录失败：用户名不能为空");
			return map;
		}
		if (StringUtils.isEmpty(accountModel.getPassword())) {
			map.put("message", "登录失败：用户密码不能为空");
			return map;
		}

		Account account = this.aclService.getAccountByUcode(accountModel.getUcode());
		if (account == null) {
			map.put("message", "不存在该用户");
			return map;
		}
		if (!account.getPassword().equals(accountModel.getPassword())) {
			map.put("message", "用户密码错误");
			return map;
		}
		SessionAttributeNames.setSessionAttribute(request, "ucode",
				account.getUcode());
		SessionAttributeNames.setSessionAttribute(request, "uid", account
				.getId().toString());
		map.put("message", "登录成功");
		map.put("success", Boolean.valueOf(true));
		return map;
	}

	@RequestMapping("/logout.do")
	@ResponseBody
	public Object logout(@RequestParam(value="ucode", required=false) String ucode,HttpServletRequest request,
			HttpServletResponse response) {
		Map map = new HashMap();
		map.put("success", Boolean.valueOf(false));
		if(StringUtils.isEmpty(ucode)){
			map.put(CloudConstant.CODE, "1");
			return map;
		}
		try {
			SessionAttributeNames.removeSessionAttribute(request);
			map.put("success", Boolean.valueOf(true));
			return map;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return map;
	}
	
	
	@RequestMapping("/issued.do")
	@ResponseBody
	public Object issued(@ModelAttribute TaskInfo taskInfo, 
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			result = taskService.issued(taskInfo);
		} catch (Throwable e) {
			setError(result, e.getMessage());
		}
		return result;
	}
	
	private void setError(Map<String, Object> result, String errorMsg) {
		result.put(CloudConstant.SUCCESS, false);
		result.put(CloudConstant.MESSAGE, errorMsg);
		result.put(CloudConstant.CODE, CloudConstant.CODE_ERROR);
	}

	@RequestMapping("/getIssuedTask.do")
	@ResponseBody
	public Object getIssuedTask(@RequestParam Long unitId, @RequestParam Long uid, 
			HttpServletRequest request, HttpServletResponse response) {
		return this.taskService.getIssuedTask(unitId, uid);
	}

	@RequestMapping("/forward.do")
	@ResponseBody
	public Object forward(@ModelAttribute TaskForward taskForward, 
			HttpServletRequest request, HttpServletResponse response) {
		Object rs = new HashMap();
		try {
			rs = this.taskService.forwardTask(taskForward);
		} catch (Exception e) {
			e.printStackTrace();
			setError((Map<String, Object>)rs, "转发失败");
		}
		return rs;
	}
	
	
	@RequestMapping("/getForwardTask.do")
	@ResponseBody
	public Object getForwardTask(@RequestParam(value="unitId",required=false) Long unitId, @RequestParam(value="employeeId",required=false) Long employeeId,
			HttpServletRequest request, HttpServletResponse response) {
		Map map = new HashMap();
		List<TaskForward> listForwardTask = new ArrayList<TaskForward>();
		try {
			listForwardTask = this.taskService.searchForwardTask(unitId,employeeId);
			map.put(CloudConstant.MESSAGE, "查询成功");
			map.put(CloudConstant.SUCCESS, Boolean.valueOf(true));
		} catch (Exception e) {
			setError(map, "转发失败");
		}
		map.put("list", listForwardTask);
		return map;
	}	
	

	@RequestMapping("/copy.do")
	@ResponseBody
	public Object copy(@ModelAttribute TaskCopy taskCopy, 
			HttpServletRequest request, HttpServletResponse response) {
		Map map = new HashMap();
		try {
			this.taskService.copyTask(taskCopy);
			map.put(CloudConstant.SUCCESS, Boolean.valueOf(true));
			map.put(CloudConstant.MESSAGE, "任务抄送成功");
		} catch (Exception e) {
			e.printStackTrace();
			this.setError(map, "任务抄送失败");
		}
		return map;
	}

	@RequestMapping("/getCopyTask.do")
	@ResponseBody
	public Object getCopyTask(@RequestParam Long uid, 
			HttpServletRequest request, HttpServletResponse response) {
		Map map = new HashMap();
		List<TaskCopy> listForwardTask = new ArrayList<TaskCopy>();
		try {
			listForwardTask = this.taskService.searchCopyTask(uid);
			map.put(CloudConstant.MESSAGE, "查询成功");
			map.put(CloudConstant.SUCCESS, Boolean.valueOf(true));
		} catch (Exception e) {
			setError(map, "转发失败");
		}
		map.put("list", listForwardTask);
		return map;
	}

	@RequestMapping("/feedback.do")
	@ResponseBody
	public Object feedback(@ModelAttribute TaskInfo taskInfo, @RequestParam Long taskId,
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			taskInfo.setId(taskId);
			result = taskService.feedback(taskInfo);
		} catch (Throwable e) {
			setError(result, e.getMessage());
		}
		return result;
	}

	@RequestMapping("/accept.do")
	@ResponseBody
	public Object accept(@RequestParam Long taskId, @RequestParam Long uid, 
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			result = taskService.accept(taskId, uid);
		} catch (Throwable e) {
			setError(result, e.getMessage());
		}
		return result;
	}

	@RequestMapping("/onkeyRemind.do")
	@ResponseBody
	public Object onkeyRemind(@RequestParam Long uid, 
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			result = taskService.onkeyRemind(uid);
		} catch (Throwable e) {
			setError(result, e.getMessage());
		}
		return result;
	}

	@RequestMapping("/view.do")
	@ResponseBody
	public Object view(@RequestParam Long state, 
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			result = taskService.view(state);
		} catch (Throwable e) {
			setError(result, e.getMessage());
		}
		return result;
	}

	@RequestMapping("/evaluate.do")
	@ResponseBody
	public Object evaluate(@ModelAttribute TaskEvaluation evaluation, 
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			result = taskService.evaluate(evaluation);
		} catch (Throwable e) {
			setError(result, e.getMessage());
		}
		return result;
	}

	@RequestMapping("/getContacts.do")
	@ResponseBody
	public Object getContacts(@RequestParam Long unitId, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			result = taskService.getContacts(unitId);
		} catch (Throwable e) {
			setError(result, e.getMessage());
		}
		return result;
	}

	@RequestMapping("/sendback.do")
	@ResponseBody
	public Object sendback(@RequestParam Long taskId, @RequestParam Long backPeople,
			@RequestParam String backInfo, HttpServletRequest request, 
			HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			result = taskService.sendback(taskId, backPeople, backInfo);
		} catch (Throwable e) {
			setError(result, e.getMessage());
		}
		return result;
	}
	
	@InitBinder
	protected void initBinder(WebDataBinder binder) {
	    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
	    binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
	}
}
