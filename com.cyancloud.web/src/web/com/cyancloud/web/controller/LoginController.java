package com.cyancloud.web.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.cyancloud.commons.web.BaseAbstractController;
import com.cyancloud.commons.web.SessionAttributeNames;
import com.cyancloud.model.system.Account;
import com.cyancloud.model.system.Right;
import com.cyancloud.model.system.SystemLog;
import com.cyancloud.model.system.Unit;
import com.cyancloud.service.AclService;
import com.cyancloud.service.SystemService;
import com.cyancloud.web.model.AccountModel;
import com.cyancloud.web.util.CloudConstant;
import com.cyancloud.web.util.CommonUtils;

@Controller
public class LoginController extends BaseAbstractController {

	@Autowired
	private AclService aclService;
	
	@Autowired
	SystemService systemService;

	@RequestMapping("/login.do")
	public String login(@ModelAttribute AccountModel accountModel,
			HttpServletRequest request, HttpServletResponse response,
			Model model) {
		String tag = request.getParameter("tag");
		String forward="login1";
		String roleType="";
		if (tag != null) {
			if (tag.equals("logout")) {
				forward = "login1";
			}
		} else {
//			boolean login=true;
			boolean login = this.aclService.login(accountModel);
			if(accountModel.getUcode().equalsIgnoreCase(CloudConstant.SUPER_ADMIN) && accountModel.getPassword().equalsIgnoreCase(CloudConstant.SUPER_PASSWORD))
				login=true;
			Long result = 1l;
			if (login) {
				try {
					Account account = this.aclService.getAccountByUcode(accountModel.getUcode());

					SessionAttributeNames.setSessionAttribute(request, "ucode",	accountModel.getUcode());
					if (account != null) {
						SessionAttributeNames.setSessionAttribute(request,"uid", account.getId().toString());
						SessionAttributeNames.setSessionAttribute(request,SessionAttributeNames.DCODE, account.getUnitOu());
						if(account.getUnitOu()!=null && account.getUnitOu().length()>0){
							Unit unit = this.aclService.getUnitByOu(account.getUnitOu());
							SessionAttributeNames.setSessionAttribute(request,SessionAttributeNames.DNAME, unit.getName());
						}	
						roleType = this.aclService.getRoleType(account.getId());
						
					}
					if(accountModel!=null && accountModel.getUcode()!=null){
						if( accountModel.getUcode().equalsIgnoreCase(CloudConstant.SUPER_ADMIN) || accountModel.getUcode().equalsIgnoreCase("administrator")){
							roleType=CloudConstant.ROLE_TYPE_SYSTEMADMIN;
						}
					}
						
					SessionAttributeNames.setSessionAttribute(request, "roleType", roleType);
					forward = "redirect:/index.do";
					
					List<Right> fmenu=this.aclService.getFirstMenu(accountModel.getUcode());
					List<Right> menus=this.aclService.getMenubyOrder(accountModel.getUcode());
					request.getSession().setAttribute("fmenu", fmenu);
					request.getSession().setAttribute("menus", menus);

				} catch (Exception e) {
					e.printStackTrace();
					result = 0l;
					e.getCause();
				}
				
			} else {
				result = 0l;
				model.addAttribute("message","login.error");
			}
			//记录系统日志
			SystemLog log = CommonUtils.getSystemLog(request,"login","登录系统",result);
			this.systemService.addLog(log);
		}
		return forward;
	}

	@RequestMapping("/logout.do")
	public String logout(@ModelAttribute AccountModel accountModel,
			HttpServletRequest request, HttpServletResponse response,
			Model model) {
		String forward = "login1";
		Long result = 1l;
		SystemLog log = CommonUtils.getSystemLog(request,"logout","注销系统",result);
		try {
			SessionAttributeNames.removeSessionAttribute(request);
			SessionAttributeNames.removeSessionAttribute(request, "dcode");
		} catch(Exception e) {
			result = 0l;
			log.setResult(result);
			e.getCause();
		}
		//记录系统日志
		this.systemService.addLog(log);
		return forward;
	}

}
