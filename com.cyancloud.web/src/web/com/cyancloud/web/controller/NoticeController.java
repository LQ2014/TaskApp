package com.cyancloud.web.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.cyancloud.commons.web.BaseAbstractController;
import com.cyancloud.commons.web.SessionAttributeNames;
import com.cyancloud.model.notice.Notice;
import com.cyancloud.service.EmployeeService;
import com.cyancloud.service.NoticeService;
import com.cyancloud.service.model.EmployeeBean;

@Controller
@RequestMapping("/notice")
public class NoticeController extends BaseAbstractController {
	@Autowired
	private NoticeService noticeService;	
	
	@Autowired
	private EmployeeService employeeService;
	
	
	@RequestMapping("/listNotice.do")
	public String listNotice(HttpServletRequest request,
			HttpServletResponse response, Model model) {
		List<Notice> notices = noticeService.searchNotice();		
		model.addAttribute("notices", notices);
		return "notice/listNotice";
	}
	
	@RequestMapping("/addNotice.do")
	public String addNotice(HttpServletRequest request,
			HttpServletResponse response, Model model) {		
		return "notice/addNotice";
	}
	
	@RequestMapping("/selectEmployee.do")
	public String selectEmployee(HttpServletRequest request,
			HttpServletResponse response, Model model) {
		try {
			List<EmployeeBean> listEmployee = employeeService.searchEmployee();
			model.addAttribute("listEmployee", listEmployee);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "notice/selectEmployee";
	}
	
	@RequestMapping("/doAddNotice.do")
	public String doAddNotice(HttpServletRequest request,
			HttpServletResponse response) {		
		JSONObject json = new JSONObject();
		response.setContentType("text/javascript charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		json.put("success", true);
		try {
			Map<String,String> map = new HashMap<String, String>();
			map.put("unitIds", request.getParameter("unitIds"));
			map.put("employeeIds", request.getParameter("employeeIds"));
			map.put("title", request.getParameter("noticetilte"));
			map.put("content", request.getParameter("content"));
			map.put("flagIsPublished", request.getParameter("flagIsPublished"));
			map.put("ucode", SessionAttributeNames.getUcode(request));
			noticeService.save(map);
		} catch (Exception e) {
			e.printStackTrace();
			json.put("success", false);
			json.put("msg", e.getMessage());
		}
		try {			
			response.getWriter().print(json.toString());
		} catch (Exception e) {
			e.getMessage();
		}
		return null;
	}
	
	@RequestMapping("/deleteNotice.do")
	public String deleteNotice(@RequestParam("id") String id,HttpServletRequest request,
			HttpServletResponse response) {	
		try {
			this.noticeService.deleteNotice(id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		request.setAttribute("message", "success");
		return "redirect:/notice/listNotice.do";
	}
	
	
	@RequestMapping("/isPublishNotice.do")
	public String isPublishNotice(@RequestParam("id") String id,@RequestParam("code") String code,HttpServletRequest request,
			HttpServletResponse response) {	
		try {
			this.noticeService.isPublishNotice(id,code);
		} catch (Exception e) {
			e.printStackTrace();
		}
		request.setAttribute("message", "success");
		return "redirect:/notice/listNotice.do";
	}
	
}
