package com.cyancloud.web.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.cyancloud.commons.web.BaseAbstractController;
import com.cyancloud.commons.web.SessionAttributeNames;
import com.cyancloud.model.notice.Notice;
import com.cyancloud.model.system.Account;
import com.cyancloud.model.system.Account2Role;
import com.cyancloud.model.system.Role;
import com.cyancloud.model.system.Unit;
import com.cyancloud.service.AclService;
import com.cyancloud.service.NoticeService;
import com.cyancloud.service.model.NoticeBean;
import com.cyancloud.web.util.CloudConstant;

@Controller
public class IndexController extends BaseAbstractController {	
	
	@Autowired
	AclService aclService;	
	
	@Autowired
	private NoticeService noticeService;
	

	@RequestMapping("/index.do")
	public String login(HttpServletRequest request,
			HttpServletResponse response, Model model) {
		String ucode = SessionAttributeNames.getUcode(request);
		Account account = aclService.getAccountByUcode(ucode.trim());
		String forward = "index3";
		String roleType = SessionAttributeNames.getSessionAttribute(request, "roleType");
		if (roleType.equals(CloudConstant.ROLE_TYPE_COMPANY)) {
			List<NoticeBean> listNotice = noticeService.queryListByAccount(account);
			model.addAttribute("listNotice", listNotice);
			forward = "index3";
		}
		if (roleType.equals(CloudConstant.ROLE_TYPE_SYSTEMADMIN)) {
			/*List<Event> eventList = this.eventService.searchEvent(null);
			model.addAttribute("eventList",eventList);
			
			DesktopStat ds = this.resourceService.getDesktopStat(SessionAttributeNames.getUcode(request));
			model.addAttribute("desktopStat",ds);
			
			List<ActiveDesktopStat> statList = this.resourceService.statActiveDesktop(10);
			int max=0;
			int min=0;
			if(statList!=null && statList.size()>0){
				max=statList.get(0).getCount();
				min =max;
			}
			String activeStatStr="";
			for(int i=0;i<statList.size();i++){
				ActiveDesktopStat s = statList.get(i);
				activeStatStr+=s.getCount();
				if(s.getCount()>max)
					max=s.getCount();
				if(s.getCount()<min){
					min=s.getCount();
				}
				if(i<statList.size()-1){
					activeStatStr+=",";
				}
			}
			model.addAttribute("statList",activeStatStr);
			model.addAttribute("minActive",min);
			model.addAttribute("maxActive",max);
			List<ActiveDesktopStat> activeDesktopList = new ArrayList();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			for(int i=statList.size()-1;i>=0;i--) {
				ActiveDesktopStat ad = statList.get(i);
				try {
					String time = addHour(sdf,ad.getSample(),8);
					Long millionSeconds = sdf.parse(time).getTime();
					ad.setTime(millionSeconds.toString());
				} catch (ParseException e) {
					e.getCause();
				}
				activeDesktopList.add(ad);
			}
			model.addAttribute("activeDesktopList",activeDesktopList);*/
			
			forward = "index";
		}
		if (roleType.equals(CloudConstant.ROLE_TYPE_DESKTOPADMIN)){
			/*ob.setAdmin(SessionAttributeNames.getUcode(request));
			DesktopPoolBean bean  = new DesktopPoolBean();
			bean.setUcode(SessionAttributeNames.getUcode(request));
			bean.setUnitOu(SessionAttributeNames.getDcode(request));
			List<DesktopPool> poolList=this.desktopService.searchDesktopPool(bean);
			for(DesktopPool pool:poolList){
				if(pool.getAllocatedCount()==null){
					pool.setAllocatedCount(0);
				}
			}
			model.addAttribute("poolList", poolList);*/
			forward = "index2";
		}
		
		/*List<Order> orderList = this.orderService.listOrder(ob);
		model.addAttribute("orderList", orderList);*/
		return forward;
	}
	
	private String addHour(SimpleDateFormat sdf,Date date,int hour) {
		Calendar ca = Calendar.getInstance();
		ca.setTime(date);
		ca.add(Calendar.HOUR_OF_DAY, 8);
		String time = sdf.format(ca.getTime());
		return time;
	}
	
	@RequestMapping("/myProfile.do")
	public String myProfile(
			HttpServletRequest request, HttpServletResponse response,
			Model model) {
		String userCode=(String)request.getSession().getAttribute("ucode");
		String userName = "";
		String unitName = "";
		String roleName = "";
		String phone = "";
		String email = "";
		Account account = this.aclService.getAccountByUcode(userCode);
		if(account != null) {
			userName = account.getUname();
			Unit u = this.aclService.getUnitById(account.getUnitId());
			if(u != null) {
				unitName = u.getName();
			}
			List<Account2Role> a2rList = this.aclService.getAccount2RoleByAccountId(account.getId());
			if(a2rList != null && a2rList.size() > 0) {
				for(int i=0;i<a2rList.size();i++) {
					Account2Role a2r = a2rList.get(i);
					Role r = this.aclService.getRoleById(a2r.getRoleId());
					if(r != null) {
						roleName += r.getName()+"/";
					}
					
				}
			}
			if(roleName.length() > 0) {
				roleName = roleName.substring(0,roleName.length()-1);
			}
			if(account.getPhone() != null) {
				phone = account.getPhone();
			}
			if(account.getEmail() != null) {
				email = account.getEmail();
			}
			
		}
		request.setAttribute("userCode", userCode);
		request.setAttribute("userName", userName);
		request.setAttribute("unitName", unitName);
		request.setAttribute("roleName", roleName);
		request.setAttribute("phone", phone);
		request.setAttribute("email", email);
		return "myProfile";
	}

}
