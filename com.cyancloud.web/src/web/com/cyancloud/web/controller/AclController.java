package com.cyancloud.web.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.cyancloud.commons.web.BaseAbstractController;
import com.cyancloud.model.system.Account;
import com.cyancloud.model.system.Account2Unit;
import com.cyancloud.model.system.Config;
import com.cyancloud.model.system.Contacts;
import com.cyancloud.model.system.Employee;
import com.cyancloud.model.system.Right;
import com.cyancloud.model.system.Role;
import com.cyancloud.model.system.Role2Right;
import com.cyancloud.model.system.SystemParam;
import com.cyancloud.model.system.Unit;
import com.cyancloud.service.AclService;
import com.cyancloud.service.AuthService;
import com.cyancloud.service.SystemService;
import com.cyancloud.service.model.AccountBean;
import com.cyancloud.service.model.EmployeeBean;
import com.cyancloud.service.model.RightBean;
import com.cyancloud.service.model.RoleBean;
import com.cyancloud.service.model.UnitBean;
import com.cyancloud.web.util.ConfigUtil;
@Controller
@RequestMapping("/acl")
public class AclController extends BaseAbstractController {

	@Autowired
	AclService aclService;
	
	@Autowired
	private AuthService authService;
	
	@Autowired
	SystemService systemService;	
	
	@RequestMapping("/index.do")
	public String index(
			HttpServletRequest request, HttpServletResponse response,
			Model model) {
		//this.mailService.sendMail("shangjun@cyanway.com", "桌面申请", "aaaaaaaaaaaaa");
		return "acl/index";
	}
	
	/**
	 * list all ou
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping("/listOu.do")
	public String listOu(
			HttpServletRequest request, HttpServletResponse response,
			Model model) {
		List<UnitBean> result = new ArrayList<UnitBean>();
		List<UnitBean> unitList=this.aclService.listUnitTree();
		for(UnitBean bean:unitList){
			setUnitleaf(result,bean);
		}
		Date date = this.aclService.getLastSyncUnitTime();
		model.addAttribute("unitList", result);
		model.addAttribute("syncDate",date);
		return "acl/listOu";
	}
	
	private void setUnitleaf(List<UnitBean> units,UnitBean bean) {
		
		if(bean.getChilds()!=null && bean.getChilds().size()>0){
			bean.setIsLeaf("false");
			units.add(bean);
			for(UnitBean u:bean.getChilds()){
				setUnitleaf(units,u);
			}
		}else{
			bean.setIsLeaf("true");
			units.add(bean);
		}
		
	}
	
	private void setAuthleaf(List<RightBean> rights,RightBean bean) {
		
		if(bean.getChilds()!=null && bean.getChilds().size()>0){
			bean.setIsLeaf("false");
			rights.add(bean);
			for(RightBean u:bean.getChilds()){
				setAuthleaf(rights,u);
			}
		}else{
			bean.setIsLeaf("true");
			rights.add(bean);
		}
		
	}

	
	/**
	 * sync ou from ad
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping("/addUnit.do")
	public String addUnit(HttpServletRequest request, HttpServletResponse response,
			Model model) {		
		return "acl/addUnit";
	}
	
	@RequestMapping("/doAddUnit.do")
	public String doAddUnit(@ModelAttribute Unit unit,
			HttpServletRequest request, HttpServletResponse response,
			Model model) {
		try{
			this.aclService.addUnit(unit);
		}catch(Exception e){
			
		}
		return "acl/addUnit";
	}
	
	@RequestMapping("/editUnit.do")
	public String editUnit(@RequestParam("id") Long id,HttpServletRequest request, HttpServletResponse response,
			Model model) {	
		Unit unit = this.aclService.getUnitById(id);
		Map<String,Object> unitMap = null;
		if(unit!=null && unit.getParentId()!=null){
			unitMap = new HashMap<String,Object>();
			Unit parentUnit = this.aclService.getUnitById(unit.getParentId());
			unitMap.put("id", parentUnit.getId().toString());
			unitMap.put("value", parentUnit.getName());
		}
		model.addAttribute("unit", unit);
		model.addAttribute("unitMap", unitMap);
		return "acl/editUnit";
	}
	
	@RequestMapping("/doEditUnit.do")
	public String doEditUnit(@ModelAttribute Unit unit,
			HttpServletRequest request, HttpServletResponse response,
			Model model) {
		try{				
			this.aclService.editUnit(unit);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "acl/editUnit";
	}
	
	@RequestMapping("/checkAccount2Unit.do")
	public String checkAccount2Unit(@RequestParam("id") Long id,HttpServletRequest request, HttpServletResponse response,
			Model model) {
		Boolean flag = false;
		List<Account2Unit> listAccount2Unit = this.aclService.getAccountByUnitId(id);
		if(listAccount2Unit != null && listAccount2Unit.size() > 0) {
			flag = true;
		}
		response.setContentType("text/javascript charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		try {
			response.getWriter().print(flag);
		} catch (Exception e) {
			e.getMessage();
		}
		return null;
	}
	
	@RequestMapping("/deleteUnit.do")
	public String deleteUnit(@RequestParam("id") Long id,HttpServletRequest request,
			HttpServletResponse response){
		this.aclService.deleteUnit(id);
		request.setAttribute("message", "success");
		return "redirect:/acl/listOu.do";
	}
	
	
	@RequestMapping("/viewAccountByUnit.do")
	public String viewAccountByUnit(@RequestParam("id") Long id,HttpServletRequest request,
			HttpServletResponse response,Model model){
		Unit unit = this.aclService.getUnitById(id);
		List<Employee> listAccount = this.aclService.searchAccountByUnitId(id);	
		model.addAttribute("listAccount", listAccount);
		model.addAttribute("unit", unit);
		return "acl/listAccount2Unit";
	}	
	
	@RequestMapping("/deleteAccountFromUnit.do")
	public String deleteAccountFromUnit(@RequestParam("id") Long id,@RequestParam("unitId") Long unitId,HttpServletRequest request,
			HttpServletResponse response){		
		this.aclService.deleteAccountFromUnit(id,unitId);
		request.setAttribute("message", "success");
		return "acl/listAccount2Unit";
	}
	
	
	@RequestMapping("/addAccount2Unit.do")
	public String addAccount2Unit(@RequestParam("unitId") Long unitId,HttpServletRequest request,
			HttpServletResponse response,Model model){		
		List<Employee> listAccount = this.aclService.queryAccountOutUnit(unitId);
		Unit unit = this.aclService.getUnitById(unitId);
		model.addAttribute("listAccount", listAccount);
		model.addAttribute("unit", unit);
		return "acl/addAccount2Unit";
	}
	
	
	@RequestMapping("/doAddAcount2Unit.do")
	public String doAddAcount2Unit(@RequestParam("unitId") Long unitId,@RequestParam("accountIds[]") Long[] accountIds,HttpServletRequest request,
			 HttpServletResponse response,Model model) {		
		JSONObject json = new JSONObject();
		response.setContentType("text/javascript charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		json.put("success", true);
		try {
			 this.aclService.addAcount2Unit(unitId,accountIds);
		} catch (Exception e) {
			json.put("success", false);
		}
		try {			
			response.getWriter().print(json.toString());
		} catch (Exception e) {
			e.getMessage();
		}
		return null;
	}
	
	
	@RequestMapping("/allocationLeader2Unit.do")
	public String allocationLeader2Unit(@RequestParam("unitId") Long unitId,HttpServletRequest request,
			HttpServletResponse response,Model model){
		Unit unit = this.aclService.getUnitById(unitId);
		List<Employee> listAccount = this.aclService.searchLeaderOutUnit(unitId);	
		model.addAttribute("listAccount", listAccount);
		model.addAttribute("unit", unit);
		return "acl/allocationLeader2Unit";
	}
	
	@RequestMapping("/listUser.do")
	public String listUser(
			HttpServletRequest request, HttpServletResponse response,
			Model model) {
		List<AccountBean> accountList=this.aclService.searchAccount(null);
		model.addAttribute("accountList", accountList);
		return "acl/listUser";
	}	
	
	@RequestMapping("/doAllocationLeader2Unit.do")
	public String doAllocationLeader2Unit(@RequestParam("unitId") Long unitId,@RequestParam("leaderId") Long leaderId,HttpServletRequest request,
			 HttpServletResponse response,Model model) {		
		JSONObject json = new JSONObject();
		response.setContentType("text/javascript charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		json.put("success", true);
		try {
			 this.aclService.doAllocationLeader2Unit(unitId,leaderId);
		} catch (Exception e) {
			json.put("success", false);
		}
		try {			
			response.getWriter().print(json.toString());
		} catch (Exception e) {
			e.getMessage();
		}
		return null;
	}
	
	@RequestMapping("/searchUser.do")
	public String searchUser(
			HttpServletRequest request, HttpServletResponse response,
			Model model) {
		return "redirect:listUser";
	}
	
	
	@RequestMapping("/changeAccountState.do")
	public String changeAccountState(@RequestParam("id") Long id,
			HttpServletRequest request, HttpServletResponse response,
			Model model) {
		Account account = this.aclService.getAccountById(id);
		if(account!=null){
			account.setState(1L-account.getState());
			this.aclService.editAccount(account);
		}
		return "redirect:listUser.do";
	}
	
	@RequestMapping("/listRole.do")
	public String listRole(
			HttpServletRequest request, HttpServletResponse response,
			Model model) {
		List<RoleBean> roleList = this.aclService.listRole();
		SystemParam sp = new SystemParam();
		sp.setType(SystemParam.TYPE_ROLETYPE);
		//List<SystemParam> paramList = this.systemService.getSysParam(sp);
		request.setAttribute("roleList", roleList);
		request.setAttribute("paramList", null);
		return "acl/listRole";
	}
	
	@RequestMapping("/addRole.do")
	public String addRole(
			@ModelAttribute Role role,HttpServletRequest request, HttpServletResponse response,
			Model model) {
		String forward = "redirect:listRole.do";
		this.aclService.addRole(role);
		return forward;
	}
	
	@RequestMapping("/editRole.do")
	public String editRole(
			@ModelAttribute Role role,HttpServletRequest request, HttpServletResponse response,
			Model model) {
		this.aclService.editRole(role);
		return "redirect:listRole.do";
	}
	
	@RequestMapping("/deleteRole.do")
	public String deleteRole(
			String roleId,HttpServletRequest request, HttpServletResponse response,
			Model model) {
		this.aclService.deleteRole(Long.parseLong(roleId));
		return "redirect:listRole.do";
	}
	
	@RequestMapping("/searchRole.do")
	public String searchRole(
			HttpServletRequest request, HttpServletResponse response,
			Model model) {
		return "redirect:listRole";
	}
	
	@RequestMapping("/changeRoleState.do")
	public String changeRoleState(HttpServletRequest request,
			HttpServletResponse response, Model model) {
		String forward = "redirect:listRole.do";
		String roleId = request.getParameter("roleId");
		
		if(roleId != null) {
			Role role = this.aclService.getRoleById(Long.valueOf(roleId));
			if(role != null) {
				String state = request.getParameter("state");
				if(state != null) {
					role.setState(Long.valueOf(state));
					this.aclService.editRole(role);
				}
				
			}
		}
		return forward;
	}
	@RequestMapping("/listOuTree.do")
	public String listOuTree(
			HttpServletRequest request, HttpServletResponse response,
			Model model) {
		String unitId = request.getParameter("unitId");
		List<UnitBean> unitList=this.aclService.listUnit();
		JSONArray jsons = new JSONArray();
		for(int i=0;i<unitList.size();i++) {
			UnitBean ub = unitList.get(i);
			JSONObject json = new JSONObject();
			json.put("id", ub.getId());
			json.put("text", ub.getName());
			if(ub.getParentId() != null) {
				json.put("pid", ub.getParentId());
			}
			if(unitId != null && unitId.equals(ub.getId().toString())) {
				json.put("checked", true);
			}
			jsons.add(json);
		}
		response.setContentType("text/javascript charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		try {
			response.getWriter().print(jsons.toString());
		} catch (Exception e) {
			e.getMessage();
		}
		return null;
	}

	@RequestMapping("/listUserTree.do")
	public String listUserTree(
			HttpServletRequest request, HttpServletResponse response,
			Model model) {
		Long roleId = Long.valueOf((String)request.getParameter("roleId"));
		List<UnitBean> unitList=this.aclService.listUnit();
		JSONArray jsons = new JSONArray();
		for(int i=0;i<unitList.size();i++) {
			UnitBean ub = unitList.get(i);
			JSONObject json = new JSONObject();
			json.put("id", "unit_"+ub.getId());
			json.put("text", ub.getName());
			if(ub.getParentId() != null) {
				json.put("pid", "unit_"+ub.getParentId());
			}
			json.put("isLeaf", false);
			json.put("asyncLoad", false);
			jsons.add(json);
			List<Account> accountList=this.aclService.searchAccountByUnit(ub);
			if(accountList != null && accountList.size() > 0) {
				for(int j=0;j<accountList.size();j++) {
					Account account = accountList.get(j);
					JSONObject userJson = new JSONObject();
					userJson.put("id", "user_"+account.getId());
					userJson.put("text", account.getUname());
					userJson.put("pid", "unit_"+ub.getId());
					Boolean flag = this.aclService.checkUserAlloStatus(roleId,account.getId());
					userJson.put("checked", flag);
					jsons.add(userJson);
				}
			}
			
			
		}
		response.setContentType("text/javascript charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		try {
			response.getWriter().print(jsons.toString());
		} catch (Exception e) {
			e.getMessage();
		}
		return null;
	}
	
	@RequestMapping("/listRoleTree.do")
	public String listRoleTree(String ids,
			HttpServletRequest request, HttpServletResponse response,
			Model model) {
		List<RoleBean> roleList=this.aclService.listRole();
		JSONArray jsons = new JSONArray();
		for(int i=0;i<roleList.size();i++) {
			RoleBean ub = roleList.get(i);
			JSONObject json = new JSONObject();
			json.put("id", ub.getId());
			json.put("text", ub.getName());
			if(ids.indexOf(ub.getId().toString())!=-1){
				json.put("checked", true);
			};
			jsons.add(json);
		}
		response.setContentType("text/javascript charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		try {
			response.getWriter().print(jsons.toString());
		} catch (Exception e) {
			e.getMessage();
		}
		return null;
	}
	
	@RequestMapping("/alloUser.do")
	public String alloUser(HttpServletRequest request,
			HttpServletResponse response, Model model) {
		String forward = "redirect:/acl/listRole.do";
		try {
			String roleId = request.getParameter("roleId");
			String userId = request.getParameter("userId");
			List<String> userIdList = new ArrayList<String>();
			if(userId != null && userId.length() > 0) {
				String[] uIds = userId.split(",");
				for(int i=0;i<uIds.length;i++) {
					String uId = uIds[i];
					if(uId.contains("user_")) {
						userIdList.add(uId);
					}
					
				}
			}
			//删除此角色的关联用户
			this.aclService.delAccount2Role(Long.valueOf(roleId));
			if(userIdList.size() > 0) {
				//重新分配用户
				this.aclService.alloUser(Long.valueOf(roleId), userIdList);
			}
			
		} catch(Exception e) {
			e.getMessage();
		}
		return forward;
	}
	
	
	@RequestMapping("/listAuth.do")
	public String listAuth(HttpServletRequest request,
			HttpServletResponse response,Model model){
		List<RightBean> result = new ArrayList<RightBean>();
		List<RightBean> rightList=this.authService.listAuthTree();
		for(RightBean bean:rightList){
			setAuthleaf(result,bean);
		}
		model.addAttribute("authList", result);
		return "acl/listAuth";
	}
	@RequestMapping("/addAuth.do")
	public String addAuth(HttpServletRequest request,
			HttpServletResponse response, Model model) {
		String forward = "acl/addAuth";
		return forward;
	}
	
	@RequestMapping("/doAddAuth.do")
	public String doAddAuth(@ModelAttribute Right right,HttpServletRequest request,
			HttpServletResponse response, Model model){
		this.authService.addRight(right);
		return "redirect:/acl/listAuth.do";
	}

	@RequestMapping("/editAuth.do")
	public String editAuth(@RequestParam("id") Long id,HttpServletRequest request,
			HttpServletResponse response, Model model) {
		String forward = "acl/editAuth";
		Right right = this.authService.getRightById(id);
		model.addAttribute("right",right);
		String parentName = "";
		if(right.getParentId() != null) {
			Right parent = this.authService.getRightById(right.getParentId());
			if(parent != null) {
				parentName = parent.getName();
			}
		}
		request.setAttribute("parentName", parentName);
		return forward;
	}
	
	@RequestMapping("/doEditAuth.do")
	public String doEditRight(@ModelAttribute Right right,HttpServletRequest request,
			HttpServletResponse response){
			this.authService.editRight(right);
		return "redirect:/acl/listAuth.do";
	}
	
	
	@RequestMapping("/deleteAuth.do")
	public String deleteAuth(@RequestParam("id") Long id,HttpServletRequest request,
			HttpServletResponse response){
		this.authService.deleteRight(id);
		request.setAttribute("message", "success");
		return "redirect:/acl/listAuth.do";
	}
	
	@RequestMapping("/listAuthTree.do")
	public String listAuthTree(
			HttpServletRequest request, HttpServletResponse response,
			Model model) {
		Long roleId = 0l;
		String tempRoleId = request.getParameter("roleId");
		if(tempRoleId != null) {
			roleId = Long.valueOf(tempRoleId);
		}
		Long myId = 0l;
		String tempId = request.getParameter("myId");
		if(tempId != null) {
			myId = Long.valueOf(tempId);
		}
		List<RightBean> parentRightList = this.authService.listAuth(null);
		JSONArray jsons = new JSONArray();
		for(int i=0;i<parentRightList.size();i++) {
			RightBean pr = parentRightList.get(i);
			JSONObject json = new JSONObject();
			json.put("id", pr.getId());
			json.put("text", pr.getName());
			json.put("isLeaf", false);
			json.put("asyncLoad", false);
			jsons.add(json);
			this.putChildNode(roleId,myId,pr,jsons);
		}
		response.setContentType("text/javascript charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		try {
			response.getWriter().print(jsons.toString());
		} catch (Exception e) {
			e.getMessage();
		}
		return null;
	}
	
	private void putChildNode(Long roleId,Long myId,RightBean pr, JSONArray jsons) {
		List<RightBean> childRightList = this.authService.listAuth(pr.getId());
		if(childRightList != null && childRightList.size() > 0) {
			for(int j=0;j<childRightList.size();j++) {
				RightBean r = childRightList.get(j);
				if(myId.longValue() != r.getId()) {
					JSONObject cJson = new JSONObject();
					cJson.put("id", r.getId());
					cJson.put("text", r.getName());
					cJson.put("pid", pr.getId());
					if(roleId != 0) {
						Boolean flag1 = this.aclService.checkAuthAlloStatus(roleId,r.getId());
						cJson.put("checked", flag1);
					}
					if(r.getIsLeaf().equals("false")) {
						cJson.put("isLeaf", false);
						cJson.put("asyncLoad", false);
					}
					jsons.add(cJson);
					if(r.getIsLeaf().equals("false")) {
						this.putChildNode(roleId,myId,r,jsons);
					}
				}
				
				
			}
		}
		
	}

	@RequestMapping("/alloAuth.do")
	public String alloAuth(HttpServletRequest request,
			HttpServletResponse response, Model model) {
		String forward = "redirect:/acl/listRole.do";
		try {
			String roleId = request.getParameter("roleId");
			String authId = request.getParameter("authId");
			String[] authIds = null;
			if(authId != null && authId.length() > 0) {
				authIds = authId.split(",");
			}
			//删除此角色的关联权限
			this.aclService.delRole2Right(Long.valueOf(roleId));
			if(authIds != null && authIds.length > 0) {
				//重新分配权限
				this.aclService.alloAuth(Long.valueOf(roleId), authIds);
			}
			
		} catch(Exception e) {
			e.getMessage();
		}
		return forward;
	}
	
	@RequestMapping("/checkRole2Right.do")
	public String checkRole2Right(@RequestParam("id") Long id,HttpServletRequest request, HttpServletResponse response,
			Model model) {
		Boolean flag = false;
		List<Role2Right> r2rList = this.authService.getR2RByRigthId(id);
		if(r2rList != null && r2rList.size() > 0) {
			flag = true;
		}
		response.setContentType("text/javascript charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		try {
			response.getWriter().print(flag);
		} catch (Exception e) {
			e.getMessage();
		}
		return null;
	}
	
	
	
	@RequestMapping("/loadAuthIcon")
	public String loadAuthIcon(String id,HttpServletRequest request,
			HttpServletResponse response){
		Right right = null;
		if(id!=null){
			right = this.authService.getRightById(Long.parseLong(id));
		}		
		request.setAttribute("right", right);		
		return "acl/editAuthIcon";
	}
	
	@RequestMapping("/editAuthIcon.do")
	public void editAuthIcon(@RequestParam("id") Long id,@RequestParam("icon") String icon,HttpServletRequest request,
			HttpServletResponse response, Model model) {		
		Right right = this.authService.getRightById(id);	
		if(right!=null){
			right.setCss(icon);
			this.authService.editRight(right);
		}
		return;
	}
	
	
	/**
	 * sync ou from ad
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping("/addUser.do")
	public String addUser(HttpServletRequest request, HttpServletResponse response,
			Model model) {		
		model.addAttribute("accountType", ConfigUtil.getValDesc("account-type"));
		return "acl/addUser";
	}
	
	@RequestMapping("/doAddUser.do")
	public String doAddUser(@ModelAttribute Account account,
			HttpServletRequest request, HttpServletResponse response,
			Model model) {
		try{
			logger.debug("ucode = " + account.getUcode());
			this.aclService.addUser(account);
		}catch(Exception e){
			
		}
		return "acl/addUser";
	}
	
	@RequestMapping("/editUser.do")
	public String editUser(@RequestParam("id") Long id,HttpServletRequest request, HttpServletResponse response,
			Model model) {	
		Account account = this.aclService.getAccountById(id);
		Map<String,Object> unitMap = null;
		if(account!=null && account.getUnitId()!=null){
			unitMap = new HashMap<String,Object>();
			Unit unit = this.aclService.getUnitById(account.getUnitId());
			if (null != unit) {
				unitMap.put("id", unit.getId().toString());
				unitMap.put("value", unit.getName());
			} else {
				unitMap.put("id", "");
				unitMap.put("value", "");
			}
		}
		model.addAttribute("user", account);
		model.addAttribute("unitMap", unitMap);
		model.addAttribute("accountType", ConfigUtil.getValDesc("account-type"));
		return "acl/editUser";
	}
	
	@RequestMapping("/doEditUser.do")
	public String doEditUser(@ModelAttribute Account account,
			HttpServletRequest request, HttpServletResponse response,
			Model model) {
		try{				
			this.aclService.editAccount(account);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "acl/editUser";
	}
	
	@RequestMapping("/deleteUser.do")
	public String deleteUser(@RequestParam("id") Long id,
			HttpServletRequest request, HttpServletResponse response,
			Model model) {
		try{
			this.aclService.delContacts(id);
			this.aclService.deleteAccount(id);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "redirect:/acl/listUser.do";
	}
	
	@RequestMapping("/setContacts.do")
	public String setContacts(@RequestParam("id") Long id,
			HttpServletRequest request, HttpServletResponse response,
			Model model) {
		try{				
			Contacts contacts = this.aclService.getContactsByAccId(id);
			if (null == contacts) {
				contacts = new Contacts();
				contacts.setAccId(id);
			}
			model.addAttribute("contacts", contacts);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "acl/setContacts";
	}
	
	@RequestMapping("/doSetContacts.do")
	public String doSetContacts(@ModelAttribute Contacts contacts,
			HttpServletRequest request, HttpServletResponse response,
			Model model) {
		try{				
			this.aclService.editContacts(contacts);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "redirect:/acl/listUser.do";
	}
	
	@RequestMapping("/listEmployee.do")
	public String listEmployee(
			HttpServletRequest request, HttpServletResponse response,
			Model model) {
		List<EmployeeBean> employeeList=this.aclService.searchEmployee(null);
		model.addAttribute("employeeList", employeeList);
		return "acl/listEmployee";
	}
	
	/**
	 * sync ou from ad
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping("/addEmployee.do")
	public String addEmployee(HttpServletRequest request, HttpServletResponse response,
			Model model) {		
		return "acl/addEmployee";
	}
	
	@RequestMapping("/doAddEmployee.do")
	public String doAddEmployee(@ModelAttribute Employee employee,
			HttpServletRequest request, HttpServletResponse response,
			Model model) {
		try{
			this.aclService.addEmployee(employee);
			Account account = new Account();
			account.setEmployeeId(employee.getId());
			account.setUname(employee.getName());
			account.setEmail(employee.getEmail());
			account.setCtime(new Date());
			account.setPassword(ConfigUtil.getCfg("account_default_password"));
			try {
				DateFormat df = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
				account.setDateline(df.parse(ConfigUtil.getCfg("account_default_dateline")));
			} catch (Exception e) {
				
			}
			account.setPhone(employee.getPhone());
			account.setUnitId(employee.getUnitId());
			account.setUnitOu(employee.getUnitOu());
			account.setUcode(employee.getCode());
			this.aclService.addUser(account);
		}catch(Exception e){
			
		}
		return "acl/addEmployee";
	}
	
	@RequestMapping("/editEmployee.do")
	public String editEmployee(@RequestParam("id") Long id,HttpServletRequest request, HttpServletResponse response,
			Model model) {	
		Employee employee = this.aclService.getEmployeeById(id);
		Map<String,Object> unitMap = null;
		if(employee!=null && employee.getUnitId()!=null){
			unitMap = new HashMap<String,Object>();
			Unit unit = this.aclService.getUnitById(employee.getUnitId());
			if (null != unit) {
				unitMap.put("id", unit.getId().toString());
				unitMap.put("value", unit.getName());
			} else {
				unitMap.put("id", "");
				unitMap.put("value", "");
			}
		}
		model.addAttribute("employee", employee);
		model.addAttribute("unitMap", unitMap);
		return "acl/editEmployee";
	}
	
	@RequestMapping("/doEditEmployee.do")
	public String doEditEmployee(@ModelAttribute Employee employee,
			HttpServletRequest request, HttpServletResponse response,
			Model model) {
		try{				
			this.aclService.editEmployee(employee);
			Account account = new Account();
			account.setUname(employee.getName());
			account.setEmail(employee.getEmail());
			account.setPhone(employee.getPhone());
			account.setUnitId(employee.getUnitId());
			account.setUnitOu(employee.getUnitOu());
			account.setUcode(employee.getCode());
			account.setUpdateDate(new Date());
			this.aclService.editAccount(account);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "acl/editEmployee";
	}
	
	@RequestMapping("/deleteEmployee.do")
	public String deleteEmployee(@RequestParam("id") Long id,
			HttpServletRequest request, HttpServletResponse response,
			Model model) {
		try{
			this.aclService.delteEmployee(id);
			this.aclService.deleteAccount(id);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "redirect:/acl/listEmployee.do";
	}
	
	@RequestMapping("/isShowScore.do")
	public String isShowScore(@RequestParam("id") Long id,
			HttpServletRequest request, HttpServletResponse response,
			Model model) {
		Employee employee = this.aclService.getEmployeeById(id);
		if(employee!=null){
			if (null == employee.getIsShowScore() 
					|| 0L == employee.getIsShowScore()) {
				employee.setIsShowScore(2L);
			} else {
				employee.setIsShowScore(0L);
			}
			try {
				this.aclService.editEmployee(employee);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return "redirect:listEmployee.do";
	}
	

	@RequestMapping("/listConfig.do")
	public String listConfig(
			HttpServletRequest request, HttpServletResponse response,
			Model model) {
		List<Config> configlist =this.aclService.searchConfig(null);
		model.addAttribute("configList", configlist);
		return "acl/listConfig";
	}
	
	/**
	 * sync ou from ad
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping("/addConfig.do")
	public String addConfig(HttpServletRequest request, HttpServletResponse response,
			Model model) {		
		return "acl/addConfig";
	}
	
	@RequestMapping("/doAddConfig.do")
	public String doAddConfig(@ModelAttribute Config config,
			HttpServletRequest request, HttpServletResponse response,
			Model model) {
		try{
			this.aclService.addConfig(config);
		}catch(Exception e){
			
		}
		return "acl/addConfig";
	}
	
	@RequestMapping("/editConfig.do")
	public String editConfig(@RequestParam("id") Long id,HttpServletRequest request, HttpServletResponse response,
			Model model) {	
		Config config = this.aclService.getConfigById(id);
		model.addAttribute("config", config);
		return "acl/editConfig";
	}
	
	@RequestMapping("/doEditConfig.do")
	public String doEditConfig(@ModelAttribute Config config,
			HttpServletRequest request, HttpServletResponse response,
			Model model) {
		try{				
			this.aclService.editConfig(config);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "acl/editConfig";
	}
	
	@RequestMapping("/deleteConfig.do")
	public String deleteConfig(@RequestParam("id") Long id,
			HttpServletRequest request, HttpServletResponse response,
			Model model) {
		try{
			this.aclService.deleteConfig(id);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "redirect:/acl/listConfig.do";
	}
	
	@InitBinder
	protected void initBinder(WebDataBinder binder) {
	    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	    binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
	}
}
